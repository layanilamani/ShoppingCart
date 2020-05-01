using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ECart.Controllers
{
    public class ContactUsController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        
        [HttpPost]
        public ActionResult Index(string Name, string Email, string Message)
        {
            return View();
        }

    }
}