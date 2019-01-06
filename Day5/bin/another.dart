import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:core';
import 'dart:math';

main(List<String> arguments) async {
    var polymer = await readPolymer();
    var unReactingPolymerUnits = findNumberOfUnReactingPolymerUnits(polymer);
    print("number of unreacting polymer units is $unReactingPolymerUnits");
//    var shortestUnReactingPolymerUnits = findShortestUnReactingPolymerUnits(polymer);
//    print("shortest unreacting polymer units is $shortestUnReactingPolymerUnits");
}

int findShortestUnReactingPolymerUnits(String polymer) {
    Stopwatch stopwatch = new Stopwatch()..start();
    var unReactingPolymerUnits = new List<int>();
    var characters = uniqueCharacters(polymer);
    characters.forEach((String characterString) {
        var reducedPolymer = polymer
            .replaceAll(characterString.toLowerCase(), "")
            .replaceAll(characterString.toUpperCase(), "");
        unReactingPolymerUnits.add(findNumberOfUnReactingPolymerUnits(reducedPolymer));
    });
    print('doSomething() executed in ${stopwatch.elapsed.inMilliseconds}');
    return unReactingPolymerUnits.reduce(min);
}

Iterable<String> uniqueCharacters(String polymer) {
    var lowerCasedPolymer = polymer.toLowerCase();
    var characterMap = new HashMap<String, int>();
    for (int index = 0; index < lowerCasedPolymer.length; index++) {
        characterMap.putIfAbsent(polymer[index], () => 1);
    }
    return characterMap.keys;
}

int findNumberOfUnReactingPolymerUnits(String polymer) {
    Stopwatch stopwatch = new Stopwatch()..start();
    var isPolymerReacting;
    var iterationString = polymer;
    var newString = "";
    do {
        isPolymerReacting = false;
        for (int startIndex = 0; startIndex < iterationString.length - 1; startIndex++) {
            if (isUnitReacting(iterationString[startIndex], iterationString[startIndex + 1])) {
                isPolymerReacting = true;
                startIndex++;
            } else {
                newString += iterationString[startIndex];
            }
        }
        iterationString = newString;
        newString = "";
    } while(isPolymerReacting);
    print('doSomething() executed in ${stopwatch.elapsed.inMilliseconds}');
    return iterationString.length;
}

bool isUnitReacting(String firstPolymerUnit, String secondPolymerUnit) {
    return (firstPolymerUnit.codeUnitAt(0) - secondPolymerUnit.codeUnitAt(0)).abs() == 32;
}

Future<String> readPolymer() async {
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
