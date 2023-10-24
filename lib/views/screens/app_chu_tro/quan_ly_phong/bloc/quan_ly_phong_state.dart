// ignore_for_file: prefer_const_constructors_in_immutables

part of 'quan_ly_phong_bloc.dart';

abstract class QuanLyPhongState extends Equatable {
  const QuanLyPhongState();

  @override
  List<Object> get props => [];
}

class QuanLyPhongInitial extends QuanLyPhongState {}

class QuanLyPhongLoading extends QuanLyPhongState {}

class QuanLyPhongSuccess extends QuanLyPhongState {
  final List<PhongModel> listPhong;
  QuanLyPhongSuccess({required this.listPhong});

  @override
  List<Object> get props => [listPhong];
}

class QuanLyPhongError extends QuanLyPhongState {
  final String error;
  QuanLyPhongError({required this.error});

  @override
  List<Object> get props => [error];
}

class ThemMoiSuccess extends QuanLyPhongState {}

class GetListPhongVatChatSucces extends QuanLyPhongState {
  final List<PhongVatChat> listVatChat;
  GetListPhongVatChatSucces({required this.listVatChat});

  @override
  List<Object> get props => [listVatChat];
}

class SuaPhongSuccess extends QuanLyPhongState {}