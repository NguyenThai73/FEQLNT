// ignore_for_file: prefer_const_constructors_in_immutables

part of 'co_so_vat_chat_bloc.dart';

abstract class VatChatState extends Equatable {
  const VatChatState();

  @override
  List<Object> get props => [];
}

class VatChatInitial extends VatChatState {}

class VatChatLoading extends VatChatState {}

class VatChatSuccess extends VatChatState {
  final List<VatChat> list;
  VatChatSuccess({required this.list});

  @override
  List<Object> get props => [list];
}

class VatChatError extends VatChatState {
  final String error;
  VatChatError({required this.error});

  @override
  List<Object> get props => [error];
}

class ThemMoiSuccess extends VatChatState {}
class SuaSuccess extends VatChatState {}

