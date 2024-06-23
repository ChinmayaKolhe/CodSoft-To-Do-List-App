import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/add_task_dialog.dart';
import 'package:todolist/edit_task_dialog.dart';
import 'task_provider.dart';
import 'task.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('To Do List App'),
          backgroundColor: Colors.cyanAccent,
        ),
        body: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            return ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: task.dueDate != null
                      ? Text('Date: ${task.dueDate!.toLocal().toString().split(' ')[0]}')
                      : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return EditTaskDialog(
                                index: index,
                                initialTitle: task.title,
                                initialDueDate: task.dueDate,
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          taskProvider.deleteTask(index);
                        },
                      ),
                      Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) {
                          taskProvider.toggleTaskCompletion(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddTaskDialog();
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
