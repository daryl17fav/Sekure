import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
import '../models/user_model.dart';
import 'api_service.dart';

/// Authentication Service
/// 
/// Handles all authentication-related operations including
/// login, registration, logout, and session management

class AuthService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();
  
  // Storage keys
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  
  // Observable user state
  final Rxn<User> currentUser = Rxn<User>();
  final RxBool isAuthenticated = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    _loadUserFromStorage();
  }

  /// Login with email and password
  Future<User> login(String email, String password) async {
    try {
      final response = await _apiService.post(
        ApiConfig.login,
        {
          'email': email,
          'password': password,
        },
      );

      // Extract token and user from response
      final token = response['token'] ?? response['accessToken'];
      final userData = response['user'] ?? response['data'];

      if (token == null) {
        throw ApiException('No token received from server');
      }

      if (userData == null) {
        throw ApiException('No user data received from server');
      }

      // Create user object
      final user = User.fromJson(userData);

      // Save token and user data
      await _saveToken(token);
      await _saveUser(user);

      // Update state
      currentUser.value = user;
      isAuthenticated.value = true;

      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// Register a new user
  Future<User> register(Map<String, dynamic> userData) async {
    try {
      final response = await _apiService.post(
        ApiConfig.register,
        userData,
      );

      // Check if registration requires OTP verification
      if (response['requiresVerification'] == true || 
          response['message']?.toString().toLowerCase().contains('verify') == true) {
        // Return a temporary user object for OTP flow
        final tempUser = User.fromJson(response['user'] ?? userData);
        return tempUser;
      }

      // If no verification needed, handle like login
      final token = response['token'] ?? response['accessToken'];
      final user = User.fromJson(response['user'] ?? response['data']);

      if (token != null) {
        await _saveToken(token);
        await _saveUser(user);
        currentUser.value = user;
        isAuthenticated.value = true;
      }

      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// Verify OTP
  Future<User> verifyOtp(String email, String otp) async {
    try {
      final response = await _apiService.post(
        ApiConfig.verifyOtp,
        {
          'email': email,
          'otp': otp,
        },
      );

      final token = response['token'] ?? response['accessToken'];
      final userData = response['user'] ?? response['data'];

      if (token == null || userData == null) {
        throw ApiException('Invalid verification response');
      }

      final user = User.fromJson(userData);

      await _saveToken(token);
      await _saveUser(user);

      currentUser.value = user;
      isAuthenticated.value = true;

      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// Logout current user
  Future<void> logout() async {
    try {
      // Try to call logout endpoint (optional, may fail if token expired)
      try {
        await _apiService.post(ApiConfig.logout, {});
      } catch (e) {
        // Ignore logout endpoint errors
      }

      // Clear local storage
      await _clearStorage();

      // Update state
      currentUser.value = null;
      isAuthenticated.value = false;
    } catch (e) {
      rethrow;
    }
  }

  /// Get current user from backend
  Future<User?> getCurrentUser() async {
    try {
      final token = await getToken();
      if (token == null) return null;

      final response = await _apiService.get(ApiConfig.me);
      final userData = response['user'] ?? response['data'];

      if (userData == null) return null;

      final user = User.fromJson(userData);
      currentUser.value = user;
      await _saveUser(user);

      return user;
    } catch (e) {
      // If getting current user fails, clear session
      await _clearStorage();
      currentUser.value = null;
      isAuthenticated.value = false;
      return null;
    }
  }

  /// Get stored authentication token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Save authentication token
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// Save user data
  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, user.toJson().toString());
  }

  /// Load user from storage on app start
  Future<void> _loadUserFromStorage() async {
    try {
      final token = await getToken();
      if (token != null) {
        // Token exists, try to get current user
        await getCurrentUser();
      }
    } catch (e) {
      // Failed to load user, clear storage
      await _clearStorage();
    }
  }

  /// Clear all stored authentication data
  Future<void> _clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  /// Check if user is authenticated
  bool get authenticated => isAuthenticated.value;

  /// Get current user
  User? get user => currentUser.value;
}
