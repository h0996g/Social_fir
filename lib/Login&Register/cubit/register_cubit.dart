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
        .then((value) async {
      print(value.user!.uid);
      await creatUser(name!, email, phone!, value.user!.uid);
      // emit(GoodFirstRegisterState());
    }).catchError((e) {
      print(e.toString());

      emit(BadFirstRegisterState(e.toString()));
    });
  }

  Future<void> creatUser(
      String name, String email, String phone, String uId) async {
    // emit(LodinCreateUserState());
    UserModel? model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        isVir: false,
        img:
            'https://img.freepik.com/free-vector/mafia-tiger-character-with-hat_23-2148473394.jpg?w=740&t=st=1663209025~exp=1663209625~hmac=38c128ec6235347df128b2ab45aa4fd38369ac5c386281126ba96410bc67d27e',
        bio: 'write your bio ...',
        cover:
            'https://img.freepik.com/free-photo/flat-lay-lunch-boxes-assortment_23-2149060450.jpg?w=996&t=st=1663211256~exp=1663211856~hmac=68aab193571ed413133e91c589a9f4ce5422774225c1425c8fe25c95caed6eda');

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(GoodCreateRegisterState(uId));
    }).catchError((e) {
      emit(BadCreateRegisterState(e.toString()));
    });
  }
}
