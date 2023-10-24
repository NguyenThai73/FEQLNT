// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:fe/models/nha_model/nha.model.dart';
import 'package:fe/z_provider/khu.tro.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'quan_ly_nha_state.dart';
part 'quan_ly_nha_event.dart';

class QuanLyNhaBloc extends Bloc<QuanLyNhaEvent, QuanLyNhaState> {
  QuanLyNhaBloc() : super(QuanLyNhaInitial()) {
    // event handler was added
    on<QuanLyNhaEvent>((event, emit) async {
      await quanlyKhuTo(emit, event);
    });
  }

  quanlyKhuTo(Emitter<QuanLyNhaState> emit, QuanLyNhaEvent event) async {
    emit(QuanLyNhaLoading());
    try {
      if (event is GetLisNhaEvent) {
        var respose = await KhuTroProvider.getListNha();
        emit(QuanLyNhaSuccess(list: respose));
      } else if (event is ThemNhaEvent) {
        if (event.nhaModel.name == "" || event.nhaModel.address == "") {
          emit(QuanLyNhaError(error: "Tên và địa chỉ không được trống"));
        } else {
          var response = await KhuTroProvider.themMoi(event.nhaModel);
          if (response) {
            emit(ThemMoiSuccess());
          } else {
            emit(QuanLyNhaError(error: "Có lỗi xảy ra."));
          }
        }
      } else if (event is SuaNhaEvent) {
        if (event.nhaModel.name == "" || event.nhaModel.address == "") {
          emit(QuanLyNhaError(error: "Tên và địa chỉ không được trống"));
        } else {
          var response = await KhuTroProvider.sua(event.nhaModel);
          if (response) {
            emit(SuaSuccess());
          } else {
            emit(QuanLyNhaError(error: "Có lỗi xảy ra."));
          }
        }
      }
    } catch (e) {
      emit(QuanLyNhaError(error: "Có lỗi xảy ra."));
    }
  }
}
