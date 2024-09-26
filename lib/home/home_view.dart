import 'package:flutter/material.dart';
import 'package:pomotask/pomodoro/pomodoro_view.dart';
import 'package:pomotask/ui/button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
                'Bienvenido a Pomotask',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              SimpleButton(
                onPressed: () {},
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
                onPressed: () {},
                child: const Text('Resumen'),
              ),
              const SizedBox(height: 16),
              Text(
                'Proximos recordatorios',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              const ListTile(
                title: Text('Almuerzo'),
                trailing: Text('10:00 AM'),
              ),
              const ListTile(
                title: Text('Parcial calculo'),
                trailing: Text('12:00 AM'),
              ),
              const ListTile(
                title: Text('Repaso'),
                trailing: Text('02:00 PM'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
