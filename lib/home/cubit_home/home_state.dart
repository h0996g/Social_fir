abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetUserLodinState extends HomeState {}

class GoodUserGetState extends HomeState {
  // String error;
  // GoodUserGetState({required this.error});
}

class BadUserGetState extends HomeState {}

class ChangeNaveState extends HomeState {}

class ChangeNaveToAddPostState extends HomeState {}

class GoodSelectImage extends HomeState {}

class BadSelectGaleryImage extends HomeState {}

class LoginUploadProfileImg extends HomeState {}

class GoodUploadProfileImg extends HomeState {}

class BadUploadProfileImg extends HomeState {}

class LodinUploadCoverImg extends HomeState {}

class GoodUploadCoverImg extends HomeState {}

class BadUploadCoverImg extends HomeState {}

class LodingUpdateUser extends HomeState {}

class GoodUpdateUser extends HomeState {}

class LodinUpdateUser extends HomeState {}

class BadUpdateUser extends HomeState {}

class GoodResetValue extends HomeState {}
