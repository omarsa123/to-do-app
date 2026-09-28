import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/feature/auth/data/model/user_model.dart';
import 'package:to_do_app/feature/auth/presentation/view/login_screen.dart';
import 'package:to_do_app/feature/auth/presentation/view/signup_screen.dart';
import 'package:to_do_app/feature/auth/presentation/view_model/auth_cubit.dart';
import 'package:to_do_app/feature/history/presentation/view/history_screen.dart';
import 'package:to_do_app/feature/history/presentation/view_model/history_cubit.dart';
import 'package:to_do_app/feature/home/presentation/view/home_screen.dart';
import 'package:to_do_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:to_do_app/feature/home/widgets/task_item.dart';
import 'package:to_do_app/feature/task_managemnet/data/model/task_model.dart';
import 'package:to_do_app/feature/task_managemnet/presentation/view/add_task.dart';
import 'package:to_do_app/feature/task_managemnet/presentation/view/edit_task.dart';
import 'package:to_do_app/feature/task_managemnet/presentation/view_model/task_management_cubit.dart';
import 'package:to_do_app/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: "Inter"),
        home: SplashScreen(),
        routes: {
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/home': (_) => MultiBlocProvider(
            providers: [
              BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
              BlocProvider<TaskManagementCubit>(
                create: (context) => TaskManagementCubit(),
              ),
            ],
            child: HomeScreen(),
          ),
          '/add_task': (context) => BlocProvider(
            create: (context) => TaskManagementCubit(),
            child: AddTask(),
          ),
          '/edit_task': (context) => BlocProvider(
            create: (context) => TaskManagementCubit(),
            child: EditTask(),
          ),
          '/history': (context) => MultiBlocProvider(
            providers: [
             BlocProvider<HistoryCubit>(
              create: (context) => HistoryCubit()..getAllTasks(ModalRoute.of(context)!.settings.arguments as UserModel),
             ),
             BlocProvider<TaskManagementCubit>(
              create: (context) => TaskManagementCubit(),
             )
           
            ],
             child: HistoryScreen(),
          ),
        },
      ),
    );
  }
}
