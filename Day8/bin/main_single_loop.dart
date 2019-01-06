import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'node.dart';

main(List<String> arguments) async {
    var tree = await _readTree();
    var sum = _findSumOfMetadata(tree);
    print("sum of metadata is $sum");
}

int _findSumOfMetadata(String tree) {
    var sum = 0;
    List<String> nodes = tree.split(' ');
    var remainingChildrenMap = new HashMap<Node, int>();
    var nodeStack = new List<Node>();
    for (int index = 0; index < nodes.length; index += 2) {
        var numberOfChildren = int.parse(nodes[index]);
        var numberOfMetaDataEntries = int.parse(nodes[index + 1]);
        if (numberOfChildren == 0) {
            var child = new Node(numberOfChildren, numberOfMetaDataEntries);
            var startIndex = index + 2;
            var metadata = nodes.sublist(startIndex, startIndex + numberOfMetaDataEntries);
            while(true) {
                var parent = nodeStack.last;
                sum = metadata.fold(sum, (currentSum, data) => currentSum + int.parse(data));
                index += metadata.length;
                remainingChildrenMap[parent]--;
                if (remainingChildrenMap[parent] > 0) break;
                child = nodeStack.removeLast();
                startIndex = index + 2;
                metadata = nodes.sublist(startIndex, startIndex + child.numberOfMetaDataEntries);
                if (nodeStack.isEmpty) {
                    sum = metadata.fold(sum, (currentSum, data) => currentSum + int.parse(data));
                    index += metadata.length;
                    break;
                }
            }
        } else {
            var node = new Node(numberOfChildren, numberOfMetaDataEntries);
            remainingChildrenMap.putIfAbsent(node, () => node.numberOfChildren);
            nodeStack.add(node);
        }
    }
    return sum;
}

Future<String> _readTree() async {
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