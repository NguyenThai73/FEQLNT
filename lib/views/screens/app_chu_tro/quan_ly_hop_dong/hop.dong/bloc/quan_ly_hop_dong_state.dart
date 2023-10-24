// ignore_for_file: prefer_const_constructors_in_immutables

part of 'quan_ly_hop_dong_bloc.dart';

abstract class QuanLyHopDongState extends Equatable {
  const QuanLyHopDongState();

  @override
  List<Object> get props => [];
}

class QuanLyHopDongInitial extends QuanLyHopDongState {}

class QuanLyHopDongLoading extends QuanLyHopDongState {}

class QuanLyHopDongSuccess extends QuanLyHopDongState {
  final List<HopDongModel> list;
  QuanLyHopDongSuccess({required this.list});

  @override
  List<Object> get props => [list];
}

class QuanLyHopDongError extends QuanLyHopDongState {
  final String error;
  QuanLyHopDongError({required this.error});

  @override
  List<Object> get props => [error];
}

class ThemMoiSuccess extends QuanLyHopDongState{}

class SuaSuccess extends QuanLyHopDongState{
   final HopDongModel hopDongModel;
  const SuaSuccess({required this.hopDongModel});

  @override
  List<Object> get props => [];
}
