class Viaje {
  static final Viaje _viaje = Viaje._internal();
  String idCliente;
  String idDriver;
  String valor;
  String metodoPago;
  String direccionInicio;
  String direccionDestino;
  String date;
  String uiid;
  double latInicio;
  double lanInicio;
  double latDestino;
  double lanDestino;
  Viaje._internal();
  factory Viaje() {
    return _viaje;
  }

  Map<String, dynamic> toMap() {
    return {
      'idCliente': idCliente,
      'idDriver': idDriver,
      'valor': valor,
      'metodoPago': metodoPago,
      'direccionInicio': direccionInicio,
      'direccionDestino': direccionDestino,
      'date': date,
      'uiid': uiid,
      'latInicio': latInicio,
      'lanInicio': lanInicio,
      'latDestino': latDestino,
      'lanDestino': lanDestino
    };
  }

  fromMap(Map<String, dynamic> data) {
    idCliente = data['idCliente'];
    idDriver = data['idDriver'];
    valor = data['valor'];
    metodoPago = data['metodoPago'];
    direccionInicio = data['direccionInicio'];
    direccionDestino = data['direccionDestino'];
    date = data['date'];
    uiid = data['uiid'];
    latInicio = data['latInicio'];
    lanInicio = data['lanInicio'];
    latDestino = data['latDestino'];
    lanDestino = data['lanDestino'];
  }

  toNull() {
    idCliente = null;
    idDriver = null;
    valor = null;
    metodoPago = null;
    direccionInicio = null;
    direccionDestino = null;
    date = null;
    uiid = null;
    latInicio = null;
    lanInicio = null;
    latDestino = null;
    lanDestino = null;
  }
}
