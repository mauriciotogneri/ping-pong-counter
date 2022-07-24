import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pingpongcounter/app/ping_pong_counter_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  runApp(PingPongCounterApp());
}
