import 'package:areawithinusercount/distance_calculator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // List containing the latitudes and longitudes of markers
  List<LatLng> allLatLng = [];

  // List containing all the map markers
  List<Marker> allMarkers = [];

  // List containing one circle representing the user boundary
  List<Circle> allCircles = [];

  // Centre of the cirlle
  LatLng centre = LatLng(-36.846000, 174.766950);

  // radius of the circle
  double _radius = 450;

  GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    allLatLng.add(LatLng(-36.845440, 174.767242));
    allLatLng.add(LatLng(-36.898102, 174.922745));
    allLatLng.add(LatLng(-36.846588, 174.766525));
    allLatLng.add(LatLng(-36.848309, 174.767776));

    for (LatLng coordinate in allLatLng) {
      allMarkers.add(Marker(
        markerId: MarkerId(coordinate.latitude.toString()),
        position: coordinate,
      ));
    }

  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    allCircles = [];
    allCircles.add(Circle(
      circleId: CircleId('Centre'),
      radius: _radius,
      center: LatLng(-36.845790, 174.766950),
      fillColor: Colors.blue[100],
      strokeWidth: 0,
    ));
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              int count = 0;
              for (LatLng coordinate in allLatLng) {
                DistanceCalculator calculator = DistanceCalculator(
                    latitude1: -36.845790,
                    longitude1: 174.766950,
                    latitude2: coordinate.latitude,
                    longitude2: coordinate.longitude);
                if (calculator.sphericalLawOfCosinesDistance() < _radius) {
                  count++;
                }
              }
             showAlertDialog(context, count);
            },
            icon: Icon(Icons.alarm_on),
            label: Text('Check'),
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(-36.8485, 174.7633),
                  zoom: 16,
                ),
                markers: Set.from(allMarkers),
                circles: Set.from(allCircles),
              ),
              Positioned(
                bottom: 50,
                width: 400,
                child: Slider(
                  value: _radius,
                  min: 0,
                  max: 450,
                  divisions: 20,
                  label: _radius.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _radius = value;
                    });
                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context, int count) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Number of Markers in Circle"),
      content: Text("Number of markers in circle: " + count.toString()),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

