part of 'quan_ly_hop_dong_bloc.dart';

abstract class QuanLyHopDongEvent extends Equatable {
  const QuanLyHopDongEvent();

  @override
  List<Object> get props => [];
}

class GetListHopDongEvent extends QuanLyHopDongEvent {
  final PhongModel? selectPhong;
  final int selectedStatus;
  final int numberPage;
  const GetListHopDongEvent({required this.selectedStatus, required this.numberPage,this.selectPhong});

  @override
  List<Object> get props => [];
}

class ThemHopDongEvent extends QuanLyHopDongEvent {
  final HopDongModel hopDongModel;
  const ThemHopDongEvent({required this.hopDongModel});

  @override
  List<Object> get props => [];
}

class SuaHopDongEvent extends QuanLyHopDongEvent {
  final HopDongModel hopDongModel;
  final PhongModel phongModel;
  final String? dateEnd;
  final String? dateStart;
  const SuaHopDongEvent({required this.hopDongModel, required this.phongModel,this.dateEnd, this.dateStart});

  @override
  List<Object> get props => [];
}
