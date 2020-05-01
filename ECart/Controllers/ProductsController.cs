using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using ECart;

using System.IO;
using System.Text;

namespace ECart.Controllers
{
    public class ProductsController : Controller
    {
        private ShoppingCartEntities db = new ShoppingCartEntities();


        public ActionResult GetCart()
        {
            ViewBag.cart = Session["cart"];
            return View();
        }

        [HttpGet]
        public ActionResult Search(string keyword)
        {
            var products = db.Products.Where(p =>
            p.Name.Contains(keyword)
            || p.Details.Contains(keyword)
            || p.Category.Name.Contains(keyword)
            || p.Brand.Name.Contains(keyword)
            ).ToList();

            ViewBag.products = products;

            return View();
        }

        // GET: Products
        public ActionResult Index()
        {
            var products = db.Products.Include(p => p.Brand).Include(p => p.Category);
            return View(products.ToList());
        }

        public ActionResult export()
        {
            var products = db.Products.Select(s => new { s.Id, s.Name, s.Price });

            var sb = new StringBuilder();

            sb.AppendLine("Id, Name, Price");
            foreach (var item in products)
            {
                sb.AppendLine(item.Id + "," + item.Name + "," + item.Price);
            }

            byte[] data = UTF8Encoding.UTF8.GetBytes(sb.ToString());

            return File(data, "text/csv", "products.csv");
        }

        public ActionResult AddToCart(int quantity, int productid)
        {
            BL.Cart.AddToCart(quantity, productid);

            return RedirectToAction("Index", "Home");
        }

        public ViewResult ProductDetail(int productid)
        {
            var product = db.Products.Find(productid);

            ViewBag.product = product;

            return View();
        }

        // GET: Products/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // GET: Products/Create
        public ActionResult Create()
        {
            ViewBag.BrandId = new SelectList(db.Brands, "Id", "Name");
            ViewBag.CategoryId = new SelectList(db.Categories, "Id", "Name");
            return View();
        }

        // POST: Products/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,Name,Price,CategoryId,Details,BrandId")] Product product)
        {
            if (ModelState.IsValid)
            {

                for (int i = 0; i < Request.Files.Count; i++)
                {
                    var file = Request.Files[i];

                    var filename = Server.MapPath("~") + "\\uploaded\\" + file.FileName;

                    file.SaveAs(filename);

                    product.ProductImages.Add(new ProductImage() { ImageName = file.FileName });
                }

                db.Products.Add(product);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.BrandId = new SelectList(db.Brands, "Id", "Name", product.BrandId);
            ViewBag.CategoryId = new SelectList(db.Categories, "Id", "Name", product.CategoryId);
            return View(product);
        }

        // GET: Products/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            ViewBag.BrandId = new SelectList(db.Brands, "Id", "Name", product.BrandId);
            ViewBag.CategoryId = new SelectList(db.Categories, "Id", "Name", product.CategoryId);
            return View(product);
        }

        // POST: Products/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,Name,Price,CategoryId,Details,BrandId")] Product product)
        {
            if (ModelState.IsValid)
            {
                db.Entry(product).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.BrandId = new SelectList(db.Brands, "Id", "Name", product.BrandId);
            ViewBag.CategoryId = new SelectList(db.Categories, "Id", "Name", product.CategoryId);
            return View(product);
        }

        // GET: Products/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // POST: Products/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Product product = db.Products.Find(id);
            db.Products.Remove(product);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
