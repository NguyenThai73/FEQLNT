// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:fe/models/phong/phong.model.dart';
import 'package:fe/models/phong/phong.vat.chat.dart';
import 'package:fe/models/vat_chat/vat.chat.model.dart';
import 'package:fe/z_provider/phong.provider.dart';
import 'package:fe/z_provider/phong.vat.chat.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'quan_ly_phong_state.dart';
part 'quan_ly_phong_event.dart';

class QuanLyPhongBloc extends Bloc<QuanLyPhongEvent, QuanLyPhongState> {
  QuanLyPhongBloc() : super(QuanLyPhongInitial()) {
    // event handler was added
    on<QuanLyPhongEvent>((event, emit) async {
      await quanlyKhuTo(emit, event);
    });
  }

  quanlyKhuTo(Emitter<QuanLyPhongState> emit, QuanLyPhongEvent event) async {
    emit(QuanLyPhongLoading());
    try {
      if (event is GetLisPhongEvent) {
        var lisPhong = await PhongProvider.getList();
        emit(QuanLyPhongSuccess(listPhong: lisPhong));
      } else if (event is ThemMoiPhong) {
        if (event.phongModel.name == "") {
          emit(QuanLyPhongError(error: "Điền tên phòng"));
        } else if (event.phongModel.idNha == null) {
          emit(QuanLyPhongError(error: "Chọn nhà"));
        } else if (event.phongModel.gia == null) {
          emit(QuanLyPhongError(error: "Giá phòng phải là số và không trống"));
        } else {
          var abc = await PhongProvider.themMoi(event.phongModel);
          if (abc > 0) {
            for (var element in event.listVatChat) {
              if (element.id != null && element.id != 0) {
                PhongVatChat dataPost = PhongVatChat(idPhong: abc, idVatChat: element.id, status: 1);
                await PhongVatChatProvider.themMoi(dataPost);
              }
            }
            emit(ThemMoiSuccess());
          } else {
            emit(QuanLyPhongError(error: "Có lỗi xảy ra."));
          }
        }
      } else if (event is SuaPhong) {
        if (event.phongModel.name == "") {
          emit(QuanLyPhongError(error: "Điền tên phòng"));
        } else if (event.phongModel.idNha == null) {
          emit(QuanLyPhongError(error: "Chọn nhà"));
        } else if (event.phongModel.gia == null) {
          emit(QuanLyPhongError(error: "Giá phòng phải là số và không trống"));
        } else {
          await PhongProvider.sua(event.phongModel);
          for (var element in event.listVatChat) {
            element.idPhong = event.phongModel.id;
            element.idVatChat = element.vatChat?.id;
            if (element.id == null) {
              element.status = 1;
              await PhongVatChatProvider.themMoi(element);
            } else {
              await PhongVatChatProvider.sua(element);
            }
          }
          for (var element in event.listVatChatRemove) {
            await PhongVatChatProvider.xoa(element);
          }
          emit(SuaPhongSuccess());
        }
      } else if (event is GetListPhongVatChat) {
        var listPhongVatChat = await PhongVatChatProvider.getList(event.idPhong);
        emit(GetListPhongVatChatSucces(listVatChat: listPhongVatChat));
      }
    } catch (e) {
      emit(QuanLyPhongError(error: "Có lỗi xảy ra."));
    }
  }
}
