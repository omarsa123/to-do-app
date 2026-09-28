import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/app_constants/app_fonts.dart';
import 'package:to_do_app/core/app_constants/app_imgs.dart';
import 'package:to_do_app/core/utilties/date_utilities.dart';
import 'package:to_do_app/feature/history/presentation/view_model/history_cubit.dart';
import 'package:to_do_app/feature/history/presentation/view_model/history_state.dart';
import 'package:to_do_app/feature/home/widgets/task_item.dart';
import 'package:to_do_app/feature/task_managemnet/data/model/task_model.dart';

class HistoryTasksScreen extends StatelessWidget {
   HistoryTasksScreen({super.key , required this.type});
  final String type;
  late List<TaskModel> tasks;

  late Map<DateTime, List<TaskModel>> filteredData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      
      builder: (context, state) {
        if(state is HistorySuccessState){
          tasks = state.tasks;
           filteredData = tasks.fold<Map<DateTime, List<TaskModel>>>({}, (map, task) {
      if (type == "pending" ? task.status == Status.pending : task.status == Status.done) {
        map.putIfAbsent(DateUtils.dateOnly(task.date), () => []);
        map[DateUtils.dateOnly(task.date)]!.add(task);
      }
      return map;
    });
    final entries = filteredData.entries.toList();
    entries.sort((a,b){
      return b.key.compareTo(a.key);
    });
    if(filteredData.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Image.asset("${AppImgs.path}no_todo.png")
          ],
        ),
      );
    }
        return ListView.builder(
          itemCount: entries.length,
          itemBuilder: (context, index) {
          final entry = entries[index];
           return Padding(
             padding: const EdgeInsets.symmetric(horizontal: 24.0),
             child: Column(
              crossAxisAlignment: .start,
                children: [
                    SizedBox(height: 20),
                    Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(0xffEEF5FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          DateUtilities.labelDate(entry.key),
                          style: AppFonts.blue12Bold,
                        ),
                      ),
                    ),
                    for (var j in entry.value) ...{
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: TaskItem(task: j),
                      ),
                    },
                ],
              ),
           );
          },
        );
        }
        if(state is HistoryFailState){
          return Column(
            mainAxisAlignment: .center,
            children: [
                Text("sorry , ${state.msg} , please try again")
            ],
          );
        }
        if(state is HistoryLoadingState){
          return Column(
            mainAxisAlignment: .center,
            children: [
                CircularProgressIndicator()
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
