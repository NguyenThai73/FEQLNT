part of 'co_so_vat_chat_bloc.dart';

abstract class VatChatEvent extends Equatable {
  const VatChatEvent();

  @override
  List<Object> get props => [];
}

class CheckVatChatEvent extends VatChatEvent {}

class GetLisNhaEvent extends VatChatEvent {}

class ThemVatChatEvent extends VatChatEvent {
  final VatChat vatChat;
  const ThemVatChatEvent({required this.vatChat});

  @override
  List<Object> get props => [];
}
class SuaVatChatEvent extends VatChatEvent {
  final VatChat vatChat;
  const SuaVatChatEvent({required this.vatChat});

  @override
  List<Object> get props => [];
}

