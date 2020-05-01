using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using AuthorizeNet.Api.Controllers;
using AuthorizeNet.Api.Contracts.V1;
using AuthorizeNet.Api.Controllers.Bases;

namespace ECart.Controllers
{
    public class OrdersController : Controller
    {
        // GET: Orders
        public ActionResult Checkout()
        {

            return View();
        }

        [HttpPost]
        public ActionResult Checkout(string cardNumber, DateTime expirationDate, string cardCode,
            string firstName, string lastName, string address, string city, string zip)
        {

            #region cc

            ApiOperationBase<ANetApiRequest, ANetApiResponse>.RunEnvironment = AuthorizeNet.Environment.SANDBOX;

            // define the merchant information (authentication / transaction id)
            ApiOperationBase<ANetApiRequest, ANetApiResponse>.MerchantAuthentication = new merchantAuthenticationType()
            {
                name = "5m9JuX5a",
                ItemElementName = ItemChoiceType.transactionKey,
                Item = "3uA3H8968GjC69f7",
            };

            var creditCard = new creditCardType
            {
                cardNumber = cardNumber,
                expirationDate = expirationDate.ToString("MMyy"),
                cardCode = cardCode
            };

            var billingAddress = new customerAddressType
            {
                firstName = firstName,
                lastName = lastName,
                address = address,
                city = city,
                zip = zip
            };

            //standard api call to retrieve response
            var paymentType = new paymentType { Item = creditCard };

            // Add line Items

            var cart = BL.Cart.Get();

            var lineItems = new lineItemType[cart.Items.Count];

            decimal amount = 0.0M;

            for (int i = 0; i < cart.Items.Count; i++)
            {
                lineItems[i] = new lineItemType
                {
                    itemId = cart.Items[i].Product.Id.ToString(),
                    name = cart.Items[i].Product.Name,
                    quantity = cart.Items[i].Quantity,
                    unitPrice = new Decimal(cart.Items[i].Product.Price.Value)
                };

                amount += Convert.ToDecimal( cart.Items[i].Product.Price.Value);
            }        

            var transactionRequest = new transactionRequestType
            {
                transactionType = transactionTypeEnum.authCaptureTransaction.ToString(),    // charge the card

                amount = amount,
                payment = paymentType,
                billTo = billingAddress,
                lineItems = lineItems
            };

            var request = new createTransactionRequest { transactionRequest = transactionRequest };

            // instantiate the controller that will call the service
            var controller = new createTransactionController(request);
            controller.Execute();

            // get the response from the service (errors contained if any)
            var response = controller.GetApiResponse();

            // validate response
            if (response != null)
            {
                if (response.messages.resultCode == messageTypeEnum.Ok)
                {
                    if (response.transactionResponse.messages != null)
                    {
                        Console.WriteLine("Successfully created transaction with Transaction ID: " + response.transactionResponse.transId);
                        Console.WriteLine("Response Code: " + response.transactionResponse.responseCode);
                        Console.WriteLine("Message Code: " + response.transactionResponse.messages[0].code);
                        Console.WriteLine("Description: " + response.transactionResponse.messages[0].description);
                        Console.WriteLine("Success, Auth Code : " + response.transactionResponse.authCode);

                        var db = new ShoppingCartEntities();

                        Order order = new Order();
                        order.CustomerId = Convert.ToInt32(Session["id"]);
                        order.OrderDate = DateTime.Now;
                        order.OrderStatus = 1;  //1 shayad pending hay
                        order.OrderDetails = new List<OrderDetail>();

                        foreach (var item in cart.Items)
                        {
                            order.OrderDetails.Add(new OrderDetail()
                            {
                                Amount = item.Product.Price,
                                Quantity = item.Quantity,
                                ProductId = item.Product.Id
                            });
                        }
                        db.Orders.Add(order);
                        db.SaveChanges();

                        return RedirectToAction("Index", "Home");
                    }
                    else
                    {
                        Console.WriteLine("Failed Transaction.");
                        if (response.transactionResponse.errors != null)
                        {
                            // Console.WriteLine("Error Code: " + response.transactionResponse.errors[0].errorCode);
                            Console.WriteLine("Error message: " + response.transactionResponse.errors[0].errorText);

                            ViewBag.error = response.transactionResponse.errors[0].errorText;
                        }
                    }
                }
                else
                {
                    Console.WriteLine("Failed Transaction.");
                    if (response.transactionResponse != null && response.transactionResponse.errors != null)
                    {
                        // Console.WriteLine("Error Code: " + response.transactionResponse.errors[0].errorCode);
                        Console.WriteLine("Error message: " + response.transactionResponse.errors[0].errorText);
                        ViewBag.error = response.transactionResponse.errors[0].errorText;
                    }
                    else
                    {
                        // Console.WriteLine("Error Code: " + response.messages.message[0].code);
                        Console.WriteLine("Error message: " + response.messages.message[0].text);
                        ViewBag.error = response.messages.message[0].text;
                    }
                }
            }
            else
            {
                Console.WriteLine("Null Response.");
                ViewBag.error = "Null response";
            }


            #endregion



            return View();
        }
 
    }
}