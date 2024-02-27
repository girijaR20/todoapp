import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/view_model/task_view_model.dart';
import 'package:todoapp/view_model/user_view_model.dart';

class ShareTaskModal extends StatefulWidget {
  final Task task;
  const ShareTaskModal({super.key, required this.task});
  @override
  _ShareTaskModalState createState() => _ShareTaskModalState();
}

class _ShareTaskModalState extends State<ShareTaskModal> {
  final TextEditingController _searchController = TextEditingController();
  Map<String, String> userMap = {};

  @override
  Widget build(BuildContext context) {
    final Task task = widget.task;
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Share Task',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TypeAheadField(
            controller: _searchController,
            builder: (context, controller, focusNode) {
              return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  )
              );
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion.toString()),
              );
            },
            onSelected: (suggestion) {
              _searchController.text = suggestion;
            },
            suggestionsCallback: (pattern) async {
              QuerySnapshot<Map<String, dynamic>> snapshot = await userViewModel.searchUser(pattern, task.owner!);
              List<String> emails = [];
              for (var doc in snapshot.docs) {
                if (doc['uid'] != task.owner) {
                  emails.add(doc['email']);
                  userMap[doc['email']] = doc['uid'];
                }
              }
              return emails;
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                String email = _searchController.text;
                if (task.sharedWith != null && task.sharedWith!.isNotEmpty) {
                  if (!task.sharedWith!.contains(userMap[email])) {
                    task.sharedWith!.add(userMap[email]!);
                  }
                } else {
                  task.sharedWith = [userMap[email]!];
                }
                taskViewModel.updateTask(task);
                Navigator.pop(context);
              },
              child: const Text('Share'),
            ),
          ),
        ],
      ),
    );
  }
}
