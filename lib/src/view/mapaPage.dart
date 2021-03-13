import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:google_place/google_place.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as lo;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  bool servicioPedido=true;
  TextEditingController controller = TextEditingController();
// Object for PolylinePoints
  PolylinePoints polylinePoints;

// List of coordinates to join
  List<LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting
// two points
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

  double width = 0;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(207, 197, 239, 1),
        body: SingleChildScrollView(
          child: Container(
           
            child: Stack(
              children: [
                Center(
                    child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff7c94b6),
                      borderRadius: BorderRadius.all(Radius.circular(90))),
                  
                  height: height-50,
                  width: width ,
                  child: GoogleMap(
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
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: height / 10),
                    height: height/10,
                    width: width / 1.3,
                    color: Colors.white,
                    child: Center(
                      child: TextField(
                        controller: _controllerText,
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
                          if (value.isNotEmpty) {
                            autoCompleteSearch(value);
                          } else {
                            if (predictions.length > 0 && mounted) {
                              setState(() {
                                predictions = [];
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: height / 2,
                  padding: EdgeInsets.only(left: 50,right: 50,bottom: 50),
                  margin: EdgeInsets.only(top: (height / 10)+(height/10)),
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
                                title: Text(predictions[index].description),
                                onTap: () {
                                  debugPrint(predictions[index].id);
                                  obtainLatLand(predictions[index].placeId,
                                      predictions[index].distanceMeters);
                                  setState(() {
                                    _controllerText.text =
                                        predictions[index].description;
                                  });
                                  predictions.clear();
                                },
                              );
                            },
                          ))
                      : Container(),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: height / 1.3),
                    child: BouncingWidget(
                        duration: Duration(milliseconds: 100),
                        scaleFactor: 1.5,
                        onPressed: () {
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
                )
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

    // Adding the polyline to the map
    setState(() {
      polylines.clear();
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
}
