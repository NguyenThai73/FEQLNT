// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:fe/apps/widgets/date-pick-time.dart';
import 'package:fe/models/hop_dong/hop.dong.model.dart';
import 'package:fe/models/phong/phong.model.dart';
import 'package:fe/z_provider/hop.dong.provider.dart';
import 'package:fe/z_provider/phong.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'quan_ly_hop_dong_state.dart';
part 'quan_ly_hop_dong_event.dart';

class QuanLyHopDongBloc extends Bloc<QuanLyHopDongEvent, QuanLyHopDongState> {
  QuanLyHopDongBloc() : super(QuanLyHopDongInitial()) {
    // event handler was added
    on<QuanLyHopDongEvent>((event, emit) async {
      await handleEvent(emit, event);
    });
  }

  handleEvent(Emitter<QuanLyHopDongState> emit, QuanLyHopDongEvent event) async {
    emit(QuanLyHopDongLoading());
    try {
      if (event is GetListHopDongEvent) {
        var response = await HopDongProvider.getList(selectedStatus: event.selectedStatus, numberPage: event.numberPage, selectPhong: event.selectPhong?.id);
        emit(QuanLyHopDongSuccess(list: response));
      } else if (event is ThemHopDongEvent) {
        if (event.hopDongModel.idPhong == null) {
          emit(QuanLyHopDongError(error: "Chọn phòng"));
        } else if (event.hopDongModel.dateEnd == null || event.hopDongModel.dateStart == null) {
          emit(QuanLyHopDongError(error: "Chọn ngày"));
        } else if (event.hopDongModel.numberPeople == null || event.hopDongModel.numberPeople == 0) {
          emit(QuanLyHopDongError(error: "Điền số lượng người trọ"));
        } else if (event.hopDongModel.file == null) {
          emit(QuanLyHopDongError(error: "Cần tải file hợp đồng"));
        } else {
          event.hopDongModel.dateEnd = convertTimeStamp(event.hopDongModel.dateEnd!, "00:00:00");
          event.hopDongModel.dateStart = convertTimeStamp(event.hopDongModel.dateStart!, "00:00:00");
          var checkThemmoi = await HopDongProvider.themMoi(event.hopDongModel);
          if (checkThemmoi) {
            event.hopDongModel.phong?.status = 2;
            await PhongProvider.sua(event.hopDongModel.phong!);
            emit(ThemMoiSuccess());
          } else {
            emit(QuanLyHopDongError(error: "Có lỗi xảy ra."));
          }
        }
      } else if (event is SuaHopDongEvent) {
        if (event.hopDongModel.idPhong == null) {
          emit(QuanLyHopDongError(error: "Chọn phòng"));
        } else if (event.dateEnd == null || event.dateStart == null) {
          emit(QuanLyHopDongError(error: "Chọn ngày"));
        } else if (event.hopDongModel.numberPeople == null || event.hopDongModel.numberPeople == 0) {
          emit(QuanLyHopDongError(error: "Điền số lượng người trọ"));
        } else if (event.hopDongModel.file == null) {
          emit(QuanLyHopDongError(error: "Cần tải file hợp đồng"));
        } else {
          event.hopDongModel.dateEnd = convertTimeStamp(event.dateEnd!, "00:00:00");
          event.hopDongModel.dateStart = convertTimeStamp(event.dateStart!, "00:00:00");
          if (event.phongModel.id != event.hopDongModel.phong?.id) {
            event.phongModel.status = 1;
            await PhongProvider.sua(event.phongModel);
          }
          var check = await HopDongProvider.sua(event.hopDongModel);
          if (check) {
            if (event.hopDongModel.status == 0) {
             event.hopDongModel.phong?.status = 1;
            } else {
              event.hopDongModel.phong?.status = 2;
            }
            await PhongProvider.sua(event.hopDongModel.phong!);
            emit(SuaSuccess(hopDongModel: event.hopDongModel));
          } else {
            emit(QuanLyHopDongError(error: "Có lỗi xảy ra."));
          }
        }
      }
    } catch (e) {
      emit(QuanLyHopDongError(error: "Có lỗi xảy ra."));
    }
  }
}
