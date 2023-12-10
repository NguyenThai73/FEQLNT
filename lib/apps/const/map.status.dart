import 'package:flutter/material.dart';

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
  0: 'Chưa thu',
  1: 'Đã đóng',
  2: 'Xác nhận',
  3: 'Quá hạn',
};

Map<int, String> listStatusHoaDon = {
  0: 'Chưa thu',
  1: 'Đã đóng',
  2: 'Xác nhận',
  3: 'Quá hạn',
};

String valueStatusHoaDon(int status) {
  switch (status) {
    case 0:
      return 'Chưa thu';
    case 1:
      return 'Đã đóng';
    case 2:
      return 'Xác nhận';
    case 3:
      return 'Quá hạn';
    default:
      return "";
  }
}

Color colorsStatusHoaDon(int status) {
  switch (status) {
    case 0:
      return Colors.orange;
    case 1:
      return Colors.green;
    case 2:
      return Colors.blue;
    case 3:
      return Colors.red;
    default:
      return Colors.black;
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
