import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/models/nguoi-dung/user.model.dart';
import 'package:fe/z_provider/nguoi.dung.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile.event.dart';

part 'profile.state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileStateInitial()) {
    on<ProfileEvent>((event, emit) async {
      await profileBloc(emit, event);
    });
  }

  profileBloc(Emitter<ProfileState> emit, ProfileEvent event) async {
    emit(ProfileStateLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var id = await prefs.getString("id");
      if (event is GetProfileEvent) {
        var user = await NguoiDungProvider.getUserById(id: id ?? "");
        emit(ProfileStateSuccess(nguoiDungModel: user));
      } else if (event is UpdateAvatarEvent) {
        // var check = await SessionProvider.updateAvatar(event.url);
        // if (check == true) {
        //   emit(ChangeAvatarSuccess());
        // } else {
        //   emit(const ProfileStateFailure(error: "Error"));
        // }
      }
    } catch (e) {
      emit(const ProfileStateFailure(error: "Error"));
    }
  }
}
