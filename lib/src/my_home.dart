import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widget_answer.dart';
import 'dart:convert';

class MyHome extends StatefulWidget {
  const MyHome({super.key, required this.title});

  final String title;

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  // Lista para guardar los elementos que vienen en el archivo JSON
  List _items = [];

  // Índice del elemento seleccionado
  int selectedItem = 0;

  // Respuesta
  String answer = '';

  @override
  void initState() {
    // Para asegurar que los elementos de la lista se carguen al iniciar la aplicación
    super.initState();
    // Carga las respuestas  al comenzar la aplicación
    cargarElementos();
  }

  Future<void> cargarElementos() async {
    // Método para cargar elementos del archivo json
    if (_items.isEmpty) {
      // Para leer el archivo json con los datos
      final String respuesta = await rootBundle.loadString('data/answers.json');
      final data = json.decode(respuesta);
      setState(() {
        // Carga las respuesyas en una variable
        _items = data["answers"];
      });
    }
    else {
      // Hará esto en caso de que haya elementos paa ir alternando entre una lista con elementos
      // y una lista vacía
      setState(() {
        _items = [];
      });
    }
  }


  void seeAnswer(int selectedIndex){    
    // Método para cargar la pantalla que muestra el destino seleccionado
    String selectedAnswer = getAnswer();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WidgetAnswer(
            answer: selectedAnswer
          ),
        fullscreenDialog: true,
      ),
    );      
  }

  String getAnswer () {
    /*
    Obtiene una respuesta random
    */    
    String randomAnswer = _items[Random().nextInt(_items.length)]["answer"];    
    return randomAnswer;    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _items[4]["answer"]
            ),            
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}