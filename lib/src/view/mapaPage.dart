import 'package:NoEstasSola/src/service/contactosService.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_place/google_place.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as lo;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:geocoder/geocoder.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> with TickerProviderStateMixin {
  String dropDownValue;
  double totalDistancia = 0;
  bool showDetails = false;
  bool servicePedido = true;
  bool confirmationCard = false;
  bool dondeestas = true;
  String idDestination;
  String idStart;
  TextEditingController controller = TextEditingController();
  PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
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
  TextEditingController _controllerText2 = TextEditingController();
  Set<Marker> _markers = Set();
  bool showCurrentPosition = true;
  GooglePlace googlePlace =
      GooglePlace("AIzaSyDDjt2cJQi5BgxkYJZ7ZtrPTafZQICenXo");
  List<AutocompletePrediction> predictions = [];
  double height = 0;
  double width = 0;
  ContactosService _contactosService = ContactosService();
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(207, 197, 239, 1),
        body: Container(
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
                  initialCameraPosition:
                      CameraPosition(target: _initialcameraposition, zoom: 15),
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                ),
              )),
              SizedBox(
                height: 10,
              ),
              servicePedido
                  ? Center(
                      child: Container(
                        margin: EdgeInsets.only(top: height / 1.3),
                        child: BouncingWidget(
                            duration: Duration(milliseconds: 100),
                            scaleFactor: 1.5,
                            onPressed: () {
                              setState(() {
                                showDetails = true;
                              });
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
                  : Container(),
              showDetails
                  ? Center(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromRGBO(207, 197, 239, 1),
                          ),
                          height: height,
                          width: width,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                    ),
                                    margin: EdgeInsets.only(top: height / 8.5),
                                    height: height / 20,
                                    width: width / 1.3,
                                    child: Center(
                                      child: TextField(
                                        controller: _controllerText2,
                                        decoration: InputDecoration(
                                          labelText: "Donde estás?",
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
                                          setState(() {
                                            dondeestas = true;
                                          });
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
                                  ),
                                ),
                                Center(
                                    child: Container(
                                  margin: EdgeInsets.only(top: height / 50),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  height: height / 20,
                                  width: width / 1.3,
                                  child: Center(
                                    child: TextField(
                                      controller: _controllerText,
                                      decoration: InputDecoration(
                                        labelText: "A donde quieres ir?",
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(101, 79, 168, 1),
                                            width: 1,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(101, 79, 168, 1),
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          dondeestas = false;
                                        });
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
                                        left: 18, right: 18, bottom: 50),
                                    child: Container(
                                        color: Color.fromRGBO(207, 197, 239, 1),
                                        child: ListView.builder(
                                          itemCount: predictions.length,
                                          itemBuilder: (context, index) {
                                            return index == 0 && dondeestas
                                                ? ListTile(
                                                    leading: CircleAvatar(
                                                      child: Icon(
                                                        Icons.location_on,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    title: Text(
                                                        'tu ubicacion actual'),
                                                    onTap: () {
                                                      setState(() {
                                                        showCurrentPosition =
                                                            false;
                                                        _controllerText2.text =
                                                            predictions[index]
                                                                .description;
                                                      });
                                                      idStart =
                                                          predictions[index]
                                                              .placeId;
                                                      obtainLatLand();

                                                      polylineCoordinates
                                                          .clear();
                                                    },
                                                  )
                                                : ListTile(
                                                    leading: CircleAvatar(
                                                      child: Icon(
                                                        Icons.pin_drop,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    title: Text(
                                                        predictions[index]
                                                            .description),
                                                    onTap: () {
                                                      setState(() {
                                                        if (dondeestas) {
                                                          showCurrentPosition =
                                                              false;
                                                          _controllerText2
                                                                  .text =
                                                              predictions[index]
                                                                  .description;
                                                          idStart =
                                                              predictions[index]
                                                                  .placeId;
                                                        } else {
                                                          _controllerText.text =
                                                              predictions[index]
                                                                  .description;
                                                          idDestination =
                                                              predictions[index]
                                                                  .placeId;
                                                        }
                                                      });
                                                      obtainLatLand();

                                                      polylineCoordinates
                                                          .clear();
                                                    },
                                                  );
                                          },
                                        ))),
                                Container(
                                  child: Container(
                                    child: Center(
                                      child: StreamBuilder(
                                          stream: _contactosService
                                              .getEmergenciContactsStream(),
                                          builder: (_,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            return snapshot.hasData &&
                                                    snapshot.data.docs.length !=
                                                        0
                                                ? new DropdownButton<String>(
                                                    value: dropDownValue,
                                                    hint: Text(
                                                        'Selecciona un contacto de emergencia'),
                                                    items: snapshot.data.docs
                                                        .map((value) {
                                                      return new DropdownMenuItem<
                                                          String>(
                                                        value: value
                                                            .data()['nombre'],
                                                        child: new Text(value
                                                            .data()['nombre']),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        dropDownValue = value;
                                                      });
                                                    },
                                                  )
                                                : Container(
                                                    child: Text(
                                                        'No tienes ningun contacto de confianza agregado'),
                                                  );
                                          }),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Container(
                                    margin: EdgeInsets.only(top: height / 10),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            child: BouncingWidget(
                                                duration:
                                                    Duration(milliseconds: 100),
                                                scaleFactor: 1.5,
                                                onPressed: () {
                                                  setState(() {
                                                    showDetails = false;
                                                  });
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                  ),
                                                  color: Color.fromRGBO(
                                                      101, 79, 168, 1),
                                                  child: Container(
                                                    width: width / 2.7,
                                                    height: height / 20,
                                                    child: Center(
                                                      child: Text(
                                                        "Cancelar",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                          Container(
                                            child: BouncingWidget(
                                                duration:
                                                    Duration(milliseconds: 100),
                                                scaleFactor: 1.5,
                                                onPressed: () {
                                                  setState(() {
                                                    servicePedido = false;
                                                    showDetails = false;
                                                  });
                                                  polylineCoordinates.clear();
                                                  _createPolylines();
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                  ),
                                                  color: Color.fromRGBO(
                                                      101, 79, 168, 1),
                                                  child: Container(
                                                    width: width / 2.7,
                                                    height: height / 20,
                                                    child: Center(
                                                      child: Text(
                                                        "Confirmar",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )))
                  : Container(),
              confirmationCard ? Container() : Container()
            ],
          ),
        ),
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      predictions = List();
      if (dondeestas) {
        var addresses = await Geocoder.local.findAddressesFromCoordinates(
            Coordinates(startCoordinates.latitude, startCoordinates.longitude));
        var result2 =
            await googlePlace.autocomplete.get(addresses[0].addressLine);
        predictions.add(result2.predictions[0]);
      }
      setState(() {
        predictions.addAll(result.predictions);
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

  Future<void> obtainLatLand() async {
    _markers.clear();
    await googlePlace.details.get(idDestination).then((value) async {
      if (value != null) {
        setState(() {
          _markers.add(new Marker(
              markerId: MarkerId(idDestination),
              position: LatLng(value.result.geometry.location.lat,
                  value.result.geometry.location.lng)));
        });
        await googlePlace.details.get(idStart).then((value2) async {
          if (value2 != null) {
            setState(() {
              _markers.add(new Marker(
                  markerId: MarkerId(idStart),
                  position: LatLng(value2.result.geometry.location.lat,
                      value2.result.geometry.location.lng)));
            });
          }
          startCoordinates = LatLng(value2.result.geometry.location.lat,
              value2.result.geometry.location.lng);
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
