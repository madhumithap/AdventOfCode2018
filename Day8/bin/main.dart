import 'dart:convert';
import 'dart:io';

import 'node.dart';

main(List<String> arguments) async {
    var licenseString = await _readLicenseFile();
    var topMostNode = _parseLicenseString(licenseString);
    var sum = _computeMetaDataSum(topMostNode);
    print("sum of metadata is $sum");
    var value = _computeTopMostNodeValue(topMostNode);
    print("Value of topmost node is $value");
}

_computeTopMostNodeValue(Node topMostNode) {
    return topMostNode.getValue();
}

_computeMetaDataSum(Node topMostNode) {
    var nodes = [topMostNode];
    var sum = 0;
    while (nodes.isNotEmpty) {
        sum = nodes.fold(sum, (currentSum, currentNode) => currentSum + currentNode.metaDataSum());
        nodes = nodes.map((node) => node.children).expand((n) => n).toList();
    }
    return sum;
}

Node _parseLicenseString(String licenseString) {
  List<int> licenseNumbers = licenseString.split(' ').map((s) => int.parse(s)).toList();
  var parent = null;
  var child = null;
  var nodeStack = new List<Node>();
  for (int index = 0; index < licenseNumbers.length; index += 2) {
      var numberOfChildren = licenseNumbers[index];
      nodeStack.add(new Node(numberOfChildren, licenseNumbers[index + 1]));
      if (numberOfChildren == 0) {
          do {
              child = nodeStack.removeLast();
              var metadata = licenseNumbers.sublist(index + 2, index + 2 + child.numberOfMetaDataEntries);
              child.setMetaData(metadata);
              index += metadata.length;
              if (nodeStack.isNotEmpty) {
                  parent = nodeStack.last;
                  parent.addChild(child);
              }
          } while (!parent.hasMoreChildren() && nodeStack.isNotEmpty);
      }
  }
  return child;
}

Future<String> _readLicenseFile() async {
    var tree = "";
    var lines = File("input/input.txt")
        .openRead()
        .transform(utf8.decoder)
        .transform(const LineSplitter());
    try {
        await for (var line in lines) {
            tree += line;
        }
    } catch (e) {
        print("Can't read file $e");
    }
    return tree;
}