import 'package:flutter/foundation.dart';
import 'package:kicks/model/api_error.dart';
import 'package:kicks/service/auth_api.dart';
import 'package:kicks/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { unauthenticated, authenticated }

class AuthViewModel extends ChangeNotifier {
  final AuthApi _authApi;
  bool isLoading = false;

  User? user;
  String? errorMessage;

  static const String ACCESS_TOKEN_KEY = "access_token_key";
  static const String REFRESH_TOKEN_KEY = "refresh_token_key";
  AuthStatus authStatus = AuthStatus.unauthenticated;

  AuthViewModel({AuthApi? authApi}) : _authApi = authApi ?? AuthApi();

  Future<bool> login(String username, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      errorMessage = null;
      var result = await _authApi.login(username, password);
      user = result.user;
      await saveUserTokens(result.accessToken, result.refreshToken);
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } on ApiError catch (e) {
      errorMessage = e.message;
      authStatus = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    } catch (e) {
      errorMessage = e.toString();
      authStatus = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveUserTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ACCESS_TOKEN_KEY, accessToken);
    await prefs.setString(REFRESH_TOKEN_KEY, refreshToken);
  }

  Future<void> autoLogin() async {
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString(ACCESS_TOKEN_KEY);
    String? refreshToken = prefs.getString(REFRESH_TOKEN_KEY);

    if (accessToken == null || refreshToken == null) {
      authStatus = AuthStatus.unauthenticated;
      isLoading = false;
      notifyListeners();
      return;
    }

    try {
      user = await _authApi.fetchCurrentUser(accessToken);
      authStatus = AuthStatus.authenticated;
    } catch (_) {
      try {
        final tokenResponse = await _authApi.refresh(refreshToken);
        accessToken = tokenResponse.accessToken;
        refreshToken = tokenResponse.refreshToken;
        await saveUserTokens(accessToken, refreshToken);
        user = await _authApi.fetchCurrentUser(accessToken);
        authStatus = AuthStatus.authenticated;
      } catch (_) {
        await logout();
        return;
      }
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(ACCESS_TOKEN_KEY);
    await prefs.remove(REFRESH_TOKEN_KEY);

    authStatus = AuthStatus.unauthenticated;
    isLoading = false;
    notifyListeners();
  }
}
