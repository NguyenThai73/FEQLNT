// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:fe/apps/widgets/toast.dart';
import 'package:fe/models/nguoi-dung/user.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/views/screens/profile/bloc/profile.bloc.dart';
import 'package:fe/z_provider/base.url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'change.pass.screen.dart';
import 'edit.profile.screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _bloc = ProfileBloc();

  NguoiDungModel nguoiDungModel = NguoiDungModel();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Row(),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is ProfileStateLoading) {
              onLoading(context);
              return;
            } else if (state is ProfileStateSuccess) {
              Navigator.pop(context);
              nguoiDungModel = state.nguoiDungModel;
            } else if (state is ChangeAvatarSuccess) {
              Navigator.pop(context);
              showToast(
                context: context,
                msg: "Updtae avatar was successfully",
                color: const Color.fromARGB(255, 32, 255, 76),
                icon: const Icon(Icons.done),
              );
              _bloc.add(GetProfileEvent());
            } else if (state is ProfileStateFailure) {
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(color: Color.fromARGB(255, 236, 236, 236)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    (nguoiDungModel.avatar != null && nguoiDungModel.avatar != "")
                        ? Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                image: NetworkImage("$baseUrl/api/files/${nguoiDungModel.avatar!}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: InkWell(
                              onTap: () async {
                                var avatarPath = await handleUploadAvater();
                                setState(() {
                                  nguoiDungModel.avatar = avatarPath;
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black),
                                          // margin: const EdgeInsets.only(top: 170),
                                          child: const Icon(
                                            Icons.photo_camera,
                                            color: Colors.white,
                                            size: 30,
                                          )),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/avt.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: InkWell(
                              onTap: () async {
                                var avatarPath = await handleUploadAvater();
                                setState(() {
                                  nguoiDungModel.avatar = avatarPath;
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black),
                                          // margin: const EdgeInsets.only(top: 170),
                                          child: const Icon(
                                            Icons.photo_camera,
                                            color: Colors.white,
                                            size: 30,
                                          )),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          nguoiDungModel.fullName ?? "",
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TitleDataUer(titile: "Tên đăng nhập", content: nguoiDungModel.username ?? ""),
                    TitleDataUer(titile: "Năm sinh", content: nguoiDungModel.namSinh ?? ""),
                    TitleDataUer(titile: "Số điện thoại", content: nguoiDungModel.sdt ?? ""),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          width: 170,
                          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => EditProfileScrren(
                                    nguoiDungModel: nguoiDungModel,
                                    callBack: (value) {},
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Cập nhật ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Container(
                          padding: const EdgeInsets.all(15),
                          width: 170,
                          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => const ChangePasswordScrren(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Đổi mật khẩu",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class TitleDataUer extends StatelessWidget {
  final String titile;
  final String content;
  const TitleDataUer({super.key, required this.content, required this.titile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
                flex: 4,
                child: Text(
                  titile,
                  style: TextStyle(color: Colors.black, fontSize: 19),
                )),
            Expanded(
                flex: 5,
                child: Text(
                  content,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )),
          ],
        ),
        const SizedBox(height: 5),
        const Divider()
      ],
    );
  }
}
