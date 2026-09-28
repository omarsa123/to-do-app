import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/feature/auth/data/model/user_model.dart';
import 'package:to_do_app/feature/auth/presentation/view_model/auth_state.dart';


class AuthCubit extends Cubit<AuthState>{
  AuthCubit():super(AuthIntialState());
  final firebaseAuthInstance = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  UserModel? currentUser;
   bool isRememberMe = false;
    void toggleRememberMe(bool value) {
    isRememberMe = value;
    emit(AuthRememberMeChangedState());
  }
  void signUp (UserModel user , String pass)async{

      emit(AuthLoadingState());
      try{
        final crdiential = await firebaseAuthInstance.createUserWithEmailAndPassword(email: user.email, password: pass);
          await crdiential.user!.sendEmailVerification();
          user.uid = crdiential.user!.uid;
          await firestoreInstance.collection('users').doc(user.uid).set(user.toMap());
          emit(AuthSignupSuccessState(user: user));
      }
      catch(e){
        emit(AuthSignupFailState(msg: e.toString()));
      }
  }
  void login (String email , String pass)async{
    emit(AuthLoadingState());
    try{
      final cra =  await firebaseAuthInstance.signInWithEmailAndPassword(email: email, password: pass);
      await cra.user!.reload();
      if(!cra.user!.emailVerified){
        emit(AuthLoginFailState(msg: "Please Verify Your Email first!"));
        return ;
      }
      else{
        final data = await firestoreInstance.collection('users').doc(cra.user!.uid).get();
        currentUser= UserModel.fromMap(data.data()!);
        emit(AuthLoginSuccessState(user: currentUser));
      }
    }
    catch(e){
      emit(AuthLoginFailState(msg: e.toString()));
    }
  }
}