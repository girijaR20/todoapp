import 'package:flutter/material.dart';
import 'package:todoapp/view/widgets/task_list.dart';

class TaskTabs extends StatelessWidget {
  const TaskTabs({super.key});
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'My Tasks'),
              Tab(text: 'Shared with Me'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                TaskList(),
                TaskList(shared: true),
                //Text("Shared with me")
              ],
            ),
          ),
        ],
      ),
    );
  }
}