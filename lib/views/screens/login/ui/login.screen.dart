import 'package:fe/apps/widgets/border_textfield.dart';
import 'package:fe/apps/widgets/textfiel.dart';
import 'package:fe/apps/widgets/toast.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/views/component/wilps/will.pop.scope.dart';
import 'package:fe/views/screens/app_nguoi_tro/navigation_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_chu_tro/navigation_home_screen.dart';
import '../bloc/login.bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _bloc = LoginBloc();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String username = "";
  String password = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPS(
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
            bloc: _bloc,
            listener: (context, state) async {
              if (state is LoginLoading) {
                onLoading(context);
                return;
              } else if (state is LoginSuccessState) {
                Navigator.pop(context);

                if (state.role == 0) {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const NavigationHomeScreen(),
                    ),
                  );
                } else {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const NavigationNguoiThueHomeScreen(),
                    ),
                  );
                }
              } else if (state is LoginFailure) {
                showToast(
                  context: context,
                  msg: state.error,
                  color: Colors.orange,
                  icon: const Icon(Icons.warning),
                );
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 150),
                      ClipOval(
                        child: Container(
                          width: 200,
                          height: 200,
                          child: Image.asset("assets/images/logo.jpeg"),
                        ),
                      ),
                      const SizedBox(height: 15),

                      BorderTextField(
                        controller: usernameController,
                        title: "Tên đăng nhập",
                        placeholder: '',
                        onChangeText: (value) {
                          username = value;
                        },
                      ),
                      const SizedBox(height: 15),
                      BorderTextField(
                        controller: passwordController,
                        title: "Mật khẩu",
                        placeholder: '',
                        isPassword: true,
                        onChangeText: (value) {
                          password = value;
                        },
                      ),
                      // TextFielWidget(
                      //   title: 'Tên đăng nhập',
                      //   controller: usernameController,
                      // ),
                      // const SizedBox(height: 15),
                      // TextFielWidget(
                      //   title: 'Mật khẩu',
                      //   controller: passwordController,
                      // ),
                      const SizedBox(height: 15),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        height: 56,
                        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                  _bloc.add(StartLoginEvent(username: usernameController.text, password: passwordController.text));
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
