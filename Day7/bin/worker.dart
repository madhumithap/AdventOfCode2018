import 'step.dart';

class Worker {
    Step executingStep;
    int remainingSeconds = 0;

  void assignStep(Step step) {
      executingStep = step;
      remainingSeconds = step.executionTime();
  }
}