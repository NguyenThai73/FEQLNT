part of 'quan_ly_nha_bloc.dart';

abstract class QuanLyNhaEvent extends Equatable {
  const QuanLyNhaEvent();

  @override
  List<Object> get props => [];
}

class CheckQuanLyNhaEvent extends QuanLyNhaEvent {}

class GetLisNhaEvent extends QuanLyNhaEvent {}

class ThemNhaEvent extends QuanLyNhaEvent {
  final NhaModel nhaModel;
  const ThemNhaEvent({required this.nhaModel});

  @override
  List<Object> get props => [];
}
class SuaNhaEvent extends QuanLyNhaEvent {
  final NhaModel nhaModel;
  const SuaNhaEvent({required this.nhaModel});

  @override
  List<Object> get props => [];
}

