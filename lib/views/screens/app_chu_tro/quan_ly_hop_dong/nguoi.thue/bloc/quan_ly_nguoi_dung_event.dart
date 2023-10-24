part of 'quan_ly_nguoi_dung_bloc.dart';

abstract class QuanLyNguoiDungEvent extends Equatable {
  const QuanLyNguoiDungEvent();

  @override
  List<Object> get props => [];
}

class GetListNguoiDungEvent extends QuanLyNguoiDungEvent {
  final HopDongModel? hopDongModel;
  final int selectedStatus;
  final int numberPage;
  const GetListNguoiDungEvent({required this.selectedStatus, required this.numberPage,this.hopDongModel});

  @override
  List<Object> get props => [];
}

class ThemNguoiDungEvent extends QuanLyNguoiDungEvent {
  final NguoiDungModel nguoiDungModel;
  const ThemNguoiDungEvent({required this.nguoiDungModel});

  @override
  List<Object> get props => [];
}

class SuaNguoiDungEvent extends QuanLyNguoiDungEvent {
  final NguoiDungModel nguoiDungModel;
  const SuaNguoiDungEvent({required this.nguoiDungModel});

  @override
  List<Object> get props => [];
}
