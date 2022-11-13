import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbase_app/home/addPost/addpost.dart';
import 'package:firbase_app/home/chats/chasts.dart';
import 'package:firbase_app/home/cubit_home/home_state.dart';
import 'package:firbase_app/home/feeds/feeds.dart';
import 'package:firbase_app/home/settings/setting.dart';
import 'package:firbase_app/home/users/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user_model.dart';
import '../../shared/constante.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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

  final ImagePicker _picker = ImagePicker();
  XFile? profileimage;
  Future<void> profileImg(ImageSource source) async {
    // Pick an image
    profileimage = await _picker.pickImage(source: source) ?? profileimage;

    emit(GoodSelectImage());
  }

  XFile? coverimage;

  Future coverImg(ImageSource source) async {
    // Pick an image
    coverimage = await _picker.pickImage(source: source) ?? coverimage;
    print(coverimage!.path);

    emit(GoodSelectImage());
  }

  // final storage = FirebaseStorage.instance;
  String? profileImgUrl;
  String? coverImgUrl;
  uploadProfileImg({
    String? name,
    String? bio,
    String? phone,
  }) {
    emit(LoginUploadProfileImg());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileimage!.path).pathSegments.last}')
        .putFile(File(profileimage!.path))
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        print(value);
        profileimage = null;

        emit(GoodUploadProfileImg());
        updateUser(profile: value);
      }).catchError((e) {
        emit(BadUploadProfileImg());
        print(e.toString());
      });
    }).catchError((e) {
      emit(BadUploadProfileImg());
      print(e.toString());
    });
  }

  uploadCoverImg({
    String? name,
    String? bio,
    String? phone,
  }) {
    emit(LodinUploadCoverImg());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverimage!.path).pathSegments.last}')
        .putFile(File(coverimage!.path))
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        print(value);
        coverimage = null;
        emit(GoodUploadCoverImg());
        updateUser(cover: value);
      }).catchError((e) {
        print(e.toString());
        emit(BadUploadCoverImg());
      });
    }).catchError((e) {
      print(e.toString());
      emit(BadUploadCoverImg());
    });
  }

  void updateUser(
      {String? name,
      String? bio,
      String? phone,
      String? cover,
      String? profile}) async {
    emit(LodinUpdateUser());
    UserModel? model = UserModel(
        name: name ?? userModel!.name,
        phone: phone ?? userModel!.phone,
        img: profile ?? userModel!.img,
        bio: bio ?? userModel!.bio,
        cover: cover ?? userModel!.cover,
        email: userModel!.email,
        isVir: userModel!.isVir,
        uId: userModel!.uId);

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(model.toMap())
        .then((value) {
      getUserInfo();
    }).catchError((e) {
      emit(BadUpdateUser());
      print(e.toString());
    });
  }

  void resetEditeProfile() {
    profileimage = null;
    coverimage = null;
    emit(GoodResetValue());
  }
}
