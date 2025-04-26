import 'package:flutter/material.dart';
import 'package:projetointegrador2025/widgets/primary_button.dart';
import 'utils/index.dart';

void main() => runApp(const CoguApp());

class CoguApp extends StatelessWidget {
  const CoguApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COGUS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.cream,
        fontFamily: 'Times',
        elevatedButtonTheme: PrimaryButton.theme,
        inputDecorationTheme: const InputDecorationTheme(
          border: UnderlineInputBorder(),
        ),
      ),
      initialRoute: Rotas.home,
      routes: Rotas.map,
    );
  }
}
