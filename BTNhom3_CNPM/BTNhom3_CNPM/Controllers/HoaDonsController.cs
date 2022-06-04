﻿using System;
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
    public class HoaDonsController : Controller
    {
        private QLRauEntities db = new QLRauEntities();
        public ActionResult XuatHoaDon()
        {
            var hoaDons = db.HoaDons.Include(h => h.KhachHang).Include(h => h.NhanVien).Include(h => h.NhanVien1);
            return View(hoaDons.ToList());
        }
        // GET: HoaDons
        public ActionResult Index()
        {
            var hoaDons = db.HoaDons.Include(h => h.KhachHang).Include(h => h.NhanVien).Include(h => h.NhanVien1);
            return View(hoaDons.ToList());
        }

        // GET: HoaDons/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            HoaDon hoaDon = db.HoaDons.Find(id);
            if (hoaDon == null)
            {
                return HttpNotFound();
            }
            return View(hoaDon);
        }

        // GET: HoaDons/Create
        public ActionResult Create()
        {
            ViewBag.MaKH = new SelectList(db.KhachHangs, "MaKH", "HoKH");
            ViewBag.MaNVDuyet = new SelectList(db.NhanViens, "MaNV", "TenDangNhap");
            ViewBag.MaNVGiaoHang = new SelectList(db.NhanViens, "MaNV", "TenDangNhap");
            return View();
        }

        // POST: HoaDons/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "SoHD,MaKH,MaNVDuyet,MaNVGiaoHang,DiaChiGiaoHang,TinhTrang,NgayDatHang,NgayGiaoHang")] HoaDon hoaDon)
        {
            if (ModelState.IsValid)
            {
                db.HoaDons.Add(hoaDon);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.MaKH = new SelectList(db.KhachHangs, "MaKH", "HoKH", hoaDon.MaKH);
            ViewBag.MaNVDuyet = new SelectList(db.NhanViens, "MaNV", "TenDangNhap", hoaDon.MaNVDuyet);
            ViewBag.MaNVGiaoHang = new SelectList(db.NhanViens, "MaNV", "TenDangNhap", hoaDon.MaNVGiaoHang);
            return View(hoaDon);
        }

        // GET: HoaDons/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            HoaDon hoaDon = db.HoaDons.Find(id);
            if (hoaDon == null)
            {
                return HttpNotFound();
            }
            ViewBag.MaKH = new SelectList(db.KhachHangs, "MaKH", "HoKH", hoaDon.MaKH);
            ViewBag.MaNVDuyet = new SelectList(db.NhanViens, "MaNV", "TenDangNhap", hoaDon.MaNVDuyet);
            ViewBag.MaNVGiaoHang = new SelectList(db.NhanViens, "MaNV", "TenDangNhap", hoaDon.MaNVGiaoHang);
            return View(hoaDon);
        }

        // POST: HoaDons/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "SoHD,MaKH,MaNVDuyet,MaNVGiaoHang,DiaChiGiaoHang,TinhTrang,NgayDatHang,NgayGiaoHang")] HoaDon hoaDon)
        {
            if (ModelState.IsValid)
            {
                db.Entry(hoaDon).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MaKH = new SelectList(db.KhachHangs, "MaKH", "HoKH", hoaDon.MaKH);
            ViewBag.MaNVDuyet = new SelectList(db.NhanViens, "MaNV", "TenDangNhap", hoaDon.MaNVDuyet);
            ViewBag.MaNVGiaoHang = new SelectList(db.NhanViens, "MaNV", "TenDangNhap", hoaDon.MaNVGiaoHang);
            return View(hoaDon);
        }

        // GET: HoaDons/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            HoaDon hoaDon = db.HoaDons.Find(id);
            if (hoaDon == null)
            {
                return HttpNotFound();
            }
            return View(hoaDon);
        }

        // POST: HoaDons/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            HoaDon hoaDon = db.HoaDons.Find(id);
            db.HoaDons.Remove(hoaDon);
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
