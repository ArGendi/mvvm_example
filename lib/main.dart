import 'package:flutter/material.dart';
import 'package:mvvm_example/view/screens/person_screen.dart';
import 'package:mvvm_example/view_model/person_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PersonViewModel()),
      ],
      child: const MaterialApp(
        title: 'MVVM',
        home: PersonScreen(),
      ),
    );
  }
}