part of 'profile.bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {}

class UpdateAvatarEvent extends ProfileEvent {
  final String url;
  const UpdateAvatarEvent({required this.url});
}
