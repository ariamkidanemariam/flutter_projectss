import 'dart:convert';
import 'package:kicks/model/user.dart';
import 'package:kicks/model/token_response.dart';
import 'package:http/http.dart' as http;

class AuthResult {
  final User user;
  final String accessToken;
  final String refreshToken;

  AuthResult({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });
}

class AuthException {
  final String message;

  AuthException(this.message);

  @override
  String toString() {
    return message;
  }
}

class AuthApi {
  static const baseUrl = "https://dummyjson.com";
  late http.Client _client;

AuthApi({ http.Client? client}) {
_client = client ?? http.Client();
}

  Future<AuthResult> login(String username, String password) async {
    final response = await _client.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );
    if (response.statusCode != 200) {
      var body = jsonDecode(response.body);
      throw AuthException(body["message"] ?? "login failed");
    }

    var json = jsonDecode(response.body);
    return AuthResult(
      user: User.fromJson(json),
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
  Future<User> fetchCurrentUser(String accessToken) async {
    final response = await _client.get(
      Uri.parse("$baseUrl/auth/me"),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode != 200) {
      var errorBody = jsonDecode(response.body);
      throw AuthException(errorBody["message"] ?? "Token Invalid");
    }

    var body = jsonDecode(response.body);
    return User.fromJson(body);
  }

  Future<TokenResponse> refresh(String refreshToken) async {
    final response = await _client.post(
      Uri.parse("$baseUrl/auth/refresh"),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );
    if (response.statusCode != 200) {
      var errorBody = jsonDecode(response.body);
      throw AuthException(errorBody['message'] ?? 'Token refresh failed');
    }

    var json = jsonDecode(response.body);
    return TokenResponse(json['accessToken'], json['refreshToken']);
  }
}