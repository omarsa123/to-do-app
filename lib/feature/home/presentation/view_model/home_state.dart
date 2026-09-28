import 'package:to_do_app/feature/task_managemnet/data/model/task_model.dart';

abstract class HomeState {
  DateTime ccurrentDate ;
  HomeState({required this.ccurrentDate});
}
class HomeIntialState extends HomeState {
  HomeIntialState({required super.ccurrentDate});
}
class HomeLoadingState extends HomeState {
  HomeLoadingState({required super.ccurrentDate});
}
class HomeSuccessState extends HomeState {
  List<TaskModel> tasks ;
  HomeSuccessState({required this.tasks , required super.ccurrentDate});
}
class HomeFailState extends HomeState{
  String msg;
  HomeFailState({required this.msg , required super.ccurrentDate});
}
class ToggleSuccessState extends HomeState {
  ToggleSuccessState({required super.ccurrentDate});
}
class HomeUpdateState extends HomeState{
  HomeUpdateState({required super.ccurrentDate});
}