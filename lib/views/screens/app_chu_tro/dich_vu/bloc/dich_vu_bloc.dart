// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:fe/models/dich_vu/dich.vu.model.dart';
import 'package:fe/z_provider/dich.vu.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'dich_vu_state.dart';
part 'dich_vu_event.dart';

class DichVuBloc extends Bloc<DichVuEvent, DichVuState> {
  DichVuBloc() : super(DichVuInitial()) {
    // event handler was added
    on<DichVuEvent>((event, emit) async {
      await quanlyKhuTo(emit, event);
    });
  }

  quanlyKhuTo(Emitter<DichVuState> emit, DichVuEvent event) async {
    emit(DichVuLoading());
    try {
      if (event is GetLisEvent) {
        var respose = await DichVuProvider.getList();
        emit(DichVuSuccess(list: respose));
      } else if (event is ThemEvent) {
        if (event.dichVuModel.name == "" || event.dichVuModel.idNha == null) {
          emit(DichVuError(error: "Tên và nhà không được trống"));
        } else if (event.dichVuModel.donGia == null) {
          emit(DichVuError(error: "Đơn giá phải là 1 số"));
        } else {
          var response = await DichVuProvider.themMoi(event.dichVuModel);
          if (response) {
            emit(ThemMoiSuccess());
          } else {
            emit(DichVuError(error: "Có lỗi xảy ra."));
          }
        }
      } else if (event is SuaEvent) {
        if (event.dichVuModel.name == "" || event.dichVuModel.idNha == null) {
          emit(DichVuError(error: "Tên và nhà không được trống"));
        } else if (event.dichVuModel.donGia == null) {
          emit(DichVuError(error: "Đơn giá phải là 1 số"));
        } else {
          var response = await DichVuProvider.sua(event.dichVuModel);
          if (response) {
            emit(SuaSuccess());
          } else {
            emit(DichVuError(error: "Có lỗi xảy ra."));
          }
        }
      }
    } catch (e) {
      emit(DichVuError(error: "Có lỗi xảy ra."));
    }
  }
}
