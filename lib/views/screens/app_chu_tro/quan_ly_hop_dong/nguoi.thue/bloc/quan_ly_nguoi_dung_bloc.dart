// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:fe/apps/widgets/date-pick-time.dart';
import 'package:fe/models/hop_dong/hop.dong.model.dart';
import 'package:fe/models/nguoi-dung/user.model.dart';
import 'package:fe/models/phong/phong.model.dart';
import 'package:fe/z_provider/hop.dong.provider.dart';
import 'package:fe/z_provider/nguoi.dung.provider.dart';
import 'package:fe/z_provider/phong.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'quan_ly_nguoi_dung_state.dart';
part 'quan_ly_nguoi_dung_event.dart';

class QuanLyNguoiDungBloc extends Bloc<QuanLyNguoiDungEvent, QuanLyNguoiDungState> {
  QuanLyNguoiDungBloc() : super(QuanLyNguoiDungInitial()) {
    // event handler was added
    on<QuanLyNguoiDungEvent>((event, emit) async {
      await handleEvent(emit, event);
    });
  }

  handleEvent(Emitter<QuanLyNguoiDungState> emit, QuanLyNguoiDungEvent event) async {
    emit(QuanLyNguoiDungLoading());
    try {
      if (event is GetListNguoiDungEvent) {
        var response = await NguoiDungProvider.getList(selectedStatus: event.selectedStatus, numberPage: event.numberPage, selectHopDong: event.hopDongModel?.id);
        emit(QuanLyNguoiDungSuccess(list: response));
      } else if (event is ThemNguoiDungEvent) {
        if (event.nguoiDungModel.idHopDong == null) {
          emit(QuanLyNguoiDungError(error: "Chọn hợp đồng"));
        } else if (event.nguoiDungModel.username == null || event.nguoiDungModel.username == "") {
          emit(QuanLyNguoiDungError(error: "Điền tên đăng nhập"));
        } else if (event.nguoiDungModel.fullName == null || event.nguoiDungModel.fullName == "") {
          emit(QuanLyNguoiDungError(error: "Điền họ và tên"));
        } else if (event.nguoiDungModel.namSinh == null || event.nguoiDungModel.namSinh == "") {
          emit(QuanLyNguoiDungError(error: "Điền năm sinh"));
        } else if (event.nguoiDungModel.sdt == null || event.nguoiDungModel.sdt == "") {
          emit(QuanLyNguoiDungError(error: "Điền số điện thoại"));
        } else {
          var checkThemmoi = await NguoiDungProvider.themMoi(event.nguoiDungModel);
          if (checkThemmoi) {
            emit(ThemMoiSuccess());
          } else {
            emit(QuanLyNguoiDungError(error: "Có lỗi xảy ra."));
          }
        }
      } else if (event is SuaNguoiDungEvent) {
        if (event.nguoiDungModel.idHopDong == null) {
          emit(QuanLyNguoiDungError(error: "Chọn hợp đồng"));
        } else if (event.nguoiDungModel.username == null || event.nguoiDungModel.username == "") {
          emit(QuanLyNguoiDungError(error: "Điền tên đăng nhập"));
        } else if (event.nguoiDungModel.fullName == null || event.nguoiDungModel.fullName == "") {
          emit(QuanLyNguoiDungError(error: "Điền họ và tên"));
        } else if (event.nguoiDungModel.namSinh == null || event.nguoiDungModel.namSinh == "") {
          emit(QuanLyNguoiDungError(error: "Điền năm sinh"));
        } else if (event.nguoiDungModel.sdt == null || event.nguoiDungModel.sdt == "") {
          emit(QuanLyNguoiDungError(error: "Điền số điện thoại"));
        } else {
          var checkThemmoi = await NguoiDungProvider.sua(event.nguoiDungModel);
          if (checkThemmoi) {
            emit(SuaSuccess(nguoiDungModel: event.nguoiDungModel));
          } else {
            emit(QuanLyNguoiDungError(error: "Có lỗi xảy ra."));
          }
        }
      }
    } catch (e) {
      emit(QuanLyNguoiDungError(error: "Có lỗi xảy ra."));
    }
  }
}
