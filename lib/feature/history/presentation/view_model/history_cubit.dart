import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/feature/auth/data/model/user_model.dart';
import 'package:to_do_app/feature/history/presentation/view_model/history_state.dart';
import 'package:to_do_app/feature/task_managemnet/data/model/task_model.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryIntialState());
  final firestoreInstance = FirebaseFirestore.instance;
  StreamSubscription? TasksStream;
  List<TaskModel> tasks = [];
  Future<void> getAllTasks(UserModel? user) async {
    emit(HistoryLoadingState());
    if (user == null) {
      emit(HistoryFailState(msg: "Please Login First , and try again"));
    } else {
      try {
        TasksStream?.cancel();
        TasksStream = firestoreInstance
            .collection("users")
            .doc(user.uid)
            .collection("tasks")
            .snapshots().listen((snap){
                tasks = snap.docs.map((doc)=> TaskModel.fromMap(doc.data(), doc.id)).toList();
                emit(HistorySuccessState(tasks: tasks));
            });
      } catch (e) {
        emit(HistoryFailState(msg: e.toString()));
      }
    }
  }
  @override
  Future<void> close() {
    TasksStream?.cancel();
    return super.close();
  }
}
