import 'package:flutter/material.dart';
import 'package:pomotask/reminder/reminder_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderRepository {
  static final ReminderRepository _instance = ReminderRepository._internal();
  bool _isInitialized = false;

  factory ReminderRepository() {
    return _instance;
  }

  ReminderRepository._internal() {
    _initializeDefaultReminders();
  }

  static const String _remindersKey = 'reminders';

  Future<void> addReminder(ReminderModel reminder) async {
    final prefs = await SharedPreferences.getInstance();
    final reminders = await getReminders();
    reminders.add(reminder);
    final remindersJson =
        reminders.map((r) => r.toSharedPreferencesString()).toList();
    await prefs.setStringList(_remindersKey, remindersJson);
  }

  Future<List<ReminderModel>> getReminders() async {
    if (!_isInitialized) {
      await Future.delayed(Duration(seconds: 2));
    }
    final prefs = await SharedPreferences.getInstance();
    final remindersJson = prefs.getStringList(_remindersKey) ?? [];
    return remindersJson
        .map((r) => ReminderModel.fromSharedPreferencesString(r))
        .toList();
  }

  Future<void> _initializeDefaultReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final remindersJson = prefs.getStringList(_remindersKey);

    if (remindersJson == null || remindersJson.isEmpty) {
      final defaultReminders = [
        ReminderModel(
          title: 'Taller de programación',
          date: DateTime.now(),
          time: TimeOfDay.now(),
          isCompleted: false,
          note: 'Taller de programación',
        ),
        ReminderModel(
          title: 'Parcial de programación',
          date: DateTime.now().add(Duration(hours: 1)),
          time: TimeOfDay.now(),
          isCompleted: false,
          note: 'Taller de programación',
        ),
        ReminderModel(
          title: 'Parcial de matemáticas',
          date: DateTime.now().add(Duration(hours: 2)),
          time: TimeOfDay.now(),
          isCompleted: false,
          note: 'Taller de programación',
        ),
        ReminderModel(
          title: 'Taller de matemáticas',
          date: DateTime.now().add(Duration(days: 1)),
          time: TimeOfDay.now(),
          isCompleted: false,
          note: 'Taller de matemáticas',
        ),
        ReminderModel(
          title: 'Taller de física',
          date: DateTime.now().add(Duration(days: 2)),
          time: TimeOfDay.now(),
          isCompleted: false,
          note: 'Taller de física',
        ),
      ];

      final remindersJson =
          defaultReminders.map((r) => r.toSharedPreferencesString()).toList();
      await prefs.setStringList(_remindersKey, remindersJson);
      _isInitialized = true;
      print(
          'Recordatorios predeterminados inicializados: ${defaultReminders.length}');
    } else {
      print('Recordatorios existentes encontrados: ${remindersJson.length}');
    }
  }
}
