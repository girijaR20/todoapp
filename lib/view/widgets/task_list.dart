import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/view/widgets/share_task_model.dart';
import 'package:todoapp/view/widgets/task_form.dart';
import 'package:todoapp/view_model/task_view_model.dart';
import 'package:todoapp/view_model/user_view_model.dart';

class TaskList extends StatelessWidget {
  final bool shared;
  const TaskList({super.key, this.shared = false});
  @override
  Widget build(BuildContext context) {
    final currentUserId = Provider.of<UserViewModel>(context).currentUserId;
    return Consumer<TaskViewModel>(
      builder: (context, taskViewModel, child) {
        List<Task> tasks = shared ? taskViewModel.sharedTasks : taskViewModel.tasks;
        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            Task task = tasks[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Handle update action
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
                            context: context,
                            builder: (context) => SizedBox(
                              height: 600,
                              child: TaskForm(isEdit:true, task: task)
                            )
                          );
                        },
                      ),
                      if (task.owner == currentUserId)
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(25))
                              ),
                              context: context,
                              builder: (context) => SizedBox(
                                  height: 600,
                                  child: ShareTaskModal(task: task)),
                            );
                          },
                        ),
                      if (task.owner == currentUserId)
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            taskViewModel.deleteTask(task.id);
                          },
                        ),
                    ],
                  )
              ),
            );
          },
        );
      },
    );
  }
}