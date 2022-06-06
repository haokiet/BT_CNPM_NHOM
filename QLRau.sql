create database QLRau
go
use QLRau
go
create table NhanVien(	MaNV varchar(10) primary key,
						TenDangNhap varchar(50) not null,
						MatKhau varchar(20) not null,
						HoNV nvarchar(20) not null,
						TenNV nvarchar(20) not null,
						NgaySinh date ,
						GioiTinh bit DEFAULT(1),
						NgayLamViec date not null,
						DiaChi nvarchar(100),
						SoDT varchar(15),
						Luong int)
GO
create table NCC(	MaNCC varchar(10) primary key,
					TenNCC nvarchar(50) not null,
					DiaChi nvarchar(100) not null,
					Email varchar(100) not null,
					SoDT varchar(15) )
GO

create table Loai(	MaLoai varchar(10) primary key,
					TenLoai nvarchar(50) not null)
GO

create table KhachHang(	MaKH varchar(10) primary key,
						HoKH nvarchar(20) not null,
						TenKH nvarchar(20) not null,
						SoDT varchar(15) not null,
						DiaChi nvarchar(100),
						GioiTinh bit DEFAULT(1),
						TenDN varchar(50) not null,
						MatKhau varchar(20) not null)
GO

create table HoaDon(	SoHD varchar(10) primary key,
						MaKH varchar(10) references KhachHang(MaKH) not null,
						MaNVDuyet varchar(10) references NhanVien(MaNV) not null,
						MaNVGiaoHang varchar(10) references NhanVien(MaNV) not null,
						DiaChiGiaoHang nvarchar(100) not null,
						TinhTrang nvarchar(20) not null,
						NgayDatHang date not null,
						NgayGiaoHang date not null,
						ThanhToan float)

GO
create table SanPham(	MaSP varchar(10) primary key,
						MaNCC varchar(10) references NCC(MaNCC) not null,
						MaLoai varchar(10) references Loai(MaLoai) not null,
						TenSP nvarchar(100) not null,
						MoTaSP nvarchar(500),
						AnhDaiDien  Nvarchar(50),
						DonGia int,
						DonViTinh nvarchar(10))
GO

create table CTHoaDon(	SoHD varchar(10) references HoaDon(SoHD),
						MaSP varchar(10) references SanPham(MaSP),
						SoLuong int,
						DonGia int,
						PRIMARY KEY(SoHD,MaSP))
GO
create table ThamSo(	MaTS varchar(10) primary key,
						TenTS nvarchar(100) not null,
						DonViTinh nvarchar(20),
						GiaTri int,
						TinhTrang bit DEFAULT(1))
GO


GO
INSERT INTO dbo.NhanVien (MaNV, TenDangNhap, MatKhau, HoNV, TenNV, SoDT, DiaChi, NgayLamViec, Luong, NgaySinh, GioiTinh)
VALUES ('NV01', 'khuevotan','123', N'Võ', N'Tấn Khuê','0987664220', N'Cam Ranh, Khánh Hòa',CAST(N'2020-09-06' AS Date),100000 ,CAST(N'2001-09-06' AS Date), 1),
	   ('NV02', 'admin','123', N'Quản', N'Trị Viên','01627240041', N'Tuy Hòa, Phú Yên', CAST(N'2020-09-06' AS Date), 200000 ,CAST(N'2001-09-06' AS Date), 1 ),
	   ('NV03', 'huynguyenhuu','123', N'Nguyễn', N'Hữu Huy','0987413571', N'Cam Lâm, Khánh Hòa',CAST(N'2021-09-06' AS Date),100000 ,CAST(N'2001-03-04' AS Date), 1),
	   ('NV04', 'phucnguyenvan','123', N'Nguyễn', N'Văn Phúc','0983468912', N'Nha Trang, Khánh Hòa',CAST(N'2021-09-06' AS Date),100000 ,CAST(N'2001-11-24' AS Date), 1),
	   ('NV05', 'phuongthihuynh','123', N'Huỳnh', N'Thị Phương','0983347511', N'Đông Hòa, Phú Yên',CAST(N'2021-09-06' AS Date),100000 ,CAST(N'2001-02-07' AS Date), 0),
	   ('NV06', 'khanhtranvan','123', N'Trần', N'Văn Khánh','0984478901', N'Nha Trang, Khánh Hòa',CAST(N'2021-09-06' AS Date),200000 ,CAST(N'2001-06-24' AS Date), 1),
	   ('NV07', 'namnguyenvan','123', N'Nguyễn', N'Văn Nam','0984416745', N'Nha Trang, Khánh Hòa',CAST(N'2021-09-06' AS Date),100000 ,CAST(N'2001-09-22' AS Date), 1),
	   ('NV08', 'nhinguyenthiai','123', N'Nguyễn', N'Thị Ái Nhi','0983468912', N'Cam Lâm, Khánh Hòa',CAST(N'2021-09-06' AS Date),100000 ,CAST(N'2001-11-03' AS Date), 0),
	   ('NV09', 'huytranvan','123', N'Trần', N'Văn Huy','0983515131', N'Nha Trang, Khánh Hòa',CAST(N'2021-09-06' AS Date),100000 ,CAST(N'2001-10-01' AS Date), 1),
	   ('NV10', 'datnguyen','123', N'Nguyễn', N'Thành Đạt','0984141674', N'Nha Trang, Khánh Hòa',CAST(N'2021-09-06' AS Date),200000 ,CAST(N'2001-11-20' AS Date), 1)

