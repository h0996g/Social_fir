import 'package:firbase_app/Login&Register/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  Icon iconhidden = Icon(Icons.visibility);

  bool ishidden = true;
  void showpass() {
    if (ishidden) {
      iconhidden = Icon(Icons.visibility_off);
      ishidden = !ishidden;
    } else {
      iconhidden = Icon(Icons.visibility);
      ishidden = !ishidden;
    }
    emit(HiddenRegisterPasswordState());
  }
}
