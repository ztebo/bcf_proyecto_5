import 'package:flutter/services.dart';
import 'dart:convert';

class Data { 
  
  Future<List> cargarElementos() async {
  // Método para cargar elementos del archivo json
    
  // Para leer el archivo json con los datos
  final respuesta = await rootBundle.loadString('data/answers.json');
  final data = json.decode(respuesta);
  return data["answers"];
  
  
  }
  
}
  
