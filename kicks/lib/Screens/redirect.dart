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
        if (authViewModel.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        switch (authViewModel.authStatus) {
          case AuthStatus.authenticated:
            return const HomeScreen();
          case AuthStatus.unauthenticated:
            return const LoginScreen();
        }
      },
    );
  }
}
