using BTNhom3_CNPM.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BTNhom3_CNPM.Controllers
{
    public class TinhToanController : Controller
    {
        QLRauEntities db = new QLRauEntities();
        // GET: TinhToan
        public ActionResult Index()
        {

            var model = new ThongKe()
            {
                DonHang = ThongKeDonHang(),
                SanPham = ThongKeSanPham(),
                KhachHang = ThongKeKhachHang(),
                NhanVien = ThongKeNhanVien(),
            };
            return View(model);
        }
        public int ThongKeDonHang()
        {
            int ddh = db.HoaDons.Count();
            return ddh;
        }

        public int ThongKeSanPham()
        {
            int ddh = db.SanPhams.Count();
            return ddh;
        }

        public int ThongKeKhachHang()
        {
            int ddh = db.KhachHangs.Count();
            return ddh;
        }

        public int ThongKeNhanVien()
        {
            int ddh = db.NhanViens.Count();
            return ddh;
        }

        public ActionResult DoanhThu()
        {
            DateTime fromDay = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);

            DateTime toDay = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);

            ViewBag.DoanhThuThang = db.HoaDons.Where(x => x.NgayDatHang >= fromDay && x.NgayDatHang <= toDay && x.TinhTrang == "Duyệt").Sum(x => (float?)x.ThanhToan) ?? 0;

            ViewBag.DoanhThuNgay = db.HoaDons.Where(x => x.NgayDatHang.Equals(DateTime.Today) && x.TinhTrang == "Duyệt").Sum(x => (float?)x.ThanhToan) ?? 0;

            ViewBag.HoaDonNgay = db.HoaDons.Where(x => x.NgayDatHang.Equals(DateTime.Today)).Count();

            return View();
        }
    }
}