import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:google_place/google_place.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as lo;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:math' show cos, sqrt, asin;

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> with TickerProviderStateMixin {
  double totalDistancia = 0;
  bool showDetails = false;
  bool servicioPedido = true;
  TextEditingController controller = TextEditingController();
// Object for PolylinePoints
  PolylinePoints polylinePoints;

// List of coordinates to join
  List<LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting
// two points
  Animation<double> animation;
  AnimationController animationController;

  LatLng destination;
  LatLng startCoordinates;
  Set<Polyline> polylines = Set();
  Geolocator geolocator = Geolocator();
  LatLng _northeastCoordinates;
  LatLng _southwestCoordinates;
  LatLng _initialcameraposition = LatLng(4.6097100, -74.0817500);
  GoogleMapController _controller;
  lo.Location _location = lo.Location();
  TextEditingController _controllerText = TextEditingController();
  Set<Marker> _markers = Set();
  bool showCurrentPosition = true;
  GooglePlace googlePlace =
      GooglePlace("AIzaSyDDjt2cJQi5BgxkYJZ7ZtrPTafZQICenXo");
  List<AutocompletePrediction> predictions = [];
  double height = 0;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = Tween<double>(begin: 0, end: -300).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  double width = 0;
  @override
  Widget build(BuildContext context) {
    var animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(207, 197, 239, 1),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            child: Stack(
              children: [
                Center(
                    child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff7c94b6),
                      borderRadius: BorderRadius.all(Radius.circular(90))),
                  height: height - 50,
                  width: width,
                  child: GoogleMap(
                    // ignore: non_constant_identifier_names
                    onTap: (LatLng) {
                      setState(() {
                        showDetails = false;
                      });
                    },
                    myLocationButtonEnabled: false,
                    buildingsEnabled: false,
                    zoomControlsEnabled: false,
                    polylines: polylines,
                    markers: _markers,
                    initialCameraPosition: CameraPosition(
                        target: _initialcameraposition, zoom: 15),
                    mapType: MapType.normal,
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                  ),
                )),
                !showDetails
                    ? Center(
                        child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showDetails = true;
                          });

                          animationController.forward();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: height / 6),
                          height: height / 10,
                          width: width / 1.3,
                          color: Colors.white,
                          child: Center(
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                hoverColor: Colors.white,
                                labelText: "A donde quieres ir?",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(101, 79, 168, 1),
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black54,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                // if (value.isNotEmpty) {
                                //   autoCompleteSearch(value);
                                // } else {
                                //   if (predictions.length > 0 && mounted) {
                                //     setState(() {
                                //       predictions = [];
                                //     });
                                //   }
                                // }
                              },
                            ),
                          ),
                        ),
                      ))
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: height / 1.3),
                    child: BouncingWidget(
                        duration: Duration(milliseconds: 100),
                        scaleFactor: 1.5,
                        onPressed: () {
                          polylineCoordinates.clear();
                          _createPolylines();
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          color: Color.fromRGBO(101, 79, 168, 1),
                          child: Container(
                            width: width / 1.5,
                            height: height / 20,
                            child: Text(
                              "Pedir servicio",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ),
                        )),
                  ),
                ),
                showDetails
                    ? Center(
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromRGBO(101, 79, 168, 1),
                            ),
                            margin: EdgeInsets.only(top: height / 3),
                            height: height / 1.5,
                            width: width / 1.2,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Center(
                                      child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                    ),
                                    margin: EdgeInsets.only(top: height / 20),
                                    height: height / 20,
                                    width: width / 1.3,
                                    child: Center(
                                      child: TextField(
                                        controller: _controllerText,
                                        decoration: InputDecoration(
                                          focusColor: Colors.white,
                                          fillColor: Colors.white,
                                          hoverColor: Colors.white,
                                          labelText: "A donde quieres ir?",
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  101, 79, 168, 1),
                                              width: 1,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  101, 79, 168, 1),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            autoCompleteSearch(value);
                                          } else {
                                            if (predictions.length > 0 &&
                                                mounted) {
                                              setState(() {
                                                predictions = [];
                                              });
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  )),
                                  Container(
                                    height: height / 2,
                                    padding: EdgeInsets.only(
                                        left: 50, right: 50, bottom: 50),
                                    child: predictions.isNotEmpty
                                        ? Container(
                                            color: Colors.white,
                                            child: ListView.builder(
                                              itemCount: predictions.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  leading: CircleAvatar(
                                                    child: Icon(
                                                      Icons.pin_drop,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  title: Text(predictions[index]
                                                      .description),
                                                  onTap: () {
                                                    debugPrint(
                                                        predictions[index].id);
                                                    obtainLatLand(
                                                        predictions[index]
                                                            .placeId,
                                                        predictions[index]
                                                            .distanceMeters);
                                                    setState(() {
                                                      _controllerText.text =
                                                          predictions[index]
                                                              .description;
                                                    });
                                                    predictions.clear();
                                                    polylineCoordinates.clear();
                                                  },
                                                );
                                              },
                                            ))
                                        : Container(
                                          child: Scaffold(
                                            body: Container(
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Text('Viajes')
                                                  ],
                                                ),
                                              ),
                                            ),),
                                        ),
                                  ),
                                ],
                              ),
                            )))
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions;
      });
    }
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) async {
      if (showCurrentPosition) {
        startCoordinates = LatLng(l.latitude, l.longitude);
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
          ),
        );
      }
    });
  }

  _createPolylines() async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDDjt2cJQi5BgxkYJZ7ZtrPTafZQICenXo', // Google Maps API Key
      PointLatLng(startCoordinates.latitude, startCoordinates.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
      optimizeWaypoints: true,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Color.fromRGBO(101, 79, 168, 1),
      points: polylineCoordinates,
      width: 3,
    );
    double totalDistance = 0;
    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude);
    }
    totalDistancia = totalDistance / 10;
    print(totalDistance);
    // Adding the polyline to the map
    polylines.clear();
    setState(() {
      polylines.add(polyline);
    });
  }

  void obtainLatLand(String id, int distanceMeters) {
    googlePlace.details.get(id).then((value) async {
      if (value != null) {
        setState(() {
          _markers.clear();
          _markers.add(new Marker(
              markerId: MarkerId(id),
              position: LatLng(value.result.geometry.location.lat,
                  value.result.geometry.location.lng)));
        });
        destination = LatLng(value.result.geometry.location.lat,
            value.result.geometry.location.lng);

        if (startCoordinates.latitude <= value.result.geometry.location.lat) {
          _southwestCoordinates = startCoordinates;
          _northeastCoordinates = LatLng(value.result.geometry.location.lat,
              value.result.geometry.location.lng);
        } else {
          _southwestCoordinates = LatLng(value.result.geometry.location.lat,
              value.result.geometry.location.lng);
          _northeastCoordinates = startCoordinates;
        }

        _controller.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              northeast: LatLng(
                _northeastCoordinates.latitude,
                _northeastCoordinates.longitude,
              ),
              southwest: LatLng(
                _southwestCoordinates.latitude,
                _southwestCoordinates.longitude,
              ),
            ),
            100.0, // padding
          ),
        );

        showCurrentPosition = false;
      }
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
