// ignore_for_file: prefer_const_constructors_in_immutables

part of 'login.bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

//Đăng nhập lần đầu
class LoginFirstState extends LoginState {}

//Đã từng đăng nhập phiên trước
class LoginSecondState extends LoginState {
  final String phone;
  LoginSecondState({required this.phone});
  @override
  List<Object> get props => [phone];
}

class LoginSuccessState extends LoginState {
  final int role;
  LoginSuccessState({required this.role});
  @override
  List<Object> get props => [role];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
