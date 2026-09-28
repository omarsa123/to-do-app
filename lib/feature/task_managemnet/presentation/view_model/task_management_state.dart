import 'package:to_do_app/feature/task_managemnet/data/model/task_model.dart';

abstract class TaskManagementState {}
class TaskManagementintialState extends TaskManagementState {}
class AddTaskLoadingState extends TaskManagementState {}
class AddTaskSuccessState extends TaskManagementState {}
class AddTaskFailState extends TaskManagementState {
  String msg ;
  AddTaskFailState({required this.msg});
}
class DateChangeSuccessState extends TaskManagementState{}
class UpdateTaskLoadingState extends TaskManagementState {}
class UpdateTaskSuccessState extends TaskManagementState {
  TaskModel task ;
  UpdateTaskSuccessState({required this.task});
}
class UpdateTaskFailState extends TaskManagementState {
  String msg ;
  UpdateTaskFailState({required this.msg});
}
class EditTaskLoadingState extends TaskManagementState {}
class EditTaskSuccessState extends TaskManagementState {
  TaskModel task ;
  EditTaskSuccessState({required this.task});
}
class EditTaskFailState extends TaskManagementState {
  String msg ;
  EditTaskFailState({required this.msg});
}
class DeleteTaskLoadingState extends TaskManagementState {}
class DeleteTaskSuccessState extends TaskManagementState {
  TaskModel task ;
  DeleteTaskSuccessState({required this.task});
}
class DeleteTaskFailState extends TaskManagementState {
  String msg ;
  DeleteTaskFailState({required this.msg});
}