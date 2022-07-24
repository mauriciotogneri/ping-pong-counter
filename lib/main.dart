import 'package:flutter/material.dart';
import 'package:pingpongcounter/ping_pong_counter_app.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();

  runApp(PingPongCounterApp());
}
