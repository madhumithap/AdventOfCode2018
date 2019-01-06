class Step {
  String id;
  List<Step> successors;
  int numberOfPredecessors;

  Step(this.id, this.successors, [this.numberOfPredecessors = 0]);

  void addSuccessor(Step successor) {
    successors.add(successor);
  }

  bool hasPredecessors() {
    return numberOfPredecessors > 0;
  }

  List<Step> getIndependentSuccessors() {
    return successors.where((successor) => !successor.hasPredecessors()).toList();
  }

  void decrementPredecessorCountFromSuccessors() {
    successors.forEach((successor) { successor.numberOfPredecessors--; });
  }

  int executionTime() {
    return 60 + (id.codeUnitAt(0) - 65 + 1);
  }
}