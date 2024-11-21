import 'package:flutter/foundation.dart';
import '../services/step_counter_service.dart';
import 'package:pedometer/pedometer.dart';

class StepProvider with ChangeNotifier {
  final StepCounterService _stepCounterService = StepCounterService();
  int _steps = 0;
  int _energy = 0;
  String _status = 'unknown';

  int get steps => _steps;
  int get energy => _energy;
  String get status => _status;

  StepProvider() {
    initPlatformState();
  }

  void initPlatformState() {
    _stepCounterService.initPlatformState();

    Pedometer.stepCountStream.listen(
      (StepCount event) {
        _steps = event.steps;
        _calculateEnergy();
        notifyListeners();
      },
      onError: (error) {
        print('Step count error: $error');
      },
    );

    Pedometer.pedestrianStatusStream.listen(
      (PedestrianStatus event) {
        _status = event.status;
        notifyListeners();
      },
      onError: (error) {
        print('Pedestrian status error: $error');
      },
    );
  }

  void _calculateEnergy() {
    // 1000걸음당 100에너지로 변환
    _energy = (_steps / 1000 * 100).floor();
  }
}
