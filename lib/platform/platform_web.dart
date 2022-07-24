import 'dart:html';
import 'package:pingpongcounter/platform/platform_base.dart';

class PlatformMethods extends PlatformMethodsBase {
  @override
  void webFullscreen(bool enable) {
    if (enable) {
      document.documentElement?.requestFullscreen();
    } else {
      document.exitFullscreen();
    }
  }
}
