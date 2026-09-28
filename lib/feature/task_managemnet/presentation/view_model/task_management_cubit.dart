import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/feature/auth/data/model/user_model.dart';
import 'package:to_do_app/feature/task_managemnet/data/model/task_model.dart';
import 'package:to_do_app/feature/task_managemnet/presentation/view_model/task_management_state.dart';

class TaskManagementCubit extends Cubit<TaskManagementState> {
  TaskManagementCubit() : super(TaskManagementintialState());
  final firestoreInstance = FirebaseFirestore.instance;
  DateTime selectedTime = DateTime.now();
  void selectDate(DateTime selected) {
    selectedTime = selected;
    emit(DateChangeSuccessState());
  }

  Future<void> addTask(UserModel? user, TaskModel task) async {
    emit(AddTaskLoadingState());
    try {
      if (user == null) {
        emit(AddTaskFailState(msg: "Please Login First!"));
      } else {
        await firestoreInstance
            .collection('users')
            .doc(user.uid)
            .collection("tasks")
            .doc(task.id)
            .set(task.toMap());
        emit(AddTaskSuccessState());
      }
    } catch (e) {
      emit(AddTaskFailState(msg: e.toString()));
    }
  }

  Future<void> updateTaskStatus(UserModel? user, TaskModel task) async {
    emit(UpdateTaskLoadingState());
    if (user == null) {
      emit(UpdateTaskFailState(msg: "Please login and try again!"));
      return;
    } else {
      try {
        final newStatus = task.status == Status.done
            ? Status.pending
            : Status.done;
        final completedTime = task.status == Status.pending
            ? DateTime.now()
            : null;
        task.status = newStatus;
        task.completedAt = completedTime;
        await firestoreInstance
            .collection("users")
            .doc(user.uid)
            .collection("tasks")
            .doc(task.id)
            .update({
              "status": newStatus.name,
              "completed_at": completedTime == null
                  ? null
                  : Timestamp.fromDate(completedTime),
            });

        emit(UpdateTaskSuccessState(task: task));
      } catch (e) {
        emit(UpdateTaskFailState(msg: e.toString()));
      }
    }
  }

  Future<void> editTask(UserModel? user, TaskModel edited) async {
    emit(EditTaskLoadingState());
    if (user == null) {
      emit(EditTaskFailState(msg: "Please Login and try again!"));
    } else {
      try {
        firestoreInstance
            .collection("users")
            .doc(user.uid)
            .collection("tasks")
            .doc(edited.id)
            .update({
              "task": edited.task,
              "date": Timestamp.fromDate(edited.date),
            });
        emit(EditTaskSuccessState(task: edited));
      } catch (e) {
        emit(EditTaskFailState(msg: e.toString()));
      }
    }
  }

  Future<void> deleteTask(UserModel? user, TaskModel task) async {
    emit(DeleteTaskLoadingState());
    if (user == null) {
      emit(DeleteTaskFailState(msg: "Please Login first and try again!"));
    } else {
      try{
          firestoreInstance
          .collection("users")
          .doc(user.uid)
          .collection("tasks")
          .doc(task.id)
          .delete();
        emit(DeleteTaskSuccessState(task: task));
      }
      catch(e){
        emit(DeleteTaskFailState(msg: e.toString()));
      }
    }
  }
}
