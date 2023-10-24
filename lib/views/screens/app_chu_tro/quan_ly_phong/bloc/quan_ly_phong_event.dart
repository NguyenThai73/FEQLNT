part of 'quan_ly_phong_bloc.dart';

abstract class QuanLyPhongEvent extends Equatable {
  const QuanLyPhongEvent();

  @override
  List<Object> get props => [];
}

class CheckQuanLyPhongEvent extends QuanLyPhongEvent {}

class GetLisPhongEvent extends QuanLyPhongEvent {}

class ThemMoiPhong extends QuanLyPhongEvent {
  final PhongModel phongModel;
  final List<VatChat> listVatChat;
  const ThemMoiPhong({required this.phongModel, required this.listVatChat});

  @override
  List<Object> get props => [phongModel, listVatChat];
}

class GetListPhongVatChat extends QuanLyPhongEvent {
  final int idPhong;
  const GetListPhongVatChat({required this.idPhong});

  @override
  List<Object> get props => [idPhong];
}

class SuaPhong extends QuanLyPhongEvent {
  final PhongModel phongModel;
  final List<PhongVatChat> listVatChat;
  final List<PhongVatChat> listVatChatRemove;
  const SuaPhong({required this.phongModel, required this.listVatChat, required this.listVatChatRemove});

  @override
  List<Object> get props => [phongModel, listVatChat, listVatChatRemove];
}
