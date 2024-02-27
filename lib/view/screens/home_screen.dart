import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/view/widgets/task_form.dart';
import 'package:todoapp/view/widgets/task_list.dart';
import 'package:todoapp/view/widgets/task_tabs.dart';
import 'package:todoapp/view_model/user_view_model.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/";
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              userViewModel.logout();
            },
          ),
        ],
      ),
      body: const TaskTabs(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
              context: context,
              builder: (context) => const SizedBox(
                  height: 600,
                  child: TaskForm()
              )
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
