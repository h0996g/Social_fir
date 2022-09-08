abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class ConditionalLodinState extends RegisterState {}

class HiddenRegisterPasswordState extends RegisterState {}

class LodinFirstRegisterState extends RegisterState {}

class GoodFirstRegisterState extends RegisterState {}

class BadFirstRegisterState extends RegisterState {
  final e;

  BadFirstRegisterState(this.e);
}

// class LodinCreateUserState extends RegisterState {}

class GoodCreateRegisterState extends RegisterState {}

class BadCreateRegisterState extends RegisterState {
  final e;

  BadCreateRegisterState(this.e);
}
