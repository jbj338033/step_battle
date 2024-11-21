import 'package:pedometer/pedometer.dart';

class StepCounterService {
  Stream<StepCount>? _stepCountStream;
  Stream<PedestrianStatus>? _pedestrianStatusStream;

  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream;
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;

    _stepCountStream?.listen(
      onStepCount,
      onError: onStepCountError,
      cancelOnError: true,
    );

    _pedestrianStatusStream?.listen(
      onPedestrianStatusChanged,
      onError: onPedestrianStatusError,
      cancelOnError: true,
    );
  }

  void onStepCount(StepCount event) {
    // 걸음 수 업데이트 처리
    print('Steps taken: ${event.steps}');
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    // 보행 상태 변경 처리
    print('Pedestrian status: ${event.status}');
  }

  void onStepCountError(error) {
    print('Step count error: $error');
  }

  void onPedestrianStatusError(error) {
    print('Pedestrian status error: $error');
  }
}
