import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_exam/remote/api_service.dart';
import 'package:riverpod_todo_exam/remote/todo.dart';

///
/// riverpod_todo_exam
/// File Name: todo_list_provider
/// Created by sujangmac
///
/// Description:
///
Future<List<ToDo>> fetchToDos(ApiService apiService) async {
  return await apiService.getToDos();
}

class ToDoList extends AsyncNotifier<List<ToDo>> {
  final ApiService apiService = ApiService(
    Dio(),
    baseUrl:
        Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000',
  );

  @override
  Future<List<ToDo>> build() => fetchToDos(apiService);

  void fetchToDoList() async {
    final data = await fetchToDos(apiService);
    state = AsyncData(data);
  }

  void createToDo(String text) async {
    await apiService.createToDo({'text': text});
    final data = await fetchToDos(apiService);
    state = AsyncData(data);
  }

  void updateToDo(String id) async {
    await apiService.updateToDo(id);
    final data = await fetchToDos(apiService);
    state = AsyncData(data);
  }
}

final todoListProvider = AsyncNotifierProvider<ToDoList, List<ToDo>>(() {
  return ToDoList();
});
