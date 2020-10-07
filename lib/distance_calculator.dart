import 'dart:math';

import 'spherical_law_of_cosine.dart';

class DistanceCalculator {

  // The "DistanceCalculator" utilises the "spherical_law_of_cosine" in order to
  // calculate the distance in metres between two latitude-longitude coordinates

  double latitude1;
  double longitude1;

  double latitude2;
  double longitude2;


  DistanceCalculator(
      {this.latitude1, this.longitude1, this.latitude2, this.longitude2}) {
    this.latitude1 = _radiansFromDegrees(latitude1);
    this.longitude1 = _radiansFromDegrees(longitude1);
    this.latitude2 = _radiansFromDegrees(latitude2);
    this.longitude2 = _radiansFromDegrees(longitude2);

  }

  double sphericalLawOfCosinesDistance() {
    return SphericalLawOfCosines.distance(
        this.latitude1, this.longitude1, this.latitude2, this.longitude2);
  }


  double _radiansFromDegrees(final double degrees) {
    return degrees * (pi / 180.0);
  }

}
