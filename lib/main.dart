import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: new Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  // controller's
  TextEditingController peso = new TextEditingController();
  TextEditingController altura = new TextEditingController();

  String _resultadoText = "";

  void _ClearText() {
    // seta a interface
    setState(() {
      peso.text = "";
      altura.text = "";
      _resultadoText = "";
      _formKey = new GlobalKey<FormState>(); 
    });
  }

  void _Calcular() {
    String result = "";
    double alturaDouble = double.parse(altura.text) / 100;
    double pesoDouble = double.parse(peso.text);
    double imc = pesoDouble / (alturaDouble * alturaDouble);

    if (imc < 18.6) {
      result = "Abaixo do Peso ($imc)";
    } else if (imc >= 18.4 && imc < 24.9) {
      result = "Peso Ideal ($imc)";
    } else if (imc >= 24.9 && imc < 29.9) {
      result = "Levemente acima do Peso ($imc)";
    } else if (imc >= 29.9 && imc < 34.9) {
      result = "Obesidade Grau I ($imc)";
    } else if (imc >= 29.9 && imc < 39.9) {
      result = "Obesidade Grau II ($imc)";
    } else if (imc >= 39.9) {
      result = "Obesidade Grau III ($imc)";
    }
    // seta a interface
    setState(() {
      _resultadoText = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _ClearText();
                })
          ],
        ),
        backgroundColor: Colors.white70,
        body: SingleChildScrollView(
            padding: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person, size: 125, color: Colors.blueGrey),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.blueGrey,
                    maxLength: 2,
                    decoration: InputDecoration(
                        labelText: "Peso Kg",
                        labelStyle: TextStyle(color: Colors.blueGrey)),
                    style: TextStyle(color: Colors.blueGrey, fontSize: 32),
                    controller: peso,
                    validator: (value) {
                      if (value.isEmpty) return "Campo vazio!";
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.blueGrey,
                    maxLength: 4,
                    decoration: InputDecoration(
                        labelText: "Altura",
                        labelStyle: TextStyle(color: Colors.blueGrey)),
                    style: TextStyle(color: Colors.blueGrey, fontSize: 32),
                    controller: altura,
                    validator: (value) {
                      if (value.isEmpty) return "Campo vazio!";
                    },
                  ),
                  Container(
                      height: 45.0,
                      margin: new EdgeInsets.symmetric(vertical: 10.0),
                      child: RaisedButton(
                        color: Colors.blueGrey,
                        textColor: Colors.white70,
                        child: Text(
                          "Calcular IMC",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _Calcular();
                          }
                        },
                      )),
                  Text(_resultadoText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38))
                ]),
            )));
  }
}
