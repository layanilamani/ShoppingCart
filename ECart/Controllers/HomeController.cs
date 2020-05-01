using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ECart.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            var db = new ShoppingCartEntities();
            ViewBag.categories = db.Categories.ToList();
            ViewBag.brands = db.Brands.Where(b=> b.Products.Count > 0);
            ViewBag.products = db.Products.ToList();

            return View();
        }

          
    }
}