import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_exam/remote/todo.dart';
import 'package:riverpod_todo_exam/screen/provider/todo_list_provider.dart';

///
/// riverpod_todo_exam
/// File Name: todo_list_screen
/// Created by sujangmac
///
/// Description:
///

class ToDoListScreen extends ConsumerStatefulWidget {
  const ToDoListScreen({super.key});

  @override
  ConsumerState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends ConsumerState<ToDoListScreen> {
  void _addNewTodo() async {
    final text = await _showAddToDoDialog();
    if (text != null && text.isNotEmpty) {
      ref.read(todoListProvider.notifier).createToDo(text);
    }
  }

  void _toggleToDoStatus(ToDo toDo) {
    ref.read(todoListProvider.notifier).updateToDo(toDo.id);
  }

  Future<String?> _showAddToDoDialog() {
    TextEditingController controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New ToDO'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Ender ToDo text here'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: const Text('Add')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('ToDo List')),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.read(todoListProvider.notifier).fetchToDoList();
          },
          child: ref.watch(todoListProvider).when(
              data: (data) => ListView(
                    children: data
                        .map((toDo) => ToDoItem(
                            toDo: toDo,
                            onChecked: () => _toggleToDoStatus(toDo)))
                        .toList(),
                  ),
              error: (error, stack) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addNewTodo,
          tooltip: 'Add ToDo',
          child: const Icon(Icons.add),
        ),
      );
}

class ToDoItem extends StatelessWidget {
  final ToDo toDo;
  final VoidCallback onChecked;

  const ToDoItem({super.key, required this.toDo, required this.onChecked});

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(toDo.text),
        leading: Checkbox(
          value: toDo.done,
          onChanged: (bool? value) => onChecked(),
        ),
      );
}
