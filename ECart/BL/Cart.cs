using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ECart.BL
{
    public class Cart
    {
        public List<CartItem> Items { get; set; }

        public static Cart Get()
        {
            return (Cart)HttpContext.Current.Session["cart"];
        }

        public static void AddToCart(int quantity, int productid)
        {
            var db = new ShoppingCartEntities();

            Cart cart = (Cart)HttpContext.Current.Session["cart"];

            var product = db.Products.Find(productid);

            var item = new CartItem();
            item.Product = product;
            item.Quantity = quantity;

            cart.Items.Add(item);

            HttpContext.Current.Session["cart"] = cart;
        }
    }
}