import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbase_app/Login&Register/cubit/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

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
    emit(HiddenRegisterPasswordState());
  }

  void firstRegister(String email, String password,
      {String? name, String? phone}) {
    emit(LodinFirstRegisterState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.uid);
      creatUser(name!, email, phone!, value.user!.uid);
      // emit(GoodFirstRegisterState());
    }).catchError((e) {
      emit(BadFirstRegisterState(e.toString()));
    });
  }

  void creatUser(String name, String email, String phone, String uId) {
    // emit(LodinCreateUserState());
    UserModel? model =
        UserModel(name: name, email: email, phone: phone, uId: uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(GoodCreateRegisterState());
    }).catchError((e) {
      emit(BadCreateRegisterState(e.toString()));
    });
  }
}
