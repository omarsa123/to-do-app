import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/app_constants/app_fonts.dart';
import 'package:to_do_app/core/utilties/date_utilities.dart';
import 'package:to_do_app/feature/auth/presentation/view_model/auth_cubit.dart';
import 'package:to_do_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:to_do_app/feature/home/presentation/view_model/home_state.dart';
import 'package:to_do_app/feature/task_managemnet/data/model/task_model.dart';
import 'package:to_do_app/feature/task_managemnet/presentation/view_model/task_management_cubit.dart';
import 'package:to_do_app/feature/task_managemnet/presentation/view_model/task_management_state.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    final taskManagementCubit = context.read<TaskManagementCubit>();
    final authCubit = context.read<AuthCubit>();
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/edit_task' , arguments: task);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 213, 229, 249),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.7,
                child: BlocBuilder<TaskManagementCubit, TaskManagementState>(
                  builder: (context, state) {
                    return Checkbox(
                      value: task.status == Status.done,
                      onChanged: (value) {
                        taskManagementCubit.updateTaskStatus(
                          authCubit.currentUser,
                          task,
                        );
                      },
                      side: BorderSide(
                        width: 0,
                        color: Color.fromARGB(255, 213, 229, 249),
                      ),
                      fillColor: WidgetStateColor.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return Color(0xff0560FA).withAlpha(140);
                        }
                        return Color.fromARGB(255, 213, 229, 249);
                      }),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: BlocBuilder<TaskManagementCubit, TaskManagementState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          task.task,
                          style: task.status == Status.pending
                              ? AppFonts.black24Bold.copyWith(
                                  fontSize: 18,
                                  fontWeight: .w500,
                                )
                              : AppFonts.blue18MediumWithThroughLine,
                        ),
                        if (task.status == Status.done)
                          Text(
                            "${DateUtilities.labelDate(task.completedAt!)} at ${DateUtilities.formatTime(task.completedAt!)}",
                            style: AppFonts.lightGray12Light,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
