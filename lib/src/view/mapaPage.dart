import 'package:NoEstasSola/src/model/viaje.model.dart';
import 'package:NoEstasSola/src/service/contactosService.dart';
import 'package:NoEstasSola/src/service/viajeServicecollection.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_place/google_place.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
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
  String _myActivity;
  String dropDownValue;
  BitmapDescriptor myIcon;
  Viaje _viaje = Viaje();
  ViajesServiceCollection _viajesServiceCollection = ViajesServiceCollection();
  double totalDistancia = 0;
  bool showDetails = false;
  bool servicePedido = true;
  bool confirmationCard = false;
  bool dondeestas = true;
  bool showFinalcard = false;
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
  Viaje viaje = Viaje();
  GooglePlace googlePlace =
      GooglePlace("AIzaSyDDjt2cJQi5BgxkYJZ7ZtrPTafZQICenXo");
  List<AutocompletePrediction> predictions = [];
  double height = 0;
  double width = 0;
  String dropdownValue;
  ContactosService _contactosService = ContactosService();
  @override
  void initState() { 
    super.initState();
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(5, 5)), 'assets/IconosMarker/Marker_1.png')
        .then((onValue) {
      myIcon = onValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                  myLocationButtonEnabled: true,
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
                                    ),
                                    margin: EdgeInsets.only(top: height / 8.5),
                                    height: height / 10,
                                    width: width / 1.3,
                                    child: Center(
                                      child: TextField(
                                        maxLines: 1,
                                        controller: _controllerText2,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: "¿Donde estás?",
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
                                  ),
                                  height: height / 10,
                                  width: width / 1.3,
                                  child: Center(
                                    child: TextField(
                                      maxLines: 1,
                                      controller: _controllerText,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        labelText: "¿A donde quieres ir?",
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
                                                        viaje.direccionInicio =
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
                                                          viaje.direccionInicio =
                                                              predictions[index]
                                                                  .description;
                                                        } else {
                                                          _controllerText.text =
                                                              predictions[index]
                                                                  .description;
                                                          viaje.direccionDestino =
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
                                                  viaje.toNull();
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
                                                    confirmationCard = true;
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
              confirmationCard
                  ? Container(
                      margin: EdgeInsets.only(top: height / 1.6),
                      child: Center(
                        child: Container(
                            height: height / 3.8,
                            width: width / 1.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              color: Color.fromRGBO(207, 197, 239, 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: height / 35),
                                      child: Image(
                                        height: height / 10,
                                        image: AssetImage(
                                            'assets/Logo/Lu_logo.png'),
                                      ),
                                    ),
                                    Container(
                                      height: height / 30,
                                      width: width / 2.5,
                                      margin: EdgeInsets.only(top: height / 65),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          color:
                                              Color.fromRGBO(102, 51, 204, 1)),
                                      child: GestureDetector(
                                        onTap: () {
                                          viaje.valor =
                                              ((totalDistancia * 850) + 2500)
                                                  .toStringAsFixed(0);

                                          _viajesServiceCollection
                                              .pushviaje()
                                              .then((value) {
                                            setState(() {
                                              showFinalcard = true;
                                            });
                                          });
                                        },
                                        child: Text(
                                          'Confirmar',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: width / 20),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: height / 30,
                                      width: width / 2.5,
                                      margin: EdgeInsets.only(top: height / 65),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          color:
                                              Color.fromRGBO(102, 51, 204, 1)),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showDetails = false;
                                            confirmationCard = false;
                                            servicePedido = true;
                                            polylines.clear();
                                            _markers.clear();
                                            _controllerText.text = "";
                                            _controllerText2.text = "";
                                            predictions.clear();
                                          });
                                        },
                                        child: Text(
                                          'Cancelar',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: width / 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: height / 28),
                                      child: Text(
                                        'Valor:',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(102, 51, 204, 1),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        '${((totalDistancia * 850) + 2500).toStringAsFixed(0)} COP',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(102, 51, 204, 1),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: height / 28),
                                      child: Text(
                                        'Metodo de pago:',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(102, 51, 204, 1),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: DropdownButton<String>(
                                        value: dropdownValue,
                                        hint: Column(
                                          children: [
                                            Text('selecciona un '),
                                            Text('metodo de pago')
                                          ],
                                        ),
                                        icon: const Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          viaje.metodoPago = newValue;
                                          setState(() {
                                            dropdownValue = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Efectivo',
                                          'tarjeta de credito',
                                          'pse',
                                          'paypal'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    )
                  : Container(),
              showFinalcard
                  ? StreamBuilder(
                      stream: _viajesServiceCollection.getCambiosViaje(),
                      builder: (_, AsyncSnapshot<DocumentSnapshot> snapshotViaje) {
                        return Container(
                            margin: EdgeInsets.only(top: height / 2),
                            child: Center(
                              child: Container(
                                height: height / 2.3,
                                width: width / 1.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  color: Color.fromRGBO(207, 197, 239, 1),
                                ),
                                child: Container(
                                  child: SingleChildScrollView(
                                  child: snapshotViaje.hasData && snapshotViaje.data.exists?  Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: height / 155),
                                                    child: Row(
                                                      children: [
                                                        Image(
                                                          height: height / 10,
                                                          image: AssetImage(
                                                              'assets/Logo/Lu_logo.png'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [                                                      
                                                      Column(
                                                        children: [
                                                          Container(
                                                            height: height /22,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        width /
                                                                            3),
                                                            child: Text(
                                                              'Fecha: ',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        102,
                                                                        51,
                                                                        204,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: height /22,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        width /
                                                                            11),
                                                            child: Text(
                                                              'Direccion de recogida:',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        102,
                                                                        51,
                                                                        204,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: height /22,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        width /
                                                                            10),
                                                            child: Text(
                                                              'Direccion de Llegada:',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        102,
                                                                        51,
                                                                        204,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: height /22,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        width /
                                                                            6),
                                                            child: Text(
                                                              'Metodo de Pago:',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        102,
                                                                        51,
                                                                        204,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: height /22,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        width /
                                                                            3.8),
                                                            child: Text(
                                                              'Valor total:',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        102,
                                                                        51,
                                                                        204,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: height /22,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        width /
                                                                            3),
                                                            child: Text(
                                                              'Estado:',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        102,
                                                                        51,
                                                                        204,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Container(
                                                            height: height /22,
                                                             width: width /2.5,
                                                            child: Text(
                                                              snapshotViaje.data.data()['date'].split(
                                                                      'T')[0] +
                                                                  '',
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        102,
                                                                        51,
                                                                        204,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: height /22,
                                                            width: width /2.5,
                                                            child: Text(
                                                              snapshotViaje.data.data()['direccionInicio'] +
                                                                  '',
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        102,
                                                                        51,
                                                                        204,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: height /22,
                                                             width: width /2.5,
                                                            child: Text(
                                                              snapshotViaje.data.data()['direccionDestino'] +
                                                                  '',
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        102,
                                                                        51,
                                                                        204,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: height /22,
                                                             width: width /2.5,
                                                            child: Text(
                                                              snapshotViaje.data.data()['metodoPago'] +
                                                                  '',
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        102,
                                                                        51,
                                                                        204,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: height /22,
                                                             width: width /2.5,
                                                            child: Text(
                                                              snapshotViaje.data.data()['valor'] + '',
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        102,
                                                                        51,
                                                                        204,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          
                                                          Container(
                                                            height: height /22,
                                                             width: width /2.5,
                                                            child: Text(
                                                              snapshotViaje.data.data()['estado'] + '',
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        102,
                                                                        51,
                                                                        204,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: BouncingWidget(
                                            duration:
                                                Duration(milliseconds: 100),
                                            scaleFactor: 1.5,
                                            onPressed: () {},
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              color: Color.fromRGBO(
                                                  101, 79, 168, 1),
                                              child: Container(
                                                width: width / 2.8,
                                                height: height / 25,
                                                child: Text(
                                                  "Cancelar",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25),
                                                ),
                                              ),
                                            )),
                                      )
                                    ],
                                  ):CircularProgressIndicator(),
                                ),
                              ),
                            )));
                      },
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    value += "Colombia";
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      predictions = List();
      if (dondeestas) {
        if (startCoordinates == null) {
          await _location.getLocation().then((value) => {});
        }
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
    totalDistancia = totalDistance / 1000;
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
            icon: myIcon,
              markerId: MarkerId(idDestination),
              position: LatLng(value.result.geometry.location.lat,
                  value.result.geometry.location.lng)));
        });
        await googlePlace.details.get(idStart).then((value2) async {
          if (value2 != null) {
            
            setState(() {
              _markers.add(new Marker(
                icon: myIcon,
                  markerId: MarkerId(idStart),
                  position: LatLng(value2.result.geometry.location.lat,
                      value2.result.geometry.location.lng)));
            });
          }
          startCoordinates = LatLng(value2.result.geometry.location.lat,
              value2.result.geometry.location.lng);
          viaje.latInicio = startCoordinates.latitude;
          viaje.lanInicio = startCoordinates.longitude;
        });
        if (value != null) {
          destination = LatLng(value.result.geometry.location.lat,
              value.result.geometry.location.lng);
          viaje.latDestino = destination.latitude;
          viaje.lanDestino = destination.longitude;

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
        }

        showCurrentPosition = false;
      }
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }
}
