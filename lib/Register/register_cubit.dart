import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Login/login_model.dart';
import '../Networking/Dio.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData iconData = Icons.visibility;
  void ChangeIcon() {
    isPassword = !isPassword;
    iconData = isPassword ? Icons.visibility_off_outlined : Icons.visibility;
    emit(r_ChangeIconStates());
  }

  login_model? model;
  void postRegData(
      {required name, required password, required phone, required email}) {
    emit(RegisterDataLoading());
    networkdata.postData(url: 'register', data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone
    }).then((value) {
      model = login_model.fromjason(value?.data);
      print(model?.message);
      emit(RegisterDataSuccessed());
    }).catchError((onError) {
      print(onError.toString());
      emit(RegisterDataError());
    });
  }
}
