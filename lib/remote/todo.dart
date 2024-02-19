import 'package:json_annotation/json_annotation.dart';

///
/// riverpod_todo_exam
/// File Name: todo
/// Created by sujangmac
///
/// Description:
///

part 'todo.g.dart';

@JsonSerializable()
class ToDo {
  @JsonKey(name: '_id')
  final String id;
  final String text;
  final bool done;

  const ToDo({required this.id, required this.text, required this.done});

  factory ToDo.fromJson(Map<String, dynamic> json) => _$ToDoFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoToJson(this);
}
