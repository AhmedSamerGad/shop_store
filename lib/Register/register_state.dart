part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterDataSuccessed extends RegisterState {}

class RegisterDataLoading extends RegisterState {}

class RegisterDataError extends RegisterState {}

class r_ChangeIconStates extends RegisterState {}
