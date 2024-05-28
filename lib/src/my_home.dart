import 'dart:async';
import 'dart:math';
import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
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

  // Variables para animaciones
  int _size = 150;
  int _opacity = 100;

  
  

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


  void seeAnswer(){
    // Ejecutar animacion
    animateTransition();
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

  // Controlar animación
  void animateTransition() {
    // Modificar tamano
    setState(() {
       _size = 300;
    });
    // Modificar opacidad
    setState(() {
      _opacity = 0;
    });
   
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background1.png'),
                  fit: BoxFit.fill
                )
            ),
            child: const Center(
              child: Column(          
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLength: 100,
                      minLines: 1,
                      maxLines: null,
                    ),) ,
                  /*ElevatedButton(
                    onPressed: seeAnswer,
                    child: const Text('Dime que piensas...')
                  )*/
                ],
              ),
            ),
          ),
        
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: seeAnswer,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: _opacity,
                  child: AnimatedContainer(
                    width: _size,
                    height: _size,
                    duration: const Duration(milliseconds: 500),                  
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_drop_up, size: 60,),
                          Text(
                            '8',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}