import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/app_constants/app_colors.dart';
import 'package:to_do_app/core/app_constants/app_fonts.dart';
import 'package:to_do_app/core/app_constants/app_imgs.dart';
import 'package:to_do_app/feature/auth/data/model/user_model.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/feature/auth/presentation/view_model/auth_cubit.dart';
import 'package:to_do_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:to_do_app/feature/home/presentation/view_model/home_state.dart';
import 'package:to_do_app/feature/home/widgets/task_item.dart';
import 'package:to_do_app/feature/task_managemnet/data/model/task_model.dart';
import 'package:to_do_app/feature/task_managemnet/presentation/view_model/task_management_cubit.dart';
import 'package:to_do_app/feature/task_managemnet/presentation/view_model/task_management_state.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatePickerController cont = DatePickerController();

  final DateTime firstDate = DateTime(2010, 1, 1);

  final DateTime lastDate = DateTime(2030, 1, 1);
  late UserModel currentUser ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final homeCubit = context.read<HomeCubit>();
    currentUser = context.read<AuthCubit>().currentUser!;
    homeCubit.changeTargetDate(DateTime.now(), currentUser);
    WidgetsBinding.instance.addPostFrameCallback((_) {
                    cont.animateToDate(
                      DateTime.now(),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  });
  }

  @override
  Widget build(BuildContext context) {
    currentUser = context.read<AuthCubit>().currentUser!;
    //, ${currentUser.name}
    final homeCubit = context.read<HomeCubit>();
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeFailState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.msg)));
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add_task');
          },
          child: Icon(Icons.add, color: Colors.white, size: 28),
          backgroundColor: Color(0xff0560FA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        appBar: AppBar(
          leading: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  DateTime selected =
                      await showDatePicker(
                        initialDate: state.ccurrentDate,
                        context: context,
                        firstDate: DateTime(2010, 1, 1),
                        lastDate: DateTime(2030, 1, 1),
                      ) ??
                      state.ccurrentDate;
                  homeCubit.changeTargetDate(selected, currentUser);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    cont.animateToDate(
                      selected,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  });
                },
                icon: Icon(Icons.event_available_outlined, size: 28),
                color: AppColors.primaryBlue,
              );
            },
          ),

          title: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return TextButton(
                onPressed: () async {
                  DateTime selected =
                      await showDatePicker(
                        initialDate: state.ccurrentDate,
                        context: context,
                        firstDate: DateTime(2010, 1, 1),
                        lastDate: DateTime(2030, 1, 1),
                      ) ??
                      state.ccurrentDate;
                  homeCubit.changeTargetDate(selected, currentUser);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    cont.animateToDate(
                      selected,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  });
                },
                child: Text(
                  "${DateUtils.dateOnly(state.ccurrentDate) == DateUtils.dateOnly(DateTime.now()) ? "Today" : (DateUtils.dateOnly(state.ccurrentDate) == DateUtils.dateOnly(DateTime.now()).subtract(Duration(days: 1)) ? "yesterday" : (DateUtils.dateOnly(state.ccurrentDate) == DateUtils.dateOnly(DateTime.now()).add(Duration(days: 1)) ? "Tomorrow" : DateFormat('dd MMM, yyyy').format(state.ccurrentDate)))}",
                  style: AppFonts.blue12Bold.copyWith(fontSize: 20),
                ),
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/history' , arguments: currentUser);
              },
              icon: Icon(Icons.checklist_rounded),
              color: AppColors.primaryBlue,
              iconSize: 28,
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: .start,
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return DatePicker(
                    key: ValueKey(
                      '${state.ccurrentDate.year}-${state.ccurrentDate.month}-${state.ccurrentDate.day}',
                    ),
                    controller: cont,

                    DateTime(
                      state.ccurrentDate.year,
                      state.ccurrentDate.month,
                      1,
                    ),

                    daysCount: DateUtils.getDaysInMonth(
                      state.ccurrentDate.year,
                      state.ccurrentDate.month,
                    ),
                    initialSelectedDate: state.ccurrentDate,
                    selectionColor: Color(0xff0560FA),
                    selectedTextColor: Colors.white,
                    onDateChange: (selectedDate) {
                      homeCubit.changeTargetDate(selectedDate, currentUser);

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        cont.animateToDate(
                          selectedDate,
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeOutCubic,
                        );
                      });
                    },
                  );
                },
              ),
              BlocListener<TaskManagementCubit, TaskManagementState>(
                listener: (context, state) {
                  if (state is UpdateTaskSuccessState) {
                    context.read<HomeCubit>().updateTask(state.task);
                  }
                },
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      );
                    }
                    if (state is HomeSuccessState) {
                      state.tasks.sort((a, b) {
                        // Pending first
                        if (a.status == Status.pending &&
                            b.status == Status.done) {
                          return -1;
                        }

                        if (a.status == Status.done &&
                            b.status == Status.pending) {
                          return 1;
                        }
                        
                        return a.date.compareTo(b.date);
                      });
                      print(state.tasks);
                      print(state.tasks.isEmpty);
                      if (state.tasks.isEmpty) {
                        return Expanded(
                          child: Image.asset("${AppImgs.path}no_todo.png"),
                        );
                      } else {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 16),
                            child: ListView.builder(
                              itemCount: state.tasks.length,
                              itemBuilder: ((context, index) =>
                                  TaskItem(task: state.tasks[index])),
                            ),
                          ),
                        );
                      }
                    }
                    return SizedBox();
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
