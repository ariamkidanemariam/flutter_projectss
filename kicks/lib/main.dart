import 'package:flutter/material.dart';
import 'package:kicks/Screens/redirect.dart';
import 'package:kicks/model/cart.dart';
import 'package:kicks/Screens/home.dart';
import 'package:kicks/Screens/login_screen.dart';
import 'package:kicks/Screens/signup_screen.dart';
import 'package:kicks/viewModel/auth_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Redirect(),
      theme: ThemeData(fontFamily: 'Elms Sans'),
    );
  }
}
