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
        
        var response = await HoaDonProvider.getList(status: event.selectedStatus, dateSearch: event.date);
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
          var checkThemmoi = await HoaDonProvider.sua(event.hoaDonModel);
          if (checkThemmoi) {
            emit(SuaSuccess(hopDongModel: event.hoaDonModel));
          } else {
            emit(QuanLyHoaDonError(error: "Có lỗi xảy ra."));
          }
        }
      }
    } catch (e) {
      emit(QuanLyHoaDonError(error: "Có lỗi xảy ra."));
    }
  }
}
