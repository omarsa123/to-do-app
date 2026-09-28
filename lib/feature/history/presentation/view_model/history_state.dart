import 'package:to_do_app/feature/task_managemnet/data/model/task_model.dart';

abstract class HistoryState {}
class HistoryIntialState extends HistoryState {}
class HistoryLoadingState extends HistoryState {}
class HistorySuccessState extends HistoryState {
  List<TaskModel> tasks ;
  HistorySuccessState({required this.tasks});
}
class HistoryFailState extends HistoryState{
  String msg ; 
  HistoryFailState({required this.msg});
}