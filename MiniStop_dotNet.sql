Create database MiniStop
GO
Use MiniStop
GO
Create table PhanQuyen
(
	IDPhanQuyen char(20) PRIMARY KEY,
	TenPhanQuyen nvarchar(50),
)
GO
Create table TaiKhoan
(
	IDUser int identity(1,1) PRIMARY KEY,
	TenDangNhap nvarchar(50),
	MatKhau nvarchar(50),
	Email nvarchar(50),
	HinhAnh nvarchar(50), --avatar
	ChucVuID nvarchar(50),
	HoTen nvarchar(50),
	NgaySinh date,
	GioiTinh nvarchar(10),
	DiaChi nvarchar(50),
	SDT nvarchar(50),
	IDPhanQuyen char(20),
	CONSTRAINT PK_TaiKhoan_PhanQuyen FOREIGN KEY(IDPhanQuyen) REFERENCES PhanQuyen(IDPhanQuyen)
)
GO
Create table GiamGia
(
	IDGiamGia int identity(1,1) PRIMARY KEY,
	TenGiamGia nvarchar(50),
	MoTa nvarchar(50),
	NgayBatDau date,
	NgayKetThuc date,
	GiaGiam money,
	TrangThai nvarchar(50)
)
GO
Create table NhaCungCap
(
	IDNhaCungCap int identity(1,1) PRIMARY KEY,
	TenNhaCungCap nvarchar(50),
	SDT nvarchar(50),
	Email nvarchar(50),
	DiaChi nvarchar(50),
	TenGiaoDich nvarchar(50)
)
GO
Create table NhomSanPham
(
	IDNhomSP int identity(1,1) PRIMARY KEY,
	TenNhomSP nvarchar(50)
)
GO
Create table DanhMucSP
(
	IDDanhMucSP int identity(1,1) PRIMARY KEY,
	IDNhomSP int,
	HinhAnh nvarchar(50),
	TenDanhMucSP nvarchar(50),
	CONSTRAINT FK_DanhMucSP_NhomSP FOREIGN KEY (IDNhomSP) REFERENCES NhomSanPham(IDNhomSP)
)

GO
Create table SanPham
(
	IDSanPham int identity(1,1) PRIMARY KEY,
	IDDanhMucSP int,
	IDGiamGia int,
	IDNhaCungCap int,
	TenSanPham nvarchar(50),
	HinhAnh nvarchar(50),
	MoTa nvarchar(50),
	XuatXu nvarchar(50),
	Gia money,
	SoLuongTon int,
	TrangThai nvarchar(50),
	CONSTRAINT FK_SanPham_DanhMucSP FOREIGN KEY (IDDanhMucSP) REFERENCES DanhMucSP(IDDanhMucSP),
	CONSTRAINT FK_SanPham_NhaCungCap FOREIGN KEY (IDNhaCungCap) REFERENCES NhaCungCap(IDNhaCungCap),
	CONSTRAINT FK_SanPham_GiamGia FOREIGN KEY (IDGiamGia) REFERENCES GiamGia(IDGiamGia)
)


GO
Create table HinhThucThanhToan
(
	IDHinhThucTT int identity(1,1) PRIMARY KEY,
	TenHinhThucTT nvarchar(50),
	MoTa nvarchar(50),
	TinhTrang nvarchar(50)
)

GO
--Thanh Toan hang (hoa don)
Create table HoaDon
(
	ID_HoaDon int identity(1,1) PRIMARY KEY,
	IDUser int,
	IDHinhThucTT int,
	NgayThanhToan date,
	TongTien money,
	TrangThai nvarchar(50),
	CONSTRAINT FK_HoaDon_TaiKhoan FOREIGN KEY (IDUser) REFERENCES TaiKhoan(IDUser),
	Constraint FK_HoaDon_HinhThucThanhToan Foreign key (IDHinhThucTT) references HinhThucThanhToan(IDHinhThucTT)
)
GO
Create table CT_HoaDon
(
	ID_HoaDon int,
	IDSanPham int,
	IDGiamGia int,
	SoLuongMua int,
	DonGia float,
	ThanhTien float,
	Constraint PK_CTHoaDon primary key (ID_HoaDon, IDSanPham),
	Constraint FK_CTHoaDon_HoaDon Foreign key (ID_HoaDon) references HoaDon(ID_HoaDon),
	Constraint FK_CTHoaDon_SanPham Foreign key (IDSanPham) references SanPham(IDSanPham),
	Constraint FK_CTHoaDon_GiamGia Foreign key (IDGiamGia) references GiamGia(IDGiamGia)
)
GO
--Thong ke
--Phieu nhap
Create table PhieuNhap
(
	IDPhieuNhap int identity(1,1),
	TenPhieuNhap nvarchar(50),
	IDNhaCungCap int,
	NgayNhap date,
	Constraint PK_PhieuNhap primary key (IDPhieuNhap),
	Constraint FK_PhieuNhap_NhaCungCap Foreign key (IDNhaCungCap) references NhaCungCap(IDNhaCungCap)
)
--chi tiet phieu nhap
Create table CT_PhieuNhap
(
	IDPhieuNhap int,
	IDSanPham int,
	Soluong int,
	DonGia float,
	TongTienNhap float,
	Constraint PK_CTPhieuNhap primary key (IDPhieuNhap, IDSanPham),
	Constraint FK_CTPhieuNhap_PhieuNhap Foreign key (IDPhieuNhap) references PhieuNhap(IDPhieuNhap),
	Constraint FK_CTPhieuNhap_SanPham Foreign key (IDSanPham) references SanPham(IDSanPham)
)

