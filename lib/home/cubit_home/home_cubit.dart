import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbase_app/home/addPost/addpost.dart';
import 'package:firbase_app/home/chats/chasts.dart';
import 'package:firbase_app/home/cubit_home/home_state.dart';
import 'package:firbase_app/home/feeds/feeds.dart';
import 'package:firbase_app/home/settings/setting.dart';
import 'package:firbase_app/home/users/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user_model.dart';
import '../../shared/constante.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  void getUserInfo() {
    print('Get User info Successfully');
    emit(GetUserLodinState());
    FirebaseFirestore.instance.collection('users').doc(UID).get().then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      print(userModel!.isVir);
      emit(GoodUserGetState());
    }).catchError((e) {
      print(e.toString());
      emit(BadUserGetState());
    });
  }

  int indexNav = 0;
  void changeNav(int index) {
    if (index == 2) {
      emit(ChangeNaveToAddPostState());
    } else
      indexNav = index;
    emit(ChangeNaveState());
  }

  List<Widget> screen = [
    const FeedsScreen(),
    const ChatsScreen(),
    const AddPost(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String> title = ['Home', 'Chats', 'Post', 'Users', 'Settings'];

  ImagePicker _picker = ImagePicker();
  XFile? image;
  Future<void> galeryImage() async {
    // Pick an image
    image = await _picker.pickImage(source: ImageSource.gallery) ?? image;

    emit(GoodSelectGaleryImage());
  }
}
