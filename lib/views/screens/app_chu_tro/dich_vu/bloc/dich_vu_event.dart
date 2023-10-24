part of 'dich_vu_bloc.dart';

abstract class DichVuEvent extends Equatable {
  const DichVuEvent();

  @override
  List<Object> get props => [];
}

class CheckDichVuEvent extends DichVuEvent {}

class GetLisEvent extends DichVuEvent {}

class ThemEvent extends DichVuEvent {
  final DichVuModel dichVuModel;
  const ThemEvent({required this.dichVuModel});

  @override
  List<Object> get props => [];
}
class SuaEvent extends DichVuEvent {
  final DichVuModel dichVuModel;
  const SuaEvent({required this.dichVuModel});

  @override
  List<Object> get props => [];
}

