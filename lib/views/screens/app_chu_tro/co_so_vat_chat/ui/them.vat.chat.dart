import 'package:fe/apps/widgets/textfiel.dart';
import 'package:fe/apps/widgets/toast.dart';
import 'package:fe/models/vat_chat/vat.chat.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/views/screens/app_chu_tro/co_so_vat_chat/bloc/co_so_vat_chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemVatChatScreen extends StatefulWidget {
  const ThemVatChatScreen({super.key});

  @override
  State<ThemVatChatScreen> createState() => _AddNhaScreenState();
}

class _AddNhaScreenState extends State<ThemVatChatScreen> {
  TextEditingController name = TextEditingController();
  final _bloc = VatChatBloc();
  VatChat vatChat = VatChat();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Text(
          "Thêm mới",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer<VatChatBloc, VatChatState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is VatChatLoading) {
              onLoading(context);
              return;
            } else if (state is ThemMoiSuccess) {
              Navigator.pop(context);
              Navigator.pop(context);
            } else if (state is VatChatError) {
              Navigator.pop(context);
              showToast(
                context: context,
                msg: state.error,
                color: Colors.orange,
                icon: const Icon(Icons.warning),
              );
            }
          },
          builder: (context, state) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFielWidget(
                      title: 'Tên',
                      controller: name,
                    ),
                    const SizedBox(height: 25),
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () async {
                          vatChat = VatChat(name: name.text);
                          _bloc.add(ThemVatChatEvent(vatChat: vatChat));
                        },
                        child: const Center(
                          child: Text(
                            "Tạo mới",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
