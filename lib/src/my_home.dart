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

  // Variables para animaciones
  bool _animate = false;

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
    // Ejecuta
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {animateInit; });
  }

  Future<void> cargarElementos() async {
    // Método para cargar elementos (respuestas bola 8) del archivo json
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
    // Selecciona aleatoriamente una respuesta de la lista cargada dede archivo json
    String selectedAnswer = _items[Random().nextInt(_items.length)]["answer"];
    // Navega a la pantalla de la respuesta
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

  // Controlar animación al inicio para asegurar que no se reproduce la animación por defecto
  void animateInit() {
    // Modificar tamano
    setState(() {
       _animate = false;
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
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 1, 10, 20), // Cambia a tu color de inicio
                    Color.fromARGB(255, 1, 10, 20), // Color de centro
                    Color.fromARGB(255, 1, 10, 20), // Cambia a tu color de fin
                  ],
                ),
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
              // Aplicación de widget GestureDetector
              child: GestureDetector(
                onTap: () {                  
                  setState(() {
                    _animate=true;
                  }); 
                },
                // Animación de Opacidad
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  // Navega hasta la pantalla que muestra la respuesta al momento de terminar la animación
                  onEnd: seeAnswer,
                  opacity: _animate? 0:0.5,
                  // Widget transform para escalar al doble el botón de la bola 8
                  child: Transform.scale(
                    scale: _animate?2:1,
                    child: Container(
                      width: 150,
                      height: 150,                                      
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(60, 150, 150, 210),
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
          ),
        ]
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}