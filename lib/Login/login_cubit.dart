import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Networking/Dio.dart';
import 'login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  login_model? model;
  bool isPassword = true;
  IconData iconData = Icons.visibility;
  void ChangeIcon() {
    isPassword = !isPassword;
    iconData = isPassword ? Icons.visibility_off_outlined : Icons.visibility;
    emit(ChangeIconStates());
  }

  void putData({@required email, @required password}) {
    emit(LoginLoadingStates());
    networkdata.postData(
        url: 'login',
        data: {'email': email, 'password': password}).then((value) {
      model = login_model.fromjason(value?.data);

      emit(LoginSuccessStates(model!));
    }).catchError((error) {
      emit(LoginErrorStates());
      print(error.toString());
    });
  }
}
