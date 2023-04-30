import 'package:flutter/material.dart';
import 'package:yoapp/models/expenses.dart';

var mycolorschemes = ColorScheme.fromSeed(
  seedColor: (Color.fromRGBO(168, 137, 121, 1)),
);
var darkcolorschemes = ColorScheme.fromSeed(
  seedColor: (Color.fromRGBO(168, 137, 121, 1)),
);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: mycolorschemes,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: mycolorschemes.primary,
            foregroundColor: mycolorschemes.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
              color: mycolorschemes.primaryContainer,
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              )),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: mycolorschemes.secondary,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: const TextStyle(
                  fontFamily: 'OpenSans',
                  color: Color.fromARGB(255, 119, 93, 93),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        home: const Expenses());
  }
}
