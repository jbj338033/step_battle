import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_battle/providers/step_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StepProvider>(
      builder: (context, stepProvider, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Step Battle')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '오늘의 걸음 수',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  '${stepProvider.steps}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  '보유 에너지',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  '${stepProvider.energy}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
