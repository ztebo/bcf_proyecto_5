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
            image: DecorationImage(
              image: AssetImage('assets/images/background1.png'),
              fit: BoxFit.fill
            )
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            widget.answer,
            style: const TextStyle(
              fontSize: 20
            ),
          ),
        )
        
      )
      ,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Icon(Icons.arrow_back_sharp),
      ),
      
      
    );
  }
}