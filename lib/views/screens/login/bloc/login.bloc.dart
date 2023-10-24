// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:fe/z_provider/nguoi.dung.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'login.state.dart';
part 'login.event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    // event handler was added
    on<LoginEvent>((event, emit) async {
      await loginUser(emit, event);
    });
  }

  loginUser(Emitter<LoginState> emit, LoginEvent event) async {
    emit(LoginLoading());
    try {
      if (event is StartLoginEvent) {
        if (event.username == "" || event.password == "") {
          emit(LoginFailure(error: "Tài khoản mật khẩu khoong được trống"));
        } else {
          var user = await NguoiDungProvider.login(email: event.username, password: event.password);
          if (user != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("id", "${user.id}");
            prefs.setString("role", "${user.role}");
            emit(LoginSuccessState(role: user.role ?? 0));
          } else {
            emit(LoginFailure(error: "Tài khoản mật khẩu sai"));
          }
        }
      }
    } catch (e) {
      print("Loi: $e");
      emit(LoginFailure(error: "Tài khoản mật khẩu sai"));
    }
  }
}
