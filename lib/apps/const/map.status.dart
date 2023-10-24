Map<int, String> listStatusPhong = {
  0: 'Đóng',
  1: 'Đang trống',
  2: 'Đang thuê',
};
String valueStatusPhongModel(int status) {
  switch (status) {
    case 0:
      return "Đóng";
    case 1:
      return "Đang trống";
    case 2:
      return "Đang thuê";
    default:
      return "";
  }
}

Map<int, String> listStatusPhongVatChat = {
  0: 'Hỏng',
  1: 'Hoạt động',
};

String valueStatusPhongVatChatModel(int status) {
  switch (status) {
    case 0:
      return "Hỏng";
    case 1:
      return "Hoạt động";
    default:
      return "";
  }
}

Map<int, String> listStatusHopDongFilter = {
  -1: 'Tất cả',
  0: 'Hết hạn',
  1: 'Hoạt động',
};

Map<int, String> listStatusHopDong = {
  0: 'Hết hạn',
  1: 'Hoạt động',
};

String valueStatusHopDong(int status) {
  switch (status) {
    case 0:
      return 'Hết hạn';
    case 1:
      return 'Hoạt động';
    default:
      return "";
  }
}

Map<int, String> listStatusHoaDonFilter = {
  -1: 'Tất cả',
  0: 'Quá hạn',
  1: 'Chưa thu',
  2: 'Đã đóng',
  3: 'Xác nhận',
};

Map<int, String> listStatusHoaDon = {
  0: 'Quá hạn',
  1: 'Chưa thu',
  2: 'Đã đóng',
  3: 'Xác nhận',
};

String valueStatusHoaDon(int status) {
  switch (status) {
    case 0:
      return 'Quá hạn';
    case 1:
      return 'Chưa thu';
    case 2:
      return 'Đã đóng';
    case 3:
      return 'Xác nhận';
    default:
      return "";
  }
}

Map<int, String> listStatusNguoiDungFilter = {
  -1: 'Tất cả',
  0: 'Khoá',
  1: 'Hoạt động',
};

Map<int, String> listStatusNguoiDung = {
  0: 'Khoá',
  1: 'Hoạt động',
};

String valueStatusNguoiDung(int status) {
  switch (status) {
    case 0:
      return 'Khoá';
    case 1:
      return 'Hoạt động';
    default:
      return "";
  }
}