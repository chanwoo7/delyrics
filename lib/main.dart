import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  const windowSize = Size(900, 720);
  final windowOptions = WindowOptions(
    size: windowSize,
    minimumSize: windowSize,
    center: true,
    title: 'Delyrics',
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const DelyricsApp());
}
