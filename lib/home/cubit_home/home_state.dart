abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetUserLodinState extends HomeState {}

class GoodUserGetState extends HomeState {
  String error;
  GoodUserGetState({required this.error});
}

class BadUserGetState extends HomeState {}
