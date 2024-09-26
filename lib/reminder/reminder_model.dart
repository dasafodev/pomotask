import 'dart:convert';

import 'package:flutter/material.dart';

class ReminderModel {
  final String title;
  final DateTime date;
  final TimeOfDay time;
  final bool isCompleted;
  final String? note;

  ReminderModel({
    required this.title,
    required this.date,
    required this.time,
    this.isCompleted = false,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.toIso8601String(),
      'time': time.hour.toString() + ':' + time.minute.toString(),
      'isCompleted': isCompleted,
      'note': note,
    };
  }

  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      title: json['title'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
          hour: int.parse(json['time'].split(':')[0]),
          minute: int.parse(json['time'].split(':')[1])),
      isCompleted: json['isCompleted'],
      note: json['note'],
    );
  }

  String toSharedPreferencesString() {
    return jsonEncode(toJson());
  }

  factory ReminderModel.fromSharedPreferencesString(String jsonString) {
    return ReminderModel.fromJson(jsonDecode(jsonString));
  }
}
