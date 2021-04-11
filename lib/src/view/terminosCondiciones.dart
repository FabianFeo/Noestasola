import 'package:NoEstasSola/src/service/contactosService.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';

class FormularioTerminosCondiciones extends StatefulWidget {
  FormularioTerminosCondiciones({Key key}) : super(key: key);

  @override
  _FormularioTerminosCondicionesState createState() =>
      _FormularioTerminosCondicionesState();
}

class _FormularioTerminosCondicionesState
    extends State<FormularioTerminosCondiciones> {
  bool rememberMe = false;
  bool showErrorMessage = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: Text("TERMINOS Y CONDICIONES"),
              backgroundColor: Color.fromRGBO(101, 79, 168, 1),
            ),
            body: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              title: Text('TERMINOS Y CONDICIONES LU'),
                              subtitle: Text(
                                  'AUTORIZACIÓN O TERMINOS Y CONDICIONES: '),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: new SingleChildScrollView(
                              scrollDirection: Axis.vertical, //.horizontal
                              child: Container(
                                  margin: EdgeInsets.only(
                                      right: width / 20, left: width / 20),
                                  child: new Text(
                                    "•	Autoriza expresamente a LU y a su eventual cesionario o subrogatario para consultar, solicitar, suministrar, reportar, procesar y divulgar toda la información que se refiere a mi comportamiento crediticio, financiero y comercial a las Centrales de Riesgo que administra la Asociación Bancaria y de Entidades Financieras de Colombia o a quien represente sus derechos incorporar, reportar, procesar y consultar en Bancos de Datos, la información que se relacione con este contrato o que de él se derive.\n  " +
                                        "•	En caso de que, en el futuro, el autorizado en este documento efectúe una venta de cartera o una cesión a cualquier título de las obligaciones a mi cargo a favor de un tercero, los efectos de la presente autorización se extenderán a esté, en los mismos términos y condiciones.\n" +
                                        "•	Acceso a la Información. La presente autorización se hace extensiva a quien represente los derechos de XXXXXXXXXXXX, a quien éste contrate para el ejercicio de los mismos o a quien éste ceda sus derechos, sus obligaciones o su posición contractual a cualquier título, en relación con la información del punto de servicio afiliado, así como a la ejecución de(los) contrato(s) que se hayan suscrito. Así mismo, a los terceros con quien XXXXXXXXXXXXXXXX establezca alianzas comerciales, o contratos de prestación de servicios a partir de las cuales se codifiquen, implementen o amplíen los productos o servicios que puedan proveerse desde el punto de servicio afiliado él envió información publicitaria a través de medios tecnológicos (correo electrónico, mails, WhatsApp, redes sociales, MSM, entre otros), con fines comerciales o publicitarios.\n" +
                                        "•	Vigencia de la Autorización. Esta autorización tendrá plena vigencia durante el tiempo de análisis de la información para la suscripción de cualquier contrato, durante la vigencia de relación contractual con XXXXXXXXXXXXXXX y en forma posterior hasta tanto sea revocada. La autorización podrá ser revocada en los eventos previstos en la ley, siempre y cuando no exista ningún tipo de relación con XXXXXXXXXXXXXXXX derivado de esta autorización.\n " +
                                        "•	Almacenamiento de la Información. Los datos suministrados serán almacenos en los servidores de XXXXXXXXXXXXXXXXXXX lugar donde están siendo custodiados mediante el empleo de herramientas de seguridad de la información, razonablemente aceptadas en la industria, tales como firewalls, procedimientos de control de acceso, entre otros. Todo lo anterior con el objetivo de evitar el acceso no autorizado, por parte de terceros, a los datos personales almacenados.\n " +
                                        "•	Derechos. Usted tiene derecho a conocer, actualizar, rectificar y eliminar los datos personales de los cuales es titular, mediante los procedimientos establecidos en la Ley 1581/2012 (Ley de Protección de Datos Personales). Para cualquier información, solicitud, queja o reclamo sobre el tratamiento de sus datos podrá comunicarse al correo electrónico XXXXXXXXXXXXXXXX.\n" +
                                        "•	De esta forma por medio del presente escrito en forma expresa y previamente informado manifiesto que otorgo mi consentimiento a XXXXXXXXXXXXXXXX para tratar mi información personal, de acuerdo con las disposiciones legales que regulan la materia, la política para tratamiento de datos personales, el manual interno de políticas y procedimientos para la protección de datos personales, el aviso de privacidad y el presente documento. Así mismo autorizo a XXXXXXXXXXXXXXXXXXXXXX. a modificar o actualizar su contenido, a fin de atender reformas legislativas, políticas internas o nuevos requerimientos que permitan la implementación de nuevos servicios o productos, en los establecimientos de comercio afiliados a la red LU, dando aviso previo por medio de la página web de la cooperativa, correo electrónico y/o portal administrativo.\n" +
                                        "•	Autorización Uso de Imagen: Atendiendo las disposiciones legales sobre la materia, la empresa XXXXXXXXXXXX, ubicada en el municipio de XXXXXXX con dirección XXXXXXXXXXXXXXXX, inscrita en la cámara de comercio el XX  de XXXXXX  de XXXXX, Identificada con  NIT No. XXXXXXXXXXX, solicita la autorización escrita del señor(a) XXXXXXXXXXXX identificado(a) con Cedula de Ciudadanía número XXXXXXXX, participe de la unidad de negocios de LU, el cual se encuentra ubicado en XXXXXXXXXXXXX, para que aparezca ante la cámara, en videograbación, fotografías, grabaciones de voz, entre otros medios audiovisuales con fines para la prestación de los servicios misionales, comerciales y publicitarios de la empresa dentro y fuera de la misma.\n" +
                                        "El propósito del video, material fotográfico, grabación de voz, audiovisual y biométricos, es para fines netamente publicitarios, para la prestación de los servicios misionales, y comerciales de la empresa, en ningún momento será utilizado para objetivos distintos.\n" +
                                        "El participe además de autorizar, acuerda que no cobrara a la empresa ningún valor o precio por la explotación a las fotos o medios audiovisuales en los cuales el aparezca, aun después de terminado el contrato laboral que tiene con la empresa por lo tanto además de lo anterior declara que exime de cualquier responsabilidad, ante cualquier acción legal que se pudiere llegar a emprender.\n",
                                    textAlign: TextAlign.justify,
                                    style: new TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,

                                    ),
                                  )))),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'He leído y acepto los términos y condiciones de uso'),
                            Checkbox(
                                focusColor: Colors.lightBlue,
                                activeColor: Colors.purple,
                                value: rememberMe,
                                onChanged: (newValue) {
                                  setState(() => rememberMe = newValue);
                                })
                          ]),
                      // based up on this bool value
                      showErrorMessage
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(80.0)),
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                      'Porfavor aceptar terminos y condiciones para continuar...')))
                          : Container(),
                      SizedBox(height: 20.0),
                      Container(
                        child: BouncingWidget(
                          duration: Duration(milliseconds: 100),
                          scaleFactor: 1.5,
                          onPressed: () {
                            // for your form validation
                            if (_formKey.currentState.validate()) {
                              // do your success operation here!
                              // checking for the rememberValue
                              // and setting the message bool data
                              if (rememberMe != true)
                                setState(() => showErrorMessage = true);
                              else
                                setState(() => showErrorMessage = false);
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            color: Color.fromRGBO(101, 79, 168, 1),
                            child: Container(
                              width: width / 2,
                              height: height / 20,
                              child: Text(
                                "Siguiente",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]))));
  }
}
