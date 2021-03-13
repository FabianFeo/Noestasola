import 'dart:async';

import 'package:NoEstasSola/src/model/User.model.dart';
import 'package:NoEstasSola/src/service/placeProviders.dart';
import 'package:NoEstasSola/src/widget/detailsPage.dart';
import 'package:google_place/google_place.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as lo;
import 'package:geolocator/geolocator.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  TextEditingController controller = TextEditingController();

  Geolocator geolocator = Geolocator();
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
            margin: EdgeInsets.only(top: height / 8),
            child: Stack(
              children: [
                Center(
                    child: Container(
                  margin: EdgeInsets.only(top: height / 5),
                  height: height / 2,
                  width: width / 1.2,
                  child: GoogleMap(
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
                  margin: EdgeInsets.only(top: height / 18),
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
    _location.onLocationChanged.listen((l) {
      if (showCurrentPosition) {
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
          ),
        );
      }
    });
  }

  void obtainLatLand(String id, int distanceMeters) {
    googlePlace.details.get(id).then((value) {
      if (value != null) {
        setState(() {
          _markers.clear();
          _markers.add(new Marker(
              markerId: MarkerId(id),
              position: LatLng(value.result.geometry.location.lat,
                  value.result.geometry.location.lng)));
        });

        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(value.result.geometry.location.lat,
                    value.result.geometry.location.lng),
                zoom: 16),
          ),
        );
        showCurrentPosition = false;
      }
    });
  }
}
