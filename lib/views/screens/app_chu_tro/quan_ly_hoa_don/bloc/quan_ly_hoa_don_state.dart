// ignore_for_file: prefer_const_constructors_in_immutables

part of 'quan_ly_hoa_don_bloc.dart';

abstract class QuanLyHoaDonState extends Equatable {
  const QuanLyHoaDonState();

  @override
  List<Object> get props => [];
}

class QuanLyHoaDonInitial extends QuanLyHoaDonState {}

class QuanLyHoaDonLoading extends QuanLyHoaDonState {}

class QuanLyHoaDonSuccess extends QuanLyHoaDonState {
  final List<HoaDonModel> list;
  QuanLyHoaDonSuccess({required this.list});

  @override
  List<Object> get props => [list];
}

class QuanLyHoaDonError extends QuanLyHoaDonState {
  final String error;
  QuanLyHoaDonError({required this.error});

  @override
  List<Object> get props => [error];
}

class ThemMoiSuccess extends QuanLyHoaDonState{}

class SuaSuccess extends QuanLyHoaDonState{
   final HoaDonModel hopDongModel;
  const SuaSuccess({required this.hopDongModel});

  @override
  List<Object> get props => [];
}
