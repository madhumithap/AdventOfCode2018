import 'dart:collection';
import 'dart:math';

class Coordinate {
  int id;
  int x;
  int y;
  int closestCoordinateId;
  bool isInSafeRegion = false;

  Coordinate(this.x, this.y);

  void updateClosestCoordinateIdAndSafeRegion(List<Coordinate> coordinates) {
    var distanceMap = new HashMap<int, int>();
    for (int index = 0; index < coordinates.length; index++) {
      var distance = distanceFrom(coordinates[index]);
      distanceMap.putIfAbsent(coordinates[index].id, () => distance);
    }
    var closestDistance = distanceMap.values.reduce(min);
    var closestCoordinates = new List<int>();
    distanceMap.forEach((key, value) {
      if (value == closestDistance) closestCoordinates.add(key);
    });
    closestCoordinateId = closestCoordinates.length == 1 ? closestCoordinates[0] : null;
    isInSafeRegion = distanceMap.values.reduce((a, b) => a + b) < 10000;
  }

  int distanceFrom(Coordinate coordinate) => (coordinate.y - this.y).abs() + (coordinate.x - this.x).abs();
}