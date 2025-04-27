// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:note_space/models/task_model.dart';

// class TaskListView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<TaskModel>>(
//       future: getTasks(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }
//         if (snapshot.hasData) {
//           var tasks = snapshot.data!;
//           return ListView.builder(
//             itemCount: tasks.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(tasks[index].title),
//                 subtitle: Text(tasks[index].description),
//                 trailing: Checkbox(
//                   value: tasks[index].isCompleted,
//                   onChanged: (value) {
//                     tasks[index].isCompleted = value!;
//                     tasks[index].save();  // حفظ التعديل في Hive
//                   },
//                 ),
//                 onLongPress: () {
//                   deleteTask(index);  // حذف المهمة عند الضغط الطويل
//                 },
//               );
//             },
//           );
//         } else {
//           return Text('No tasks found.');
//         }
//       },
//     );
//   }
// }
