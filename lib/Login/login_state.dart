part of 'login_cubit.dart';

@override
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingStates extends LoginState {}

class LoginSuccessStates extends LoginState {
  final login_model model;

  LoginSuccessStates(this.model);
}

class LoginErrorStates extends LoginState {}

class ChangeIconStates extends LoginState {}
