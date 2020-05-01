using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;

namespace ECart.Controllers
{
    public class AccountController : Controller
    {
        ShoppingCartEntities  db = new ShoppingCartEntities();
        // GET: Account
        public ViewResult Index()
        {
            //Session["ref"] = Request.UrlReferrer.ToString(); 
            return View();
        }

        [HttpPost]
        public ActionResult Signin(string Email, string Password)
        {
            var user = db.Users.FirstOrDefault(f => f.Email == Email && f.Password == Password);

            if (user!=null)
            {

                Session["id"] = user.Id;
                Session["usertypeid"] = user.UserTypeId;

                if (user.UserTypeId == 1)
                {
                    
                    return RedirectToAction("Index", "AdminDashboard");
                }
                else if (user.UserTypeId == 2)
                {
                    if (!String.IsNullOrEmpty(Convert.ToString(Session["ref"])))
                    {
                        return Redirect(Session["ref"].ToString());
                    }
                    else
                    {
                        return RedirectToAction("Index", "Home");
                    }                    
                }                
            }
            else
            {
                ViewBag.error = "inalid login/password";

            }
            return View("Index");
        }

        [HttpPost]
        public ActionResult Signup(string Name, string Email, string Password)
        {
            
            var user = new User();
            user.Name = Name;
            user.Email = Email;
            user.Password = Password;
            user.UserTypeId = 2; // 2 for Buyer

            db.Users.Add(user);

            db.SaveChanges();

            return RedirectToAction("Index", "Home");
            //return View();
        }

        public ActionResult ChangePassword()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ChangePassword(string Email, string OldPassword, string NewPassword, string NewPasswordConfirm)
        {
            if (NewPassword != NewPasswordConfirm) // uss ka new password match nahin kara raha .
            {
                ViewBag.Error = "New Password does not match.";
                return View();
            }
            var user = db.Users.FirstOrDefault(f => f.Email == Email && f.Password == OldPassword);

            if (user!=null) // agar user mil gaya.
            {
                user.Password = NewPassword;
                db.SaveChanges();
                return RedirectToAction("Index", "Home");
            }
            else // nahin mila
            {
                ViewBag.Error = "Please provide correct Email/ Old Password";
                return View();
            }           
        }

        public ActionResult InformAdmin()
        {
            var users = db.Users.ToList();

            for (int i = 0; i < users.Count; i++)
            {
                var fromaddress = "layani.lamani@gmail.com";
                var subject = "testing mail";
                var body = "<h1>This is testing body of testing mail, regards, mazhar karimi</h1>";

                var host = ConfigurationManager.AppSettings["host"];
                var port = 587; //465
                var username = "layani.lamani@gmail.com";
                var password = "KM^XY12"; //replace it with actual password

                //simple mail transfer protocol

                var client = new System.Net.Mail.SmtpClient(host, port);
                client.Credentials = new NetworkCredential(username, password);
                client.EnableSsl = true;

                MailMessage msg = new MailMessage(fromaddress, users[i].Email);
                msg.Subject = subject;
                msg.Body = body;
                msg.IsBodyHtml = true;

                client.Send(msg);
            }

            return View();

        }

        public ActionResult Logout()
        {
            Session.Clear();
            Session.Abandon();
            return RedirectToAction("Index", "Home");
        }
    }
}