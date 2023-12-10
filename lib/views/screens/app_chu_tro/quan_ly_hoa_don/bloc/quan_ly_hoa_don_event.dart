part of 'quan_ly_hoa_don_bloc.dart';

abstract class QuanLyHoaDonEvent extends Equatable {
  const QuanLyHoaDonEvent();

  @override
  List<Object> get props => [];
}

class GetListHoaDonEvent extends QuanLyHoaDonEvent {
  final int selectedStatus;
  final String? date;
  const GetListHoaDonEvent({required this.selectedStatus, required this.date});

  @override
  List<Object> get props => [];
}

class ThemHoaDonEvent extends QuanLyHoaDonEvent {
  final HoaDonModel hoaDonModel;
  const ThemHoaDonEvent({required this.hoaDonModel});

  @override
  List<Object> get props => [];
}

class SuaHoaDonEvent extends QuanLyHoaDonEvent {
  final HoaDonModel hoaDonModel;
  const SuaHoaDonEvent({required this.hoaDonModel});

  @override
  List<Object> get props => [];
}
