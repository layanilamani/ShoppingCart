using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ECart.Controllers
{
    public class AdminDashboardController : Controller
    {
        // GET: AdminDashboard
        public ActionResult Index()
        {

            if (Session["usertypeid"] == null || Convert.ToInt32(Session["usertypeid"]) != 1 )
            {
                return RedirectToAction("index", "Account");
            }
            return View();
        }
    }
}