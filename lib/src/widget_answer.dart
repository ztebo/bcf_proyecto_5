import 'package:bcf_proyecto_5/src/my_home.dart';
import 'package:flutter/material.dart';

/*
Este widget tiene la misión de desplegar los detalles del lugar que se seleccionó
en la pantalla de ListView.
*/

class WidgetAnswer extends StatefulWidget {
  const WidgetAnswer({
    super.key,
    required this.answer
    
  });

  final String answer; 

  @override
  _WidgetAnswer createState() => _WidgetAnswer();
}

class _WidgetAnswer extends State<WidgetAnswer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      
      body: Container(
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
        child: Center(
          child: Text(
  widget.answer,
  textAlign: TextAlign.center,
  style: const TextStyle(
    shadows: [
      Shadow(
        blurRadius: 50,
        color: Colors.white,
        offset: Offset(0.0, 0.0),
      ),
    ],
    fontSize: 20,
  ),
),
        )
        
      )
      ,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyHome(title: 'Bola 8 BCF5')))
        },
        child: const Icon(Icons.arrow_back_sharp),
      ),
      
      
    );
  }
}