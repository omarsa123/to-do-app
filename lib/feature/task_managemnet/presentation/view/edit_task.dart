import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/app_constants/app_colors.dart';
import 'package:to_do_app/core/app_constants/app_fonts.dart';
import 'package:to_do_app/core/utilties/date_utilities.dart';
import 'package:to_do_app/feature/auth/presentation/view_model/auth_cubit.dart';
import 'package:to_do_app/feature/task_managemnet/data/model/task_model.dart';
import 'package:to_do_app/feature/task_managemnet/presentation/view_model/task_management_cubit.dart';
import 'package:to_do_app/feature/task_managemnet/presentation/view_model/task_management_state.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController taskController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!initialized) {
      final task = ModalRoute.of(context)!.settings.arguments as TaskModel;

      final taskCubit = context.read<TaskManagementCubit>();

      taskCubit.selectedTime = task.date;

      taskController.text = task.task;

      initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    TaskModel task = ModalRoute.of(context)!.settings.arguments as TaskModel;
    final currentUser = context.read<AuthCubit>().currentUser;
    final taskCubit = context.read<TaskManagementCubit>();

    return BlocListener<TaskManagementCubit, TaskManagementState>(
      listener: (context, state) {
        if (state is EditTaskFailState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.msg),
              backgroundColor: Color(0xff000000).withAlpha(10),
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
        if (state is EditTaskSuccessState) {
          taskController.clear();
          taskCubit.selectedTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Task Edited successfully.",
                style: AppFonts.blue12Bold.copyWith(color: Colors.white),
              ),
              backgroundColor: Color(0xff000000).withAlpha(150),
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
          Navigator.pop(context);
        }
        if (state is DeleteTaskFailState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.msg),
              backgroundColor: Color(0xff000000).withAlpha(150),
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
        if (state is DeleteTaskSuccessState) {
          taskController.clear();
          taskCubit.selectedTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Task Deleted successfully.",
                style: AppFonts.blue12Bold.copyWith(color: Colors.white),
              ),
              backgroundColor: Color(0xff000000).withAlpha(150),
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<TaskManagementCubit, TaskManagementState>(
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: Text(
                    "New Task",
                    style: AppFonts.blue12Bold.copyWith(fontSize: 16),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () async {
                        final bool isDelete = await showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              content: Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: Column(
                                  mainAxisSize: .min,
                                  children: [
                                    Text("Delete Task" , style: AppFonts.black24Bold,),
                                    Text("Are you sure you want to delete this task?" , style: AppFonts.gray12Bold.copyWith(fontWeight: .w300),),
                                    SizedBox(height: 30,),
                                    Divider(thickness: 1,),
                                     Row(
                                      children: [
                                          Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: ElevatedButton(onPressed: (){
                                              Navigator.pop(context , false);
                                            }, 
                                                                          
                                            child: Text("No")),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: ElevatedButton(onPressed: (){
                                              Navigator.pop(context , true);
                                            },style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white
                                            ),
                                             child: Text("Delete")),
                                          ),
                                        ),
                                       
                                      ]
                                     )
                                  ],
                                  
                                ),
                              )
                            );
                          }),
                        );
                        print(isDelete);
                        if(isDelete){
                          taskCubit.deleteTask(currentUser, task);
                        }
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: TextFormField(
                                    controller: taskController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please Enter a task";
                                      }
                                      return null;
                                    },

                                    decoration: InputDecoration(
                                      label: Text(
                                        "Task",
                                        style: AppFonts.blue12Bold.copyWith(
                                          fontSize: 16,
                                        ),
                                      ),

                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: AppColors.primaryBlue,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24),
                                Divider(thickness: 1),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.event_available_outlined,
                                        size: 30,
                                        color: AppColors.primaryBlue,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8.0,
                                        ),
                                        child: Text(
                                          "Date",
                                          style: AppFonts.black24Bold.copyWith(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 140,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                            255,
                                            234,
                                            239,
                                            246,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () async {
                                            DateTime selected =
                                                await showDatePicker(
                                                  initialDate:
                                                      taskCubit.selectedTime,
                                                  context: context,
                                                  firstDate: DateTime(
                                                    2010,
                                                    1,
                                                    1,
                                                  ),
                                                  lastDate: DateTime(
                                                    2030,
                                                    1,
                                                    1,
                                                  ),
                                                ) ??
                                                taskCubit.selectedTime;
                                            taskCubit.selectDate(selected);
                                          },
                                          child:
                                              BlocBuilder<
                                                TaskManagementCubit,
                                                TaskManagementState
                                              >(
                                                builder: (context, state) {
                                                  return Text(
                                                    DateUtilities.labelDate(
                                                      taskCubit.selectedTime,
                                                    ),
                                                    style: AppFonts.blue12Bold
                                                        .copyWith(
                                                          fontSize: 16,
                                                          fontWeight: .w400,
                                                        ),
                                                  );
                                                },
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Divider(thickness: 1),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                242,
                                246,
                                252,
                              ),
                              foregroundColor: AppColors.primaryBlue,
                            ),
                            child: Text(
                              "Cancel",
                              style: AppFonts.blue12Bold.copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (taskController.text == task.task &&
                                    taskCubit.selectedTime == task.date) {
                                  Navigator.pop(context);
                                } else {
                                  task.task = taskController.text;
                                  task.date = taskCubit.selectedTime;
                                  taskCubit.editTask(currentUser, task);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              "Save This Task",
                              style: AppFonts.blue12Bold.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (state is EditTaskLoadingState) ...{
                Positioned.fill(
                  child: AbsorbPointer(
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              }
              else if (state is DeleteTaskLoadingState) ...{
                Positioned.fill(
                  child: AbsorbPointer(
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              },
            ],
          );
        },
      ),
    );
  }
}
