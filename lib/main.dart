import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pingpongcounter/app/ping_pong_counter_app.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  runApp(PingPongCounterApp());
}
