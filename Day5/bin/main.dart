import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:core';
import 'dart:math';

main(List<String> arguments) async {
    var polymer = await _readPolymer();
    var unReactingPolymerUnits = _findNumberOfUnReactingPolymerUnits(polymer);
    print("number of unreacting polymer units is $unReactingPolymerUnits");
    var shortestUnReactingPolymerUnits = _findShortestUnReactingPolymerUnits(polymer);
    print("shortest unreacting polymer units is $shortestUnReactingPolymerUnits");
}

int _findShortestUnReactingPolymerUnits(String polymer) {
    var unReactingPolymerUnits = new List<int>();
    var characters = _uniqueCharacters(polymer);
    characters.forEach((String characterString) {
        var reducedPolymer = polymer
            .replaceAll(characterString.toLowerCase(), "")
            .replaceAll(characterString.toUpperCase(), "");
        unReactingPolymerUnits.add(_findNumberOfUnReactingPolymerUnits(reducedPolymer));
    });
    return unReactingPolymerUnits.reduce(min);
}

Iterable<String> _uniqueCharacters(String polymer) {
    var lowerCasedPolymer = polymer.toLowerCase();
    var characterMap = new HashMap<String, int>();
    for (int index = 0; index < lowerCasedPolymer.length; index++) {
        characterMap.putIfAbsent(polymer[index], () => 1);
    }
    return characterMap.keys;
}

int _findNumberOfUnReactingPolymerUnits(String polymer) {
    var isPolymerReacting;
    do {
        isPolymerReacting = false;
        for (int startIndex = 0; startIndex < polymer.length - 1; startIndex++) {
            if (_isUnitReacting(polymer[startIndex], polymer[startIndex + 1])) {
                isPolymerReacting = true;
                var endIndex = (startIndex == polymer.length - 2) ? null : startIndex + 2;
                polymer = polymer.replaceRange(startIndex, endIndex, "");
                startIndex--;
            }
        }
    } while(isPolymerReacting);
    return polymer.length;
}

bool _isUnitReacting(String firstPolymerUnit, String secondPolymerUnit) {
    return (firstPolymerUnit.codeUnitAt(0) - secondPolymerUnit.codeUnitAt(0)).abs() == 32;
}

Future<String> _readPolymer() async {
    var polymer = "";
    var lines = new File("input/input.txt")
        .openRead()
        .transform(utf8.decoder)
        .transform(const LineSplitter());
    try {
        await for (var line in lines) {
            polymer += line;
        }
    } catch (e) {
        print("Can't read file $e");
    }
    return polymer;
}
