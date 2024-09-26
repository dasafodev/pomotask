import 'package:flutter/material.dart';
import 'package:pomotask/reminder/reminder_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderRepository {
  static final ReminderRepository _instance = ReminderRepository._internal();

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
          title: 'Reminder 1',
          date: DateTime.now(),
          time: TimeOfDay.now(),
          isCompleted: false,
          note: 'This is the first default reminder',
        ),
        ReminderModel(
          title: 'Reminder 2',
          date: DateTime.now().add(Duration(days: 1)),
          time: TimeOfDay.now(),
          isCompleted: false,
          note: 'This is the second default reminder',
        ),
        ReminderModel(
          title: 'Reminder 3',
          date: DateTime.now().add(Duration(days: 2)),
          time: TimeOfDay.now(),
          isCompleted: false,
          note: 'This is the third default reminder',
        ),
      ];

      final remindersJson =
          defaultReminders.map((r) => r.toSharedPreferencesString()).toList();
      await prefs.setStringList(_remindersKey, remindersJson);
    }
  }
}
