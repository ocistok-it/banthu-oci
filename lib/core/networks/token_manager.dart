import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/sign_in/data/models/user_decoded_model.dart';

abstract class TokenManager {
  Future<String?> getFcmToken();
  Future<void> saveFcmToken(String fcmToken);
  Future<void> clearFcmToken();

  Future<AuthToken?> getAuthToken();
  Future<void> saveAuthToken(AuthToken token);
  Future<void> clearAuthToken();
  Future<bool> get isLoggedIn;
}

class TokenManagerImpl implements TokenManager {
  static const String _fcmTokenKey = 'fcm_token';
  static const String _authTokenKey = 'auth_token';

  final FlutterSecureStorage _secureStorage;

  TokenManagerImpl(this._secureStorage);

  @override
  Future<void> clearFcmToken() async {
    await _secureStorage.delete(key: _fcmTokenKey);
  }

  @override
  Future<String?> getFcmToken() async {
    try {
      final storedFcmToken = await _secureStorage.read(key: _fcmTokenKey);
      if (storedFcmToken == null) return null;
      return storedFcmToken;
    } catch (e) {
      // If token is corrupted, clear it
      await clearFcmToken();
      return null;
    }
  }

  @override
  Future<void> saveFcmToken(String fcmToken) async {
    try {
      await _secureStorage.write(key: _fcmTokenKey, value: fcmToken);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthToken?> getAuthToken() async {
    try {
      final tokenJson = await _secureStorage.read(key: _authTokenKey);
      if (tokenJson == null) return null;

      final tokenMap = jsonDecode(tokenJson) as Map<String, dynamic>;
      final token = AuthToken.fromJson(tokenMap);

      // Auto-cleanup expired tokens with no refresh token
      if (token.isExpired && token.refreshToken == null) {
        await clearAuthToken();
        return null;
      }
      return token;
    } catch (e) {
      // If token is corrupted, clear it
      await clearAuthToken();
      return null;
    }
  }

  @override
  Future<void> saveAuthToken(AuthToken token) async {
    try {
      await _secureStorage.write(
        key: _authTokenKey,
        value: jsonEncode(token.toJson()),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearAuthToken() async {
    await _secureStorage.delete(key: _authTokenKey);
  }

  @override
  Future<bool> get isLoggedIn async {
    final token = await getAuthToken();
    return token != null && !token.isExpired;
  }
}

class AuthToken extends Equatable {
  final String accessToken;
  final String? refreshToken;
  final DateTime expiresIn;
  final UserData? userData;

  bool get isExpired {
    final bufferTime = DateTime.now().add(const Duration(seconds: 30));
    return bufferTime.isAfter(expiresIn);
  }

  factory AuthToken.empty() => AuthToken(
    accessToken: "",
    refreshToken: "",
    expiresIn: DateTime(2099),
    userData: const UserData(),
  );

  const AuthToken({
    required this.accessToken,
    this.refreshToken,
    required this.expiresIn,
    required this.userData,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expiresIn: DateTime.fromMillisecondsSinceEpoch(json['expires_in']),
      userData:
          json["user_data"] == null
              ? null
              : UserData.fromJson(json["user_data"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_in': expiresIn.millisecondsSinceEpoch,
      'user_data': userData?.toJson(),
    };
  }

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
