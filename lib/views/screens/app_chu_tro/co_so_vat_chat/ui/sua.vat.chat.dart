import 'package:fe/apps/widgets/textfiel.dart';
import 'package:fe/apps/widgets/toast.dart';
import 'package:fe/models/vat_chat/vat.chat.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/views/screens/app_chu_tro/co_so_vat_chat/bloc/co_so_vat_chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuaVatChatScreen extends StatefulWidget {
  final VatChat vatChat;
  const SuaVatChatScreen({super.key, required this.vatChat});

  @override
  State<SuaVatChatScreen> createState() => _SuaVatChatScreenState();
}

class _SuaVatChatScreenState extends State<SuaVatChatScreen> {
  VatChat vatChat = VatChat();
  TextEditingController name = TextEditingController();
  final _bloc = VatChatBloc();
  @override
  void initState() {
    super.initState();
    vatChat = widget.vatChat;
    name.text = vatChat.name ?? "";
  }

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
          "Thông tin",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer<VatChatBloc, VatChatState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is VatChatLoading) {
              onLoading(context);
              return;
            } else if (state is SuaSuccess) {
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
                    const SizedBox(height: 30),
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () async {
                          vatChat.name = name.text;
                          _bloc.add(SuaVatChatEvent(vatChat: vatChat));
                        },
                        child: const Center(
                          child: Text(
                            "Cập nhật",
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
