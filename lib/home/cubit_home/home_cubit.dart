import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbase_app/home/cubit_home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';
import '../../shared/constante.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  UserModel? model;
  void getUserInfo() {
    print('first acces');
    emit(GetUserLodinState());
    FirebaseFirestore.instance.collection('users').doc(UID).get().then((value) {
      print(value.data());
      model = UserModel.fromJson(value.data()!);
      print(model!.isVir);
      emit(GoodUserGetState());
    }).catchError((e) {
      print(e.toString());
      emit(BadUserGetState());
    });
  }
}
