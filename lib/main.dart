import 'package:flutter/material.dart';
import './view/listaGastoMensal.dart';

void main() async {
  runApp(MaterialApp(
    home: ListaGastoMensal(),
    theme: ThemeData(
        hintColor: Colors.deepOrangeAccent,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));

}
