import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/feature/auth/data/model/user_model.dart';
import 'package:to_do_app/feature/history/presentation/view/history_tasks_screen.dart';
import 'package:to_do_app/feature/history/presentation/view_model/history_cubit.dart';
import 'package:to_do_app/feature/task_managemnet/presentation/view_model/task_management_cubit.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as UserModel;
    return  DefaultTabController(
      length: 2,
      child: MultiBlocProvider(
        providers: [
      BlocProvider<HistoryCubit>(
        create: (context) => HistoryCubit()
          ..getAllTasks(
           user,
          ),
      ),
      BlocProvider<TaskManagementCubit>(
        create: (context) => TaskManagementCubit(),
      ),
        ],
        child: Scaffold(
      appBar: AppBar(
        title: const TabBar(
          dividerHeight: 0,
          tabs: [
            Tab(text: 'Pending'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body:  TabBarView(
        children: [
          HistoryTasksScreen(type: "pending",),
          HistoryTasksScreen(type: "done")
        ],
      ),
        ),
      ),
    );
  }
}
