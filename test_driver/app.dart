import 'dart:io';
import 'package:flutter/material.dart';
import "package:flutter_driver/driver_extension.dart";
import 'package:expenses/main.dart' as app;

void main() {
  enableFlutterDriverExtension();
  app.main();
}
