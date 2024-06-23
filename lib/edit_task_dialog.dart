import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';

class EditTaskDialog extends StatefulWidget {
  final int index;
  final String initialTitle;
  final DateTime? initialDueDate;

  EditTaskDialog({required this.index, required this.initialTitle, this.initialDueDate});

  @override
  _EditTaskDialogState createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _selectedDate = widget.initialDueDate;
    _dateController = TextEditingController(text: widget.initialDueDate?.toLocal().toString().split(' ')[0] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(hintText: 'Enter new task title'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _dateController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Select due date',
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                setState(() {
                  _selectedDate = pickedDate;
                  _dateController.text = _selectedDate!.toLocal().toString().split(' ')[0];
                });
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_titleController.text.isNotEmpty) {
              Provider.of<TaskProvider>(context, listen: false).editTask(widget.index, _titleController.text, _selectedDate);
              Navigator.of(context).pop();
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