GO
INSERT INTO dbo.NCC (MaNCC, TenNCC, DiaChi, SoDT,Email)
VALUES ('NCC01', N'Khang', N'Quận Hoàng Mai -Thành phố Hà Nội', '0987642245', 'phuongdong@gmail.com'),
	   ('NCC02', N'Hoàng ', N'hường Mai Động -Quận Hoàng Mai -Thành phố Hà Nội', '0987642245', 'phuongdong@gmail.com'),
	   ('NCC03', N'Quốc ', N'Huyện Gia Lâm, Hà Nội', '0985167812','quochuy@gmail.com'),
	   ('NCC04', N'Ngọc', N'Vọng La, Đông Anh, Hà Nội', '0985551152','ngoccuong@gmail.com'),
	   ('NCC05', N'Hoàng ', N'Hà Nội', '0985161722','hoangdong@gmail.com'),
	   ('NCC06', N'Tiềng', N'Long Định, Châu Thành, Tiền Giang', '098789906', 'tiengiang@gmail.com'),
	   ('NCC07', N'Hoàng', N'Đà Nẵng', '0985161132','tiengiang@gmail.com'),
	   ('NCC08', N'An ', N'Khánh Hòa', '098715123','tiengiang@gmail.com'),
	   ('NCC09', N'Phố', N'Hà Nội', '0985168142','tiengiang@gmail.com'),
	   ('NCC10', N'Vĩnh', N'Huế','098415125','tiengiang@gmail.com')
GO

GO
INSERT INTO dbo.Loai (MaLoai, TenLoai)
VALUES	('DM01', N'Rau'),
		('DM02', N'Củ'),
		('DM03', N'Trái Cây'),
		('DM04', N'Sữa'),
		('DM05', N'Trứng'),
		('DM06', N'Gạo'),
		('DM07', N'Bột'),
		('DM08', N'Đồ Khô')
GO


GO
INSERT INTO dbo.KhachHang (MaKH, TenDN, MatKhau, HoKH, TenKH, SoDT, DiaChi, GioiTinh)
VALUES	('KH001', N'huynguyen','123', N'Nguyễn', N'Huy',  0985101312, N'Cam Ranh, Khánh Hòa', 1),
		('KH002', N'nhinguyen','123', N'Nguyễn', N'Nhi', 0981231232, N'Cam Ranh, Khánh Hòa',  0),
		('KH003', N'phucnguyen','123', N'Nguyễn', N'Phúc',  0985323422, N'Cam Lâm, Khánh Hòa', 1),
		('KH004', N'minhtran','123', N'Trần', N'Minh',  0985101312, N'Nha Trang, Khánh Hòa',  1),
		('KH005', N'hoapham','123', N'Phạm', N'Hoa', 0983231112, N'Cam Lâm, Khánh Hòa',  0),
		('KH006', N'namvannguyen','123', N'Nguyễn', N'Văn Nam', 0982325222, N'Cam Ranh, Khánh Hòa', 1),
		('KH007', N'hongphamthi','123', N'Phạm', N'Thị Hồng',  0985312312, N'Nha Trang, Khánh Hòa', 0),
		('KH008', N'phinguyen','123', N'Nguyễn', N'Phi',  0985424212, N'Cam Ranh, Khánh Hòa', 1),
		('KH009', N'hoaitran','123', N'Trần', N'Hoài',  0985231312, N'Nha Trang, Khánh Hòa', 1),
		('KH010', N'thupham','123', N'Phạm', N'Thu', 0985441312, N'Cam Lâm, Khánh Hòa',  0)
