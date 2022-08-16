abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class ConditionalLodinState extends RegisterState {}

class HiddenRegisterPasswordState extends RegisterState {}

class LodinRegisterState extends RegisterState {}

class GoodRegisterState extends RegisterState {}

class BadRegisterState extends RegisterState {
  final e;

  BadRegisterState(this.e);
}
