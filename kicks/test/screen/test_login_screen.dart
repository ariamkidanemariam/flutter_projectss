import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kicks/Screens/login_screen.dart';
import 'package:kicks/viewModel/auth_view_model.dart';
import 'package:provider/provider.dart';

class MockAuthViewModel extends ChangeNotifier implements AuthViewModel {
  bool isLoading = false;
  AuthStatus authStatus = AuthStatus.unauthenticated;
  String? _errorMessage;

  @override
  String? get errorMessage => _errorMessage;

  @override
  set errorMessage(String? value) {
    _errorMessage = value;
  }

  bool loginCalled = false;
  bool loginReturnValue = false;

  @override
  Future<bool> login(String username, String password) async {
    loginCalled = true;
    return loginReturnValue;
  }

  @override
  Future<void> saveUserTokens(String accessToken, String refreshToken) async {}

  @override
  Future<void> autoLogin() async {}

  @override
  Future<void> logout() async {}
}

Widget _wrap(MockAuthViewModel vm) {
  return MaterialApp(
    home: ChangeNotifierProvider<AuthViewModel>.value(
      value: vm,
      child: const LoginScreen(),
    ),
  );
}

void main() {
  late MockAuthViewModel mockvm;

  setUpAll(() {
    mockvm = MockAuthViewModel();
  });

  testWidgets('Shows validation errors', (tester) async {
    await tester.pumpWidget(_wrap(mockvm));

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

    await tester.pump();

    expect(find.text('Enter username'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);
    expect(mockvm.loginCalled, isFalse);
  });
  testWidgets('Invokes vm login', (tester) async {
    await tester.pumpWidget(_wrap(mockvm));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'Username',
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'password'),
      'apassword',
    );

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

    await tester.pump();

    expect(mockvm.loginCalled, isTrue);
  });

  testWidgets('show login error message', (tester) async {
    mockvm._errorMessage = 'Invalid Credentials';
    mockvm.loginReturnValue = false;
    await tester.pumpWidget(_wrap(mockvm));
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'wronguser',
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'wrongpass',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();

    expect(find.text('Invalid Credentials'), findsOneWidget);
    expect(mockvm.loginCalled, isFalse);
  });
}
