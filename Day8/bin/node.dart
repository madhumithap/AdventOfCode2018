class Node {
    int numberOfChildren;
    int numberOfMetaDataEntries;
    List<Node> children = new List();
    List<int> metaData = new List();

  Node(this.numberOfChildren, this.numberOfMetaDataEntries, [this.metaData]);

  bool hasMoreChildren() {
      return children.length < numberOfChildren;
  }

  void addChild(Node child) {
      children.add(child);
  }

  void setMetaData(List<int> metaData) {
      this.metaData = metaData;
  }

  metaDataSum() {
      return metaData.fold(0, (currentSum, data) => currentSum + data);
  }

  getValue() {
      if (children.isEmpty) {
          return metaDataSum();
      }
      return metaData.fold(0, (currentValue, data) {
          if (data <= children.length) {
              currentValue += children[data-1].getValue();
          }
          return currentValue;
      });
  }
}