import 'package:bcf_proyecto_5/src/my_home.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// Este widget tiene la misión de desplegar los detalles del lugar que se seleccionó
/// en la pantalla de ListView.
/// Este Widget se encarga de guardar las preguntas y respuestas que se van recibiendo
/// [question] es el texto de la pregunta que se muestra en la pantalla de ListView.
/// [answer] es el texto de la respuesta que se muestra en la pantalla de ListView.

class WidgetAnswer extends StatefulWidget {
  const WidgetAnswer({
    super.key,
    required this.question,
    required this.answer
    
  });

  final String question;
  final String answer; 

  @override
  _WidgetAnswerState createState() => _WidgetAnswerState();
}

class _WidgetAnswerState extends State<WidgetAnswer> with SingleTickerProviderStateMixin {

  // Definición de animación
  late AnimationController _controller;
  late Animation<double> _animation;

  

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      // Duración de la animación
      duration: const Duration(seconds: 2),      
      vsync: this,
    );
    // Define cómo sucede la animación
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    // Inicia la animación al momento en que se carga la pantalla del scaffold de respuesta
    _controller.forward();

    // Guardar la pregunta y respuesta cuando se inicializa el widget
    _saveQuestionAndAnswer();


  }

  @override
  void dispose() {
    // Limpia la animación cuando termina de usarse el widget
    _controller.dispose();
    // Limpia el widget cuando termina de usarse el widget
    super.dispose();
  }

    // Método para guardar la pregunta y respuesta
  Future<void> _saveQuestionAndAnswer() async {
    try {
      final file = await _getLocalFile();
      List<Map<String, dynamic>> qaList = [];

      if (await file.exists()) {
        String contents = await file.readAsString();
        if (contents.isNotEmpty) {
          qaList = List<Map<String, dynamic>>.from(json.decode(contents));
        }
      } else {
        // Si el archivo no existe, lo creamos
        await file.create(recursive: true);
      }

      qaList.add({
        'question': widget.question,
        'answer': widget.answer,
      });


      await file.writeAsString(json.encode(qaList));
      /// Este print permite comprobar que se guardaron los datos y la ruta del archivo.
      /// Muestra también el total de preguntas y respuestas guardadas
      debugPrint('Dats guardados: $qaList en ${file.path}');
    } catch (e) {
      /// Este print permite identificar el error en caso de que no se guarden los datos
      debugPrint('Error al guardar: $e');
    }
  }

  // Método para obtener el archivo local
  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    debugPrint('${directory.path}/answers_saved.json');
    return File('${directory.path}/answers_saved.json');
  }

  

 

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
              Color.fromARGB(255, 1, 10, 20),
              Color.fromARGB(255, 1, 10, 20),
              Color.fromARGB(255, 1, 10, 20),
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _animation,
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
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyHome(title: 'Bola 8 BCF5')),
          )
        },
        child: const Icon(Icons.arrow_back_sharp),
      ),
    );
  }
}