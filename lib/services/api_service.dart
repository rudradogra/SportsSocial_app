import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_config.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  
  ApiException(this.message, {this.statusCode});
  
  @override
  String toString() => 'ApiException: $message';
}

class ApiService {
  static const _storage = FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';
  
  // Headers for requests
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  // Headers with auth token
  static Future<Map<String, String>> get _authHeaders async {
    final token = await getToken();
    return {
      ..._headers,
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
  
  // Token management
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }
  
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }
  
  static Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }
  
  // Generic HTTP request method
  static Future<Map<String, dynamic>> _makeRequest(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
    bool requiresAuth = false,
  }) async {
    try {
      final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      final headers = requiresAuth ? await _authHeaders : _headers;
      
      http.Response response;
      
      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(url, headers: headers)
              .timeout(ApiConfig.requestTimeout);
          break;
        case 'POST':
          response = await http.post(
            url,
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          ).timeout(ApiConfig.requestTimeout);
          break;
        case 'PUT':
          response = await http.put(
            url,
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          ).timeout(ApiConfig.requestTimeout);
          break;
        case 'DELETE':
          response = await http.delete(url, headers: headers)
              .timeout(ApiConfig.requestTimeout);
          break;
        default:
          throw ApiException('Unsupported HTTP method: $method');
      }
      
      return _handleResponse(response);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }
  
  // Handle HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      final message = data['message'] ?? data['error'] ?? 'Unknown error occurred';
      throw ApiException(message, statusCode: response.statusCode);
    }
  }
  
  // Auth API calls
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _makeRequest(
      'POST',
      ApiConfig.loginEndpoint,
      body: {
        'email': email,
        'password': password,
      },
    );
    
    // Save token if login successful
    if (response['token'] != null) {
      await saveToken(response['token']);
    }
    
    return response;
  }
  
  static Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    String? bio,
    String? sports,
    String? tags,
  }) async {
    final response = await _makeRequest(
      'POST',
      ApiConfig.registerEndpoint,
      body: {
        'username': username,
        'email': email,
        'password': password,
        if (bio != null && bio.isNotEmpty) 'bio': bio,
        if (sports != null && sports.isNotEmpty) 'sports': sports,
        if (tags != null && tags.isNotEmpty) 'tags': tags,
      },
    );
    
    // Save token if registration successful
    if (response['token'] != null) {
      await saveToken(response['token']);
    }
    
    return response;
  }
  
  static Future<Map<String, dynamic>> sendOtp({
    required String email,
  }) async {
    return await _makeRequest(
      'POST',
      ApiConfig.sendOtpEndpoint,
      body: {'email': email},
    );
  }
  
  static Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    return await _makeRequest(
      'POST',
      ApiConfig.verifyOtpEndpoint,
      body: {
        'email': email,
        'otp': otp,
      },
    );
  }
  
  static Future<Map<String, dynamic>> getCurrentUser() async {
    return await _makeRequest(
      'GET',
      ApiConfig.meEndpoint,
      requiresAuth: true,
    );
  }
  
  static Future<void> logout() async {
    await clearToken();
  }
}