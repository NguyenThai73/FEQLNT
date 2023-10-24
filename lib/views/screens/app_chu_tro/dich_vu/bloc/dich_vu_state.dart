// ignore_for_file: prefer_const_constructors_in_immutables

part of 'dich_vu_bloc.dart';

abstract class DichVuState extends Equatable {
  const DichVuState();

  @override
  List<Object> get props => [];
}

class DichVuInitial extends DichVuState {}

class DichVuLoading extends DichVuState {}

class DichVuSuccess extends DichVuState {
  final List<DichVuModel> list;
  DichVuSuccess({required this.list});

  @override
  List<Object> get props => [list];
}

class DichVuError extends DichVuState {
  final String error;
  DichVuError({required this.error});

  @override
  List<Object> get props => [error];
}

class ThemMoiSuccess extends DichVuState {}
class SuaSuccess extends DichVuState {}

