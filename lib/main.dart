import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pingpongcounter/app/ping_pong_counter_app.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  setPathUrlStrategy();

  runApp(PingPongCounterApp());
}
