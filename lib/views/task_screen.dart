import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Map<String, dynamic>> tasks = []; // Store tasks with a completion state

  @override
  void initState() {
    super.initState();
    // Initialize the task list with one default task
    tasks.add({
      'title': 'Default Task', // Default task title
      'isCompleted': false, // Default task is not completed
    });
  }

  // Add task to the list
  void _addTask(String task) {
    setState(() {
      tasks.add({
        'title': task,
        'isCompleted': false, // Default state is not completed
      });
    });
  }

  // Toggle task completion state
  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index]['isCompleted'] = !tasks[index]['isCompleted'];
    });
  }

  // Show dialog to add a new task
  void _showAddTaskDialog() {
    TextEditingController taskController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(hintText: 'Enter task name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  _addTask(taskController.text);
                  Navigator.pop(context); // Close the dialog
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Delete task
  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index); // Remove task from the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Dismissible(
            key: Key(task['title']),
            direction: DismissDirection
                .endToStart, // Swipe from right to left to delete
            onDismissed: (direction) {
              // Handle the deletion
              _deleteTask(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${task['title']} deleted')),
              );
            },
            background: Container(
              color: Colors.red, // Background color when swiping
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                _toggleTaskCompletion(
                    index); // Toggle the checkbox state on tap
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: task['isCompleted']
                        ? const Color(0xFF252525)
                        : const Color.fromARGB(255, 48, 46, 46),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: task['isCompleted'],
                        onChanged: (bool? value) {
                          _toggleTaskCompletion(index); // Update checkbox state
                        },
                      ),
                      Expanded(
                        child: Text(
                          task['title'],
                          style: TextStyle(
                            fontSize: 18.0,
                            decoration: task['isCompleted']
                                ? TextDecoration.lineThrough
                                : TextDecoration
                                    .none, // Strike-through if completed
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        tooltip: 'Add Task', // Show dialog to add new task
        child: const Icon(Icons.add),
      ),
    );
  }
}
