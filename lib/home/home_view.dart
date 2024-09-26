import 'package:flutter/material.dart';
import 'package:pomotask/pomodoro/pomodoro_view.dart';
import 'package:pomotask/reminder/reminder_model.dart';
import 'package:pomotask/reminder/reminder_repository.dart';
import 'package:pomotask/reminder/reminder_view.dart';
import 'package:pomotask/summary/summary_view.dart';
import 'package:pomotask/ui/button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ReminderModel> todayReminders = [];
  late ReminderRepository _reminderRepository;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _reminderRepository = ReminderRepository();
    _loadTodayReminders();
  }

  Future<void> _loadTodayReminders() async {
    setState(() {
      _isLoading = true;
    });

    final reminders = await _reminderRepository.getReminders();
    print('Todos los recordatorios: ${reminders.length}'); // Añadir esta línea

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    setState(() {
      todayReminders = reminders.where((r) {
        final reminderDate = DateTime(r.date.year, r.date.month, r.date.day);
        return reminderDate.isAtSameMomentAs(today);
      }).toList();
      print(
          'Recordatorios de hoy: ${todayReminders.length}'); // Añadir esta línea
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bienvenido',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              SimpleButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReminderView()),
                  );
                },
                child: const Text('Recordatorios'),
              ),
              const SizedBox(height: 8),
              SimpleButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PomodoroView()),
                  );
                },
                child: const Text('Pomodoro'),
              ),
              const SizedBox(height: 8),
              SimpleButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SummaryView()),
                  );
                },
                child: const Text('Resumen'),
              ),
              const SizedBox(height: 16),
              Text(
                'Próximos recordatorios',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: todayReminders.length,
                        itemBuilder: (context, index) {
                          final reminder = todayReminders[index];
                          return ListTile(
                            title: Text(reminder.title),
                            trailing: Text(reminder.time.format(context)),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
