import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/feature/auth/data/model/user_model.dart';
import 'package:to_do_app/feature/home/presentation/view_model/home_state.dart';
import 'package:to_do_app/feature/task_managemnet/data/model/task_model.dart';

class HomeCubit extends Cubit<HomeState>{
  DateTime targetDate =DateTime.now();
  List<TaskModel>tasks = [];
  StreamSubscription? tasksSubscription;
  HomeCubit():super(HomeIntialState(ccurrentDate:DateTime.now()));
  final firestoreInstance = FirebaseFirestore.instance;
    void changeTargetDate (DateTime selectedDate , UserModel user) {
    targetDate = selectedDate;
    getTasksReltedToDate(user , selectedDate);
  }
 void updateTask(TaskModel updatedTask) {
  final index = tasks.indexWhere(
    (task) => task.id == updatedTask.id,
  );

  if (index != -1) {
    tasks[index] = updatedTask;

    emit(
      HomeSuccessState(
        tasks: List<TaskModel>.from(tasks),
        ccurrentDate: targetDate,
      ),
    );
  }
}
  Future<void> getTasksReltedToDate (UserModel user , DateTime selected)async{
    emit(HomeLoadingState(ccurrentDate: selected));
    try{
    final startOfDay = DateTime(
      selected.year,
      selected.month,
      selected.day
    );
    final startofNextDay = startOfDay.add(Duration(days: 1));
    await tasksSubscription?.cancel();
      tasksSubscription =  firestoreInstance
            .collection("users")
            .doc(user.uid!)
            .collection("tasks")
            .where(
              "date" , 
              isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay)
            )
            .where(
              "date",
              isLessThan:  Timestamp.fromDate(startofNextDay)
            )
            .snapshots().listen((snap) {
              tasks = snap.docs.map((doc) => TaskModel.fromMap(doc.data(), doc.id)).toList();
              emit(HomeSuccessState(tasks: tasks , ccurrentDate: selected));
            },
                  
            );
    }catch(e){
      emit(HomeFailState(msg: "ايوا هو من هنا الايرور",ccurrentDate: selected));
    }
  }
  @override
Future<void> close() {
  tasksSubscription?.cancel();
  return super.close();
}
}