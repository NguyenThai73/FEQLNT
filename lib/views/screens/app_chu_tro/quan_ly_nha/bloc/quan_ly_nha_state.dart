// ignore_for_file: prefer_const_constructors_in_immutables

part of 'quan_ly_nha_bloc.dart';

abstract class QuanLyNhaState extends Equatable {
  const QuanLyNhaState();

  @override
  List<Object> get props => [];
}

class QuanLyNhaInitial extends QuanLyNhaState {}

class QuanLyNhaLoading extends QuanLyNhaState {}

class QuanLyNhaSuccess extends QuanLyNhaState {
  final List<NhaModel> list;
  QuanLyNhaSuccess({required this.list});

  @override
  List<Object> get props => [list];
}

class QuanLyNhaError extends QuanLyNhaState {
  final String error;
  QuanLyNhaError({required this.error});

  @override
  List<Object> get props => [error];
}

class ThemMoiSuccess extends QuanLyNhaState {}
class SuaSuccess extends QuanLyNhaState {}