GO
INSERT INTO dbo.HoaDon (SoHD , NgayDatHang, NgayGiaoHang, DiaChiGiaoHang,  TinhTrang, MaNVDuyet, MaNVGiaoHang, MaKH, ThanhToan)
VALUES	('HD001', CAST(N'2020-09-03' AS Date), CAST(N'2020-09-04' AS Date), N'Vĩnh Điềm Trung', N'Duyệt','NV01', 'NV01','KH001',10.0),
		('HD002', CAST(N'2020-10-02' AS Date), CAST(N'2020-10-03' AS Date),  N'Mã Vòng',  N'Duyệt', 'NV03','NV01','KH002',10.0),
		('HD003', CAST(N'2020-04-10' AS Date), CAST(N'2020-04-11' AS Date),	N'Vĩnh Điềm Trung', N'Duyệt','NV01', 'NV01','KH003',10.0),
		('HD004', CAST(N'2020-09-11' AS Date), CAST(N'2020-09-12' AS Date),  N'Vĩnh Hải', N'Duyệt', 'NV02','NV01', 'KH004',10.0),
		('HD005', CAST(N'2020-04-06' AS Date), CAST(N'2020-04-07' AS Date),  N'Vĩnh Phước',  N'Duyệt', 'NV08','NV01', 'KH005',10.0),
		('HD006', CAST(N'2020-11-20' AS Date), CAST(N'2020-11-21' AS Date),  N'Xóm Cồn', N'Duyệt', 'NV05','NV01', 'KH006',10.0),
		('HD007', CAST(N'2020-10-11' AS Date), CAST(N'2020-10-12' AS Date),  N'Vĩnh Hải',  N'Duyệt', 'NV10','NV01', 'KH007',10.0),
		('HD008', CAST(N'2020-02-01' AS Date), CAST(N'2020-02-02' AS Date),  N'Vĩnh Phước',  N'Duyệt', 'NV04','NV01', 'KH008',10.0),
		('HD009', CAST(N'2020-01-03' AS Date), CAST(N'2020-01-04' AS Date), N'Mường Thanh',  N'Duyệt', 'NV09', 'NV01','KH009',10.0),
		('HD010', CAST(N'2020-11-09' AS Date), CAST(N'2020-11-10' AS Date),  N'Vĩnh Điềm Trung',  N'Duyệt', 'NV01','NV03', 'KH001',10.0),
		('HD011', CAST(N'2022-06-06' AS Date), CAST(N'2022-06-09' AS Date),  N'Vĩnh Điềm Trung',  N'Duyệt', 'NV04','NV01', 'KH003',10.0),
		('HD012', CAST(N'2022-06-05' AS Date), CAST(N'2022-06-11' AS Date),  N'Vĩnh Điềm Trung',  N'Duyệt', 'NV05','NV01', 'KH002',10.0)
GO


