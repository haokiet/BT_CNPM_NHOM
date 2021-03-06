using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using BTNhom3_CNPM.Models;

namespace BTNhom3_CNPM.Controllers
{
    public class SanPhamsController : Controller
    {
        private QLRauEntities db = new QLRauEntities();

        // GET: SanPhams
        public ActionResult XuatSanPham()
        {
            var sanPhams = db.SanPhams.Include(s => s.Loai).Include(s => s.NCC);
            return View(sanPhams.ToList());
        }

        public ActionResult Index()
        {
            var sanPhams = db.SanPhams.Include(s => s.Loai).Include(s => s.NCC);
            return View(sanPhams.ToList());
        }

        // GET: SanPhams/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SanPham sanPham = db.SanPhams.Find(id);
            if (sanPham == null)
            {
                return HttpNotFound();
            }
            return View(sanPham);
        }
        string LayMaSP()
        {
            var maMax = db.SanPhams.ToList().Select(n => n.MaSP).Max();
            int maSP = int.Parse(maMax.Substring(2)) + 1;
            string SP = String.Concat("00", maSP.ToString());
            return "SP" + SP.Substring(maSP.ToString().Length - 1);
        }
   
        [HttpGet]
        public ActionResult TimKiem_SanPham(string maSP = "", string TenSP = "",string maNCC= "",string maLoai= "", string giaMin = "", string giaMax = "")
        {
            string min = giaMin, max = giaMax;
            
            ViewBag.maSP = maSP;
            ViewBag.TenSP = TenSP;
            ViewBag.giaMin=giaMin;

            ViewBag.MaNCC = new SelectList(db.NCCs, "MaNCC", "TenNCC");
            ViewBag.MaLoai = new SelectList(db.Loais, "MaLoai", "TenLoai");
            var sp = db.SanPhams.SqlQuery("SANPHAM_TimKiem'" + maSP + "',N'" + TenSP + "',N'" + giaMin + "','" + max+"','"+ maLoai + "',N'" + maNCC + "N'");
            if (sp.Count() == 0)
                ViewBag.TB = "Không có thông tin tìm kiếm.";
            return View(sp.ToList());
        }
        // GET: SanPhams/Create
        public ActionResult Create()
        {
            ViewBag.MaSP = LayMaSP();
            ViewBag.MaLoai = new SelectList(db.Loais, "MaLoai", "TenLoai");
            ViewBag.MaNCC = new SelectList(db.NCCs, "MaNCC", "TenNCC");
            return View();
        }

        // POST: SanPhams/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MaSP,MaNCC,MaLoai,TenSP,MoTaSP,AnhDaiDien,DonGia,DonViTinh")] SanPham sanPham)
        {
            //System.Web.HttpPostedFileBase Avatar;
            var imgNV = Request.Files["Avatar"];
            //Lấy thông tin từ input type=file có tên Avatar
            string postedFileName = System.IO.Path.GetFileName(imgNV.FileName);
            //Lưu hình đại diện về Server
            var path = Server.MapPath("/Images/" + postedFileName);
            imgNV.SaveAs(path);
            if (ModelState.IsValid)
            {
                sanPham.MaSP=LayMaSP();
                sanPham.AnhDaiDien = postedFileName;
                db.SanPhams.Add(sanPham);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.MaLoai = new SelectList(db.Loais, "MaLoai", "TenLoai", sanPham.MaLoai);
            ViewBag.MaNCC = new SelectList(db.NCCs, "MaNCC", "TenNCC", sanPham.MaNCC);
            return View(sanPham);
        }

        // GET: SanPhams/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SanPham sanPham = db.SanPhams.Find(id);
            if (sanPham == null)
            {
                return HttpNotFound();
            }
            ViewBag.MaLoai = new SelectList(db.Loais, "MaLoai", "TenLoai", sanPham.MaLoai);
            ViewBag.MaNCC = new SelectList(db.NCCs, "MaNCC", "TenNCC", sanPham.MaNCC);
            return View(sanPham);
        }

        // POST: SanPhams/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MaSP,MaNCC,MaLoai,TenSP,MoTaSP,AnhDaiDien,DonGia,DonViTinh")] SanPham sanPham)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sanPham).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MaLoai = new SelectList(db.Loais, "MaLoai", "TenLoai", sanPham.MaLoai);
            ViewBag.MaNCC = new SelectList(db.NCCs, "MaNCC", "TenNCC", sanPham.MaNCC);
            return View(sanPham);
        }

        // GET: SanPhams/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SanPham sanPham = db.SanPhams.Find(id);
            if (sanPham == null)
            {
                return HttpNotFound();
            }
            return View(sanPham);
        }

        // POST: SanPhams/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            SanPham sanPham = db.SanPhams.Find(id);
            db.SanPhams.Remove(sanPham);
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
