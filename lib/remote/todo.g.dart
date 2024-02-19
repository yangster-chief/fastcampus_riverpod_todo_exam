// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDo _$ToDoFromJson(Map<String, dynamic> json) => ToDo(
      id: json['_id'] as String,
      text: json['text'] as String,
      done: json['done'] as bool,
    );

Map<String, dynamic> _$ToDoToJson(ToDo instance) => <String, dynamic>{
      '_id': instance.id,
      'text': instance.text,
      'done': instance.done,
    };
