part of 'quan_ly_hoa_don_bloc.dart';

abstract class QuanLyHoaDonEvent extends Equatable {
  const QuanLyHoaDonEvent();

  @override
  List<Object> get props => [];
}

class GetListHoaDonEvent extends QuanLyHoaDonEvent {
  final int selectedStatus;
  final int numberPage;
  const GetListHoaDonEvent({required this.selectedStatus, required this.numberPage});

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
  final HoaDonModel hopDongModel;
  final String? dateEnd;
  final String? dateStart;
  const SuaHoaDonEvent({required this.hopDongModel,this.dateEnd, this.dateStart});

  @override
  List<Object> get props => [];
}
