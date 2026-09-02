import 'package:flutter/material.dart';
import 'package:kicks/Screens/home.dart';
import 'package:kicks/Screens/login_screen.dart';
import 'package:kicks/viewModel/auth_view_model.dart';
import 'package:provider/provider.dart';

class Redirect extends StatelessWidget {
  const Redirect({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        var status = authViewModel.status;
        switch (status) {
          case AuthStatus.authenticated:
            return HomeScreen();
          case AuthStatus.unauthenticated:
            return LoginScreen();
          case AuthStatus.authenticated:
            return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
