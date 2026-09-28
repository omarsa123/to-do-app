import 'package:to_do_app/feature/auth/data/model/user_model.dart';

abstract class AuthState {}
class AuthIntialState extends AuthState{}
class AuthLoadingState extends AuthState{}
class AuthLoginSuccessState extends AuthState{
     UserModel? user ;
     AuthLoginSuccessState({required this.user});
}
class AuthLoginFailState extends AuthState{
  String msg;
  AuthLoginFailState({required this.msg});
}
class AuthSignupSuccessState extends AuthState{
     UserModel user ;
     AuthSignupSuccessState({required this.user});
}
class AuthSignupFailState extends AuthState{
  String msg;
  AuthSignupFailState({required this.msg});
}
class AuthRememberMeChangedState extends AuthState{}
