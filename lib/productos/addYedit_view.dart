import 'package:app_prueba/Widgets/widgets.dart';
import 'package:app_prueba/home_widget.dart';
import 'package:app_prueba/modelos/producto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddYEditView extends StatefulWidget {
  final Producto productoEdit;
  final String idPuntoVenta;
  const AddYEditView({Key key, this.productoEdit, this.idPuntoVenta})
      : super(key: key);
  @override
  _AddYEditViewState createState() => _AddYEditViewState();
}

class _AddYEditViewState extends State<AddYEditView> {
  String _errorStock, _errorPrecioCosto, _errorPrecioMayor; //CAMBIAR NOMBRE
  TextEditingController _stockController;
  TextEditingController _preciocostoController;
  TextEditingController _preciomayorController;

  @override
  void initState() {
    print("${widget.idPuntoVenta}");
    print("${widget.productoEdit.documentID}");
    super.initState();
    _stockController =
        TextEditingController(text: (widget.productoEdit.stock).toString());
    _preciocostoController = TextEditingController(
        text: (widget.productoEdit.preciocosto).toString());
    _preciomayorController = TextEditingController(
        text: (widget.productoEdit.preciomayor).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color(0xFF21BFBD),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(children: <Widget>[
            SizedBox(height: widget.productoEdit == null ? 25.0 : 0),
            Titulo(
              text1: "EDITAR",
              text2: "Producto",
            ),
            SizedBox(height: 40.0),
            Container(
                height: widget.productoEdit == null ? 650 : 640,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: widget.productoEdit == null
                      ? BorderRadius.only(topLeft: Radius.circular(75.0))
                      : BorderRadius.only(
                          topLeft: Radius.circular(75.0),
                          topRight: Radius.circular(75.0)),
                ),
                padding: const EdgeInsets.all(70.0),
                child: Center(
                    child: Column(children: <Widget>[
                  textosProdc(
                      context,
                      false,
                      _preciocostoController,
                      TextInputType.number,
                      8,
                      _errorPrecioCosto,
                      "Precio Costo",
                      Icon(Icons.event_note_sharp)),
                  Divider(),
                  textosProdc(
                      context,
                      false,
                      _preciomayorController,
                      TextInputType.number,
                      8,
                      _errorPrecioMayor,
                      "Precio Mayor",
                      Icon(Icons.create)),
                  Divider(),
                  textosProdc(
                      context,
                      false,
                      _stockController,
                      TextInputType.text,
                      8,
                      _errorStock,
                      "Stock",
                      Icon(Icons.home)),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        validEdit();
                      });
                    },
                    child: BotonPrincipal(
                      textIcon: "EDITAR",
                      iconito: Icons.file_upload,
                    ),
                  )
                ]))),
          ]),
        ));
  }

  Container textosProdc(
      BuildContext context,
      bool readonly,
      TextEditingController controller,
      TextInputType teclado,
      int maxlength,
      String error,
      String label,
      Icon icono) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 80,
      padding: EdgeInsets.only(
        top: 4,
        left: 16,
        right: 16,
        bottom: 4,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black38, blurRadius: 5),
          ]),
      child: TextField(
          controller: controller,
          readOnly: readonly,
          maxLength: maxlength,
          textCapitalization: TextCapitalization.characters,
          keyboardType: teclado,
          autocorrect: false,
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.deepOrange[500],
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            icon: icono,
            errorText: error,
            labelText: label,
          )),
    );
  }

  validEdit() async {
    if (_stockController.text == (widget.productoEdit.stock).toString() &&
        _preciocostoController.text ==
            (widget.productoEdit.preciocosto).toString() &&
        _preciomayorController.text ==
            (widget.productoEdit.preciomayor).toString()) {
      _errorStock = "Realice algún cambio";
      _errorPrecioCosto = "Realice algún cambio";
      _errorPrecioMayor = "Realice algún cambio";
    } else {
      editarDatos(
          widget.productoEdit.documentID,
          widget.idPuntoVenta,
          _stockController.text,
          _preciocostoController.text,
          _preciomayorController.text);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }
}

final db = FirebaseFirestore.instance;
editarDatos(String id, String idpv, String stock, String preciocosto,
    String preciomayor) {
  int stockfinal = int.parse(stock);
  double preciocostofinal = double.parse(preciocosto);
  double preciomayorfinal = double.parse(preciomayor);

  db
      .collection("punto_venta")
      .doc(idpv)
      .collection("productos")
      .doc(id)
      .update({
    'preciocosto': preciocostofinal,
    'preciomayor': preciomayorfinal,
    'stock': stockfinal,
  });
}
