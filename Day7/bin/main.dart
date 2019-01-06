import 'dart:io';
import 'dart:convert';
import 'dart:collection';

import 'step.dart';
import 'worker.dart';

main(List<String> arguments) async {
    var instructions = await _readInstructions();
    var order = _findOrderOfStepExecution(instructions);
    print('order of step execution is $order');
    var time = _findTotalTimeTaken(instructions);
    print('total time taken is $time');
}

String _findOrderOfStepExecution(List<String> instructions) {
    var steps = _parseInstructions(instructions);
    var independentSteps = _findIndependentSteps(steps);
    var orderOfExecution = "";
    var currentStep = null;
    do {
        sort(independentSteps);
        currentStep = independentSteps[0];
        List<Step> remainingSteps = independentSteps.sublist(1);
        orderOfExecution += currentStep.id;
        currentStep.decrementPredecessorCountFromSuccessors();
        independentSteps = currentStep.getIndependentSuccessors() + remainingSteps;
        if (independentSteps.isEmpty) {
            currentStep = null;
        }
    } while (currentStep != null);
    return orderOfExecution;
}

List<Step> _findIndependentSteps(List<Step> steps) {
    return steps.where((step) => !step.hasPredecessors()).toList();
}

void sort(List<Step> steps) {
    steps.sort((s1, s2) => s1.id.compareTo(s2.id));
}

int _findTotalTimeTaken(List<String> instructions) {
    var steps = _parseInstructions(instructions);
    var independentSteps = _findIndependentSteps(steps);
    var workers = _createWorkers(5);
    var remainingSteps = _assignStepsToWorkers(independentSteps, workers);
    int totalTime = 0;
    while (!_areWorkersIdle(workers)) {
        totalTime++;
        var completedSteps = _getCompletedStepsAfterDecrementRemainingTime(workers);
        if (completedSteps.isNotEmpty) {
            completedSteps.forEach((step) => step.decrementPredecessorCountFromSuccessors());
            var completedStepsSuccessors = completedSteps.map((step) => step.getIndependentSuccessors())
                .expand((s) => s).toList();
            var nextSteps = completedStepsSuccessors + remainingSteps;
            if (nextSteps.isNotEmpty) {
                sort(nextSteps);
                remainingSteps = _assignStepsToWorkers(nextSteps,
                    workers.where((worker) => worker.executingStep == null).toList());
            }
        }
    }
    return totalTime;
}

List<Step> _getCompletedStepsAfterDecrementRemainingTime(List<Worker> workers) {
    var completedSteps = new List<Step>();
    var executingWorkers = workers.where((worker) => worker.executingStep != null);
    executingWorkers.forEach((worker) { 
        worker.remainingSeconds--;
        if (worker.remainingSeconds == 0) {
            completedSteps.add(worker.executingStep);
            worker.executingStep = null;
        }
    });
    return completedSteps;
}

bool _areWorkersIdle(List<Worker> workers) {
    return workers.where((worker) => worker.executingStep != null).isEmpty;
}

List<Step> _assignStepsToWorkers(List<Step> steps, List<Worker> workers) {
    var executionSteps = steps.take(workers.length).toList();
    for (int index = 0; index < executionSteps.length; index++) {
        workers[index].assignStep(executionSteps[index]);
    }
    return steps.length > workers.length ? steps.sublist(workers.length) : new List<Step>();
}

List<Worker> _createWorkers(int numberOfWorkers) {
    var workers = new List<Worker>();
    for (int index = 0; index < numberOfWorkers; index++) {
        workers.add(new Worker());
    }
    return workers;
}

List<Step> _parseInstructions(List<String> instructions) {
    var stepMap = new HashMap<String, Step>();
    for (String instruction in instructions) {
        var split = instruction.split(' ');
        var parentId = split[1];
        var successorId = split[7];

        stepMap.update(successorId, (successorStep) {
            successorStep.numberOfPredecessors++;
            return successorStep;
        }, ifAbsent: () {
            return Step(successorId, new List<Step>(), 1);
        });

        stepMap.update(parentId, (parentStep) {
            parentStep.addSuccessor(stepMap[successorId]);
            return parentStep;
        }, ifAbsent: () {
            var successors = new List<Step>();
            successors.add(stepMap[successorId]);
            return Step(parentId, successors);
        });
    }
    return stepMap.values.toList();
}

Future<List<String>> _readInstructions() async {
    var steps = List<String>();
    var lines = File("input/input.txt")
        .openRead()
        .transform(utf8.decoder)
        .transform(const LineSplitter());
    try {
        await for (var line in lines) {
            steps.add(line);
        }
    } catch (e) {
        print("Can't read file $e");
    }
    return steps;
}