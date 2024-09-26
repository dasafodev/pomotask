import 'package:flutter/material.dart';
import 'package:pomotask/reminder/create_reminder_view.dart';
import 'package:pomotask/reminder/reminder_model.dart';
import 'package:pomotask/reminder/reminder_repository.dart';
import 'package:pomotask/ui/button.dart';

class ReminderView extends StatefulWidget {
  @override
  _ReminderViewState createState() => _ReminderViewState();
}

class _ReminderViewState extends State<ReminderView> {
  List<ReminderModel> todayReminders = [];
  List<ReminderModel> upcomingReminders = [];

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    final reminders = await ReminderRepository().getReminders();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    setState(() {
      todayReminders = reminders.where((r) {
        final reminderDate = DateTime(r.date.year, r.date.month, r.date.day);
        return reminderDate == today;
      }).toList();

      upcomingReminders = reminders.where((r) {
        final reminderDate = DateTime(r.date.year, r.date.month, r.date.day);
        return reminderDate.isAfter(today);
      }).toList();
    });
  }

  Future<void> _navigateToCreateReminder() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateReminderView()),
    );
    if (result == true) {
      _loadReminders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recordatorios'),
      ),
      body: ListView(
        children: [
          _buildSection('Hoy', todayReminders),
          _buildSection('Próximos', upcomingReminders),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Button(
            onPressed: _navigateToCreateReminder,
            child: Text('Crear recordatorio'),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<ReminderModel> reminders) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              final reminder = reminders[index];
              return ListTile(
                title: Text(reminder.title),
                subtitle: Text(reminder.formattedDate),
                trailing: Text(reminder.time.format(context)),
              );
            },
          ),
        ],
      ),
    );
  }
}
