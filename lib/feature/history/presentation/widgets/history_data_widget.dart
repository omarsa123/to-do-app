import 'package:flutter/material.dart';
import 'package:to_do_app/core/app_constants/app_fonts.dart';
import 'package:to_do_app/core/utilties/date_utilities.dart';
import 'package:to_do_app/feature/home/widgets/task_item.dart';
import 'package:to_do_app/feature/task_managemnet/data/model/task_model.dart';

class HistoryDataWidget extends StatelessWidget {
  const HistoryDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TaskModel> tasks = [
      TaskModel(date: DateTime(2026 , 6 , 7), task: "Do Homework", status: Status.done),
      TaskModel(
        date: DateTime(2026 , 6 , 8),
        task: "Play Football",
        status: Status.pending,
      ),
      TaskModel(
        date: DateTime(2026 , 9 , 26),
        task: "Meet Friends",
        status: Status.pending,
      ),
    ];
    tasks.sort((a, b) { 
                        return a.date.compareTo(b.date);
    });
    return Scaffold(
      body: Column(
        children: [
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16,
              ),
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: ((context, index) => TaskItem(task: tasks[index])),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*
بص الحل عشان متنساش لما تكمل تجيب كل الداتا وبعدين تجيب كل التواريخ وبعدين تماب كل تاريخ بليست من التاسكات فكك بقي من الغبث اللي فوق ده
كcost مش أحسن حاجة بس ده الحل المبدئي نعمله وبعدين نحسن
وطبعا بعد ما تماب كل تاريخ بمجموعة من التاسكات فيال ui ت loop ع كل تاريخ تعرضه وبعدين ب ListView تعرض كل التاسكات المرتبطة بيه
 */