GO
INSERT INTO dbo.SanPham (MaSP, TenSP, AnhDaiDien,MoTaSP, DonGia, MaNCC, MaLoai,DonViTinh)
VALUES	('SP01', N'Nấm kim châm', N'namkimcham.jpg',  N'Nấm kim châm Hàn Quốc được nuôi trồng và đóng gói theo những tiêu chuẩn nghiêm ngặt', 10000, 'NCC01','DM01','VND'),
		('SP02', N'Cải ngọt', N'caingot.jpg',N'Rau an toàn 4KFarm với tiêu chí 4 KHÔNG, luôn ưu tiên bảo vệ sức khỏe người tiêu dùng', 15000, 'NCC02','DM01','VND'),
		('SP03', N'Rau muống', N'raumuong.jpg', N'Rau an toàn 4KFarm với tiêu chí 4 KHÔNG, luôn ưu tiên bảo vệ sức khỏe người tiêu dùng', 9000 , 'NCC03', 'DM01','VND'),
		('SP04', N'Cà rốt ', N'carot.jpg',  N'Cà rốt Đà Lạt là một loại củ rất quen thuộc trong các món ăn của người Việt. Loại củ này ', 5000 , 'NCC05', 'DM02','VND'),
		('SP05', N'Bắp mỹ', N'bap.jpg',  N'Bắp Mỹ là một loại thực phẩm được trồng rất nhiều ở khắp nơi trên thế giới. Đây là một loại ', 15000,'NCC04', 'DM02','VND')	
GO


INSERT INTO dbo.CTHoaDon (DonGia, SoLuong, SoHD , MaSP)
VALUES	(15000, 15, 'HD001', 'SP01'),
		(10000, 10, 'HD002', 'SP02'),
		(9000, 5, 'HD003', 'SP03'),
		(9000, 10, 'HD004', 'SP04'),
		(3000, 10, 'HD005', 'SP05')
GO
INSERT INTO dbo.ThamSo
values ('TS001',N'Giá bán lớn hơn 0',N'VND',0,1)
Go

CREATE PROCEDURE SANPHAM_TimKiem
    @Masp varchar(10)=NULL,
	@Tensp nvarchar(50)=NULL,
	@Donvitinh nvarchar(20) = null,
	@MaNCC nvarchar(10) = null,
	@Maloai nvarchar(10) =null,
	@GiaMin varchar(30) = null,
	@GiaMax varchar(30) = null
AS
BEGIN
DECLARE @SqlStr NVARCHAR(4000),
		@ParamList nvarchar(2000)
SELECT @SqlStr = '
       SELECT * 
       FROM SanPham
       WHERE  (1=1)
       '
IF @Masp IS NOT NULL
       SELECT @SqlStr = @SqlStr + '
              AND (MaSP LIKE ''%'+@Masp+'%'')
              '
IF @Tensp IS NOT NULL
       SELECT @SqlStr = @SqlStr + '
              AND (TenSP LIKE N''%'+@Tensp+'%'')
              '
IF @Donvitinh IS NOT NULL
       SELECT @SqlStr = @SqlStr + '
              AND (DonViTinh LIKE N''%'+@Donvitinh+'%'')
              '
IF @GiaMin IS NOT NULL and @GiaMax IS NOT NULL
       SELECT @SqlStr = @SqlStr + '
             AND (DonGia Between Convert(int,'''+@GiaMin+''') AND Convert(int, '''+@GiaMax+'''))
			 '
IF @MaNCC IS NOT NULL
       SELECT @SqlStr = @SqlStr + '
              AND (MaNCC LIKE ''%'+@MaNCC+'%'')
              '
IF @Maloai IS NOT NULL
       SELECT @SqlStr = @SqlStr + '
              AND (MaLoai LIKE ''%'+@Maloai+'%'')
              '

	EXEC SP_EXECUTESQL @SqlStr
END

go

CREATE PROCEDURE NHANVIEN_TimKiem
    @Manv varchar(10)=NULL,
	@Tennv nvarchar(40)=NULL
AS
BEGIN
DECLARE @SqlStr NVARCHAR(4000),
		@ParamList nvarchar(2000)
SELECT @SqlStr = '
       SELECT * 
       FROM NhanVien
       WHERE  (1=1)
       '
IF @Manv IS NOT NULL
       SELECT @SqlStr = @SqlStr + '
              AND (MaNV LIKE ''%'+@Manv+'%'')
              '
IF @Tennv IS NOT NULL
       SELECT @SqlStr = @SqlStr + '
              AND (HoNV+'' '' + TenNV LIKE N''%'+@Tennv+'%'')
              '

	EXEC SP_EXECUTESQL @SqlStr
END
GO