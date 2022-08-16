abstract class LoginState {}

class LoginInitial extends LoginState {}

class InitialState extends LoginState {}

class ConditionalLodinState extends LoginState {}

class GoodLoginState extends LoginState {}

class BadLoginState extends LoginState {
  String e;

  BadLoginState(this.e);
}

class HiddenPasswordState extends LoginState {}

class PutcacheonbordingStates extends LoginState {}

class SharedSkipState extends LoginState {}

class LodinLoginState extends LoginState {}
