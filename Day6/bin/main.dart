import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'dart:collection';

import 'coordinate.dart';

main(List<String> arguments) async {
  var coordinates = await _readCoordinates();
  coordinates = _assignIds(coordinates);
  List<List<Coordinate>> grid = _plotGrid(coordinates);
  var unInfiniteLargestArea = _findLargestFiniteArea(coordinates, grid);
  print("finite largest area is $unInfiniteLargestArea");
  var safeArea = _findSafeArea(grid);
  print("safe area is $safeArea");
}

int _findSafeArea(List<List<Coordinate>> grid) {
  int safeArea = 0;
  for (List<Coordinate> coordinatesList in grid) {
    for (Coordinate coordinate in coordinatesList) {
      if (coordinate.isInSafeRegion) safeArea++;
    }
  }
  return safeArea;
}

int _findLargestFiniteArea(List<Coordinate> coordinates, List<List<Coordinate>> grid) {
  HashMap<int, int> areaMap = _findArea(grid);
  var infiniteAreaMap = _findInfiniteAreaCoordinateIds(coordinates, grid);
  var finiteAreaCoordinates = areaMap.keys.where((coordinateId) => !infiniteAreaMap.containsKey(coordinateId)).toList();
  var maxArea = 0;
  for(int index = 0; index < finiteAreaCoordinates.length; index++) {
    if (areaMap[finiteAreaCoordinates[index]] > maxArea) maxArea = areaMap[finiteAreaCoordinates[index]];
  }
  return maxArea;
}

HashMap<int, int>_findInfiniteAreaCoordinateIds(List<Coordinate> coordinates, List<List<Coordinate>> grid) {
  var infiniteAreaMap = HashMap<int, int>();
  for (List<Coordinate> coordinatesList in grid) {
    infiniteAreaMap.putIfAbsent(coordinatesList[0].closestCoordinateId, () => 1);
    infiniteAreaMap.putIfAbsent(coordinatesList[coordinatesList.length - 1].closestCoordinateId, () => 1);
  }
  for (Coordinate coordinate in grid[0]) {
    infiniteAreaMap.putIfAbsent(coordinate.closestCoordinateId, () => 1);
  }
  for (Coordinate coordinate in grid[grid.length - 1]) {
    infiniteAreaMap.putIfAbsent(coordinate.closestCoordinateId, () => 1);
  }
  return infiniteAreaMap;
}

HashMap<int, int> _findArea(List<List<Coordinate>> grid) {
  var areaMap = HashMap<int, int>();
  for (List<Coordinate> coordinatesList in grid) {
    for (Coordinate coordinate in coordinatesList) {
      var closestCoordinateId = coordinate.closestCoordinateId;
      if (closestCoordinateId != null) {
        areaMap.update(closestCoordinateId, (currentValue) => currentValue + 1, ifAbsent: () => 1);
      }
    }
  }
  return areaMap;
}

List<List<Coordinate>> _plotGrid(List<Coordinate> coordinates) {
  List<List<Coordinate>> grid = _computeGrid(coordinates);
  for (List<Coordinate> coordinatesList in grid) {
    for (Coordinate coordinate in coordinatesList) {
      coordinate.updateClosestCoordinateIdAndSafeRegion(coordinates);
    }
  }
  return grid;
}

List<List<Coordinate>> _computeGrid(List<Coordinate> coordinates) {
  var minX = coordinates.map((coordinate) => coordinate.x).reduce(min);
  var minY = coordinates.map((coordinate) => coordinate.y).reduce(min);
  var maxX = coordinates.map((coordinate) => coordinate.x).reduce(max);
  var maxY = coordinates.map((coordinate) => coordinate.y).reduce(max);
  var xSize = maxX - minX + 1;
  var ySize = maxY - minY + 1;
  List<List<Coordinate>> grid = List.generate(xSize, (_) { return List(ySize); });
  var x = minX;
  var y = minY;
  for (int i = 0; i < xSize; i++) {
    for (int j = 0; j < ySize; j++) {
      grid[i][j] = Coordinate(x, y);
      y++;
    }
    y = minY;
    x++;
  }
  return grid;
}

List<Coordinate> _assignIds(List<Coordinate> coordinates) {
  for (var i = 0; i < coordinates.length; i++) {
    coordinates[i].id = i;
  }
  return coordinates;
}

Future<List<Coordinate>> _readCoordinates() async {
  var coordinates = List<Coordinate>();
  var lines = File("input/input.txt")
      .openRead()
      .transform(utf8.decoder)
      .transform(const LineSplitter());
  try {
    await for (var line in lines) {
      var split = line.split(", ");
      coordinates.add(Coordinate(int.parse(split[0]), int.parse(split[1])));
    }
  } catch (e) {
    print("Can't read file $e");
  }
  return coordinates;
}
