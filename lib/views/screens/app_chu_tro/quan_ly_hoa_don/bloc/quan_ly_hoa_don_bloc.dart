// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:fe/apps/widgets/date-pick-time.dart';
import 'package:fe/models/hoa_don/hoa.don.model.dart';
import 'package:fe/models/hop_dong/hop.dong.model.dart';
import 'package:fe/z_provider/hoa.don.provider.dart';
import 'package:fe/z_provider/hop.dong.provider.dart';
import 'package:fe/z_provider/phong.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'quan_ly_hoa_don_state.dart';
part 'quan_ly_hoa_don_event.dart';

class QuanLyHoaDonBloc extends Bloc<QuanLyHoaDonEvent, QuanLyHoaDonState> {
  QuanLyHoaDonBloc() : super(QuanLyHoaDonInitial()) {
    // event handler was added
    on<QuanLyHoaDonEvent>((event, emit) async {
      await handleEvent(emit, event);
    });
  }

  handleEvent(Emitter<QuanLyHoaDonState> emit, QuanLyHoaDonEvent event) async {
    emit(QuanLyHoaDonLoading());
    try {
      if (event is GetListHoaDonEvent) {
        var response = await HoaDonProvider.getList();
        emit(QuanLyHoaDonSuccess(list: response));
      } else if (event is ThemHoaDonEvent) {
        if (event.hoaDonModel.name == null || event.hoaDonModel.name == "") {
          emit(QuanLyHoaDonError(error: "Chọn tháng"));
        } else if (event.hoaDonModel.idHopDong == null) {
          emit(QuanLyHoaDonError(error: "Hợp đồng"));
        } else if (event.hoaDonModel.file == null || event.hoaDonModel.file == "") {
          emit(QuanLyHoaDonError(error: "Tải ảnh hoá đơn"));
        } else if (event.hoaDonModel.dueDate == null) {
          emit(QuanLyHoaDonError(error: "Chọn ngày đến hạn"));
        } else {
          event.hoaDonModel.dueDate = convertTimeStamp(event.hoaDonModel.dueDate!, "00:00:00");
          var checkThemmoi = await HoaDonProvider.themMoi(event.hoaDonModel);
          if (checkThemmoi) {
            emit(ThemMoiSuccess());
          } else {
            emit(QuanLyHoaDonError(error: "Có lỗi xảy ra."));
          }
        }
      } else if (event is SuaHoaDonEvent) {
        // if (event.hopDongModel.idPhong == null) {
        //   emit(QuanLyHoaDonError(error: "Chọn phòng"));
        // } else if (event.dateEnd == null || event.dateStart == null) {
        //   emit(QuanLyHoaDonError(error: "Chọn ngày"));
        // } else if (event.hopDongModel.numberPeople == null || event.hopDongModel.numberPeople == 0) {
        //   emit(QuanLyHoaDonError(error: "Điền số lượng người trọ"));
        // } else if (event.hopDongModel.file == null) {
        //   emit(QuanLyHoaDonError(error: "Cần tải file hợp đồng"));
        // } else {
        //   event.hopDongModel.dateEnd = convertTimeStamp(event.dateEnd!, "00:00:00");
        //   event.hopDongModel.dateStart = convertTimeStamp(event.dateStart!, "00:00:00");
        //   if (event.phongModel.id != event.hopDongModel.phong?.id) {
        //     event.phongModel.status = 1;
        //     await PhongProvider.sua(event.phongModel);
        //   }
        //   var check = await HoaDonProvider.sua(event.hopDongModel);
        //   if (check) {
        //     if (event.hopDongModel.status == 0) {
        //      event.hopDongModel.phong?.status = 1;
        //     } else {
        //       event.hopDongModel.phong?.status = 2;
        //     }
        //     await PhongProvider.sua(event.hopDongModel.phong!);
        //     emit(SuaSuccess(hopDongModel: event.hopDongModel));
        //   } else {
        //     emit(QuanLyHoaDonError(error: "Có lỗi xảy ra."));
        //   }
        // }
      }
    } catch (e) {
      emit(QuanLyHoaDonError(error: "Có lỗi xảy ra."));
    }
  }
}
