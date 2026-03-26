import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tibia_mobile/game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: GamePage()),
  );
}
