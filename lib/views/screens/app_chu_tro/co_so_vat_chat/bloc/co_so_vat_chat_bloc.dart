// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:fe/models/nha_model/nha.model.dart';
import 'package:fe/models/vat_chat/vat.chat.model.dart';
import 'package:fe/z_provider/khu.tro.provider.dart';
import 'package:fe/z_provider/vat.chat.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'co_so_vat_chat_state.dart';
part 'co_so_vat_chat_event.dart';

class VatChatBloc extends Bloc<VatChatEvent, VatChatState> {
  VatChatBloc() : super(VatChatInitial()) {
    // event handler was added
    on<VatChatEvent>((event, emit) async {
      await quanlyKhuTo(emit, event);
    });
  }

  quanlyKhuTo(Emitter<VatChatState> emit, VatChatEvent event) async {
    emit(VatChatLoading());
    try {
      if (event is GetLisNhaEvent) {
        var respose = await VatChatProvider.getList();
        emit(VatChatSuccess(list: respose));
      } else if (event is ThemVatChatEvent) {
        if (event.vatChat.name == "") {
          emit(VatChatError(error: "Tên không được trống"));
        } else {
          var response = await VatChatProvider.themMoi(event.vatChat);
          if (response) {
            emit(ThemMoiSuccess());
          } else {
            emit(VatChatError(error: "Có lỗi xảy ra."));
          }
        }
      } else if (event is SuaVatChatEvent) {
        if (event.vatChat.name == "") {
          emit(VatChatError(error: "Tên và địa chỉ không được trống"));
        } else {
          var response = await VatChatProvider.sua(event.vatChat);
          if (response) {
            emit(SuaSuccess());
          } else {
            emit(VatChatError(error: "Có lỗi xảy ra."));
          }
        }
      }
    } catch (e) {
      emit(VatChatError(error: "Có lỗi xảy ra."));
    }
  }
}
