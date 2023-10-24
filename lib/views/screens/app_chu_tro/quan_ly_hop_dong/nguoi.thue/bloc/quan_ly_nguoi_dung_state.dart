// ignore_for_file: prefer_const_constructors_in_immutables

part of 'quan_ly_nguoi_dung_bloc.dart';

abstract class QuanLyNguoiDungState extends Equatable {
  const QuanLyNguoiDungState();

  @override
  List<Object> get props => [];
}

class QuanLyNguoiDungInitial extends QuanLyNguoiDungState {}

class QuanLyNguoiDungLoading extends QuanLyNguoiDungState {}

class QuanLyNguoiDungSuccess extends QuanLyNguoiDungState {
  final List<NguoiDungModel> list;
  QuanLyNguoiDungSuccess({required this.list});

  @override
  List<Object> get props => [list];
}

class QuanLyNguoiDungError extends QuanLyNguoiDungState {
  final String error;
  QuanLyNguoiDungError({required this.error});

  @override
  List<Object> get props => [error];
}

class ThemMoiSuccess extends QuanLyNguoiDungState{}

class SuaSuccess extends QuanLyNguoiDungState{
   final NguoiDungModel nguoiDungModel;
  const SuaSuccess({required this.nguoiDungModel});

  @override
  List<Object> get props => [];
}
