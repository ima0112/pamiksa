import 'package:flutter/material.dart';
import 'package:pamiksa/src/app.dart';
import 'package:pamiksa/src/providers/themes/theme_manager.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeManager())],
      child: MyApp(),
    ));
