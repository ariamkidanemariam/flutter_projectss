import 'package:flutter_test/flutter_test.dart';
import 'package:kicks/model/user.dart';
import 'package:kicks/service/auth_api.dart';
import 'package:kicks/viewModel/auth_view_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockAuthApi extends Mock implements AuthApi {}

User _mockUser = User(
  id: 1,
  username: 'Joana',
  email: 'joana@example.com',
  firstName: 'Joana',
  lastName: 'Keith',
  gender: 'Female',
  image: 'https://image.url',
);

void main() {
  late MockAuthApi mockApi;

  setUp(() {
    registerFallbackValue(_mockUser);
  });

  setUp(() {
    mockApi = MockAuthApi();
  });

  group('login', () {
    test('test successful login', () async {
      SharedPreferences.setMockInitialValues({});

      when(() => mockApi.login(any(), any())).thenAnswer(
        (_) async => AuthResult(
          user: _mockUser,
          accessToken: 'access123',
          refreshToken: 'refresh123',
        ),
      );

      final authVm = AuthViewModel(authApi: mockApi);
      var success = await authVm.login('Joana', 'joanapassw');
      expect(authVm.authStatus, AuthStatus.authenticated);
      expect(success, isTrue);
     // expect(authVm.user?.email, _mockUser.email);
    });
    test('test failed login', () async {
      SharedPreferences.setMockInitialValues({});

      when(
        () => mockApi.login(any(), any()),
      ).thenThrow(AuthException('Invalid Credentials'));

      final vm = AuthViewModel(authApi: mockApi);
      final success = await vm.login('wronf', 'wrongpass');

      expect(success, isFalse);
      expect(vm.authStatus, AuthStatus.unauthenticated);
      expect(vm.errorMessage, contains('Invalid Credentials'));
    });
  });
}
