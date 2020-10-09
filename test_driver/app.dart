import 'dart:io';
import 'package:flutter/material.dart';
import "package:flutter_driver/driver_extension.dart";
import 'package:expenses/main.dart' as app;

void main() {
  enableFlutterDriverExtension(handler: (command) async {
    switch (command) {
      case 'restart':
        _startApp();
        return 'ok';
    }
    throw Exception('Unknown command');
  });
  _startApp();
}

//Iria reiniciar o app a cada vez que o requestData passar a informação para restart
void _startApp() {
  runApp(app.ExpensesApp(key: UniqueKey()));
}
