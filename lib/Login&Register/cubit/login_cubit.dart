import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  Icon iconhidden = const Icon(Icons.visibility);

  bool ishidden = true;
  void showpass() {
    if (ishidden) {
      iconhidden = const Icon(Icons.visibility_off);
      ishidden = !ishidden;
    } else {
      iconhidden = const Icon(Icons.visibility);
      ishidden = !ishidden;
    }
    emit(HiddenPasswordState());
  }

  void loginUser(String email, String password) {
    emit(LodinLoginState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.emailVerified);
      print(value.user!.email);
      emit(GoodLoginState(value.user!.uid));
    }).catchError((e) {
      emit(BadLoginState(e.toString()));
    });
  }
}
