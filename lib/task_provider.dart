import 'package:flutter/material.dart';
import 'task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(String title, DateTime? dueDate) {
    _tasks.add(Task(title: title, dueDate: dueDate));
    notifyListeners();
  }

  void toggleTaskCompletion(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    notifyListeners();
  }

  void editTask(int index, String newTitle, DateTime? newDueDate) {
    _tasks[index].title = newTitle;
    _tasks[index].dueDate = newDueDate;
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}
