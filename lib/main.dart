import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Santa Tracker',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Santa Tracker'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Stack(children: <Widget>[
          SantaMapWidget(),
          Align(
            child: Padding(
              child: Material(
                child: SizedBox(
                    height: 48.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Somewhere, OH",
                          style: Theme.of(context).textTheme.body2),
                    )),
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.horizontal(
                        start: Radius.circular(24.0),
                        end: Radius.circular(24.0))),
              ),
              padding: EdgeInsets.only(bottom: 16.0),
            ),
            alignment: Alignment.bottomCenter,
          )
        ]));
  }
}

class SantaMapWidget extends StatefulWidget {
  @override
  _SantaMapWidgetState createState() => _SantaMapWidgetState();
}

class _SantaMapWidgetState extends State<SantaMapWidget> {
  GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(onMapCreated: _onMapCreated);
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;

      // Map shouldn't be the one deciding on location...hmm...
      _pinLocation(Location(39.3332326, -84.3145426, 19, 'Mason, OH'));
    });
  }

  void _pinLocation(Location location) {
    var latLng = LatLng(location.lat, location.lng);

    _controller?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: latLng,
        tilt: 35.0,
        zoom: location.zoom,
      ),
    ));

    _controller.clearMarkers();
    _controller.addMarker(MarkerOptions(position: latLng));
  }
}

class Location {
  final double lat;
  final double lng;
  final double zoom;
  final String city;

  Location(this.lat, this.lng, this.zoom, this.city);
}
