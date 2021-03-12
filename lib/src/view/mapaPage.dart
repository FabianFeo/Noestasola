import 'dart:async';

import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as lo;
import 'package:geolocator/geolocator.dart';
import 'package:address_search_field/address_search_field.dart' as rh;

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  TextEditingController controller = TextEditingController();
  rh.Coords initialCoords;
  rh.Address initialAddress;
  final geoMethods = rh.GeoMethods(
    googleApiKey: 'AIzaSyD-tjxxULyiGLmic4k0I-djlKzcwKbDisQ',
    language: 'es',
    countryCode: 'co',
    country: 'Colombia',
    city: 'Bogotá',
  );

  Geolocator geolocator = Geolocator();
  LatLng _initialcameraposition = LatLng(4.6097100, -74.0817500);
  GoogleMapController _controller;
  lo.Location _location = lo.Location();
  Set<Marker> _markers = Set();
  bool showCurrentPosition = true;
  double height = 0;
  double width = 0;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(229, 255, 255, 1),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: height / 8),
            child: Column(
              children: [
                rh.AddressLocator(
                  geoMethods: geoMethods,
                  controller: controller,
                  locator: (relocate) async => controller.text.isEmpty
                      ? initialAddress.copyWith(await relocate(initialCoords))
                      : null,
                  child: TextField(
                    onTap: () => rh.AddressSearchBuilder.deft(
                      geoMethods: geoMethods,
                      controller: controller,
                      builder: rh.AddressDialogBuilder(),
                      onDone: (rh.Address address) {
                        print(address);
                      },
                    ),
                  ),
                ),
                Center(
                    child: Container(
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
                ))
              ],
            ),
          ),
        ),
      ),
    );
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
}
