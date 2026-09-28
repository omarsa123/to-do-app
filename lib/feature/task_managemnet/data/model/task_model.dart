import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

enum Status{
  pending,
  done,
  Missed,


}
Status toEnum (String word){
    return Status.values.firstWhere((e)=>e.name == word);
  }
class TaskModel {
  late String id ;
  Status status ;
  String task;
  DateTime date ;
  DateTime? completedAt;
  TaskModel({required this.date , required this.task , this.status = Status.pending , this.completedAt ,String? taskid}){
    id = taskid  ?? const Uuid().v4();
  }
  Map<String , dynamic> toMap (){
    return {     
      'task' : task ,
      'date' : Timestamp.fromDate(date), 
      'status' : status.name,
      'completed_at' : completedAt != null ? Timestamp.fromDate(completedAt!) : null
    };
  } 
  factory TaskModel.fromMap(Map<String , dynamic> data , String id){
    return TaskModel(date: (data['date'] as Timestamp).toDate(), task: data['task'] ,status: toEnum(data['status']) ,completedAt:data['completed_at'] == null
        ? null
        : (data['completed_at'] as Timestamp).toDate(),taskid: id );
  }
}