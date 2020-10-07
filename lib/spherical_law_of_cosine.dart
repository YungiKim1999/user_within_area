import 'dart:math';

class SphericalLawOfCosines {

  // The "SphericalLawOfCosines" is a formula in order to calculate the distance between
  // two latitude and longitude points
  // This code simply represents that in dart format
  static double distance(double latitude1, longitude1, latitude2, longitude2) {
    double distance = acos(
        sin(latitude1) * sin(latitude2) +
            cos(latitude1) * cos(latitude2) *
                cos(longitude2 - longitude1)
    );
    if (distance < 0) distance = distance + pi;

    var earthRadius = 6378137.0;
    return earthRadius * distance;
  }
}