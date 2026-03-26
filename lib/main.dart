import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tibia_mobile/game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Trava a tela na horizontal
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Esconde a barra de notificação e botões virtuais do celular
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: GamePage()),
  );
}
