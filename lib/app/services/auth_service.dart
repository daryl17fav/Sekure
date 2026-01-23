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
  
  // Storage keys (Only need to cache user data for offline/quick access, session is in cookies)
  static const String _userKey = 'user_data';
  
  // Observable user state
  final Rxn<User> currentUser = Rxn<User>();
  final RxBool isAuthenticated = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Logic moved to init() for async handling
  }

  /// Async Initialization
  Future<AuthService> init() async {
    await _loadUserFromStorage();
    return this;
  }



  /// Login with email and password
  Future<void> login(String email, String password) async {
    try {
      // POST /auth/login
      // Backend validates (and might set session).
      await _apiService.post(
        ApiConfig.login,
        {
          'email': email,
          'password': password,
        },
      );

      // Trigger OTP sending explicitly as requested
      // await sendOtp(email); // Removed as backend handles it
    } catch (e) {
      rethrow;
    }
  }

  /// Register a new user
  Future<void> register(Map<String, dynamic> userData) async {
    try {
      // POST /auth/register
      await _apiService.post(
        ApiConfig.register,
        userData,
      );

      // Trigger OTP sending explicitly if email is available
      // if (userData.containsKey('email')) {
      //   await sendOtp(userData['email']);
      // } // Removed as backend handles it
    } catch (e) {
      rethrow;
    }
  }

  /// Register a new seller
  Future<void> registerSeller(Map<String, dynamic> sellerData) async {
    try {
      // Backend expects JSON, not FormData
      // STRICT PAYLOAD: Only sending fields supported by the API documentation
      final Map<String, dynamic> apiData = {
        'email': sellerData['email'],
        'phone': sellerData['phone'],
        'password': sellerData['password'], 
        'role': 'seller', 
      };

      // TODO: Uncomment when backend supports these fields
      // if (sellerData['name'] != null) {
      //   apiData['name'] = sellerData['name'];
      // }
      // if (sellerData['location'] != null) {
      //   apiData['location'] = sellerData['location'];
      // }
      // idCardImage is also ignored as there is no upload endpoint

      // We call our modified register, which triggers sendOtp
      await register(apiData);
    } catch (e) {
      rethrow;
    }
  }

  /// Verify OTP
  Future<User> verifyOtp(String email, String otp) async {
    try {
      // POST /auth/verify-otp
      // The backend validates OTP and sets the Session Cookie in the response header.
      // Dio persistence will automatically save this cookie.
      await _apiService.post(
        ApiConfig.verifyOtp,
        {
          'email': email,
          'otp': otp,
        },
      );

      // Now we have a session. Fetch the user profile to confirm and get details.
      final user = await getCurrentUser();
      
      if (user == null) {
         throw ApiException('Verification successful but failed to fetch user profile.');
      }

      isAuthenticated.value = true;
      return user;
    } catch (e) {
      // If verification fails or fetching user fails
      rethrow;
    }
  }

  /// Forgot Password
  Future<void> forgotPassword(String email) async {
    try {
      await _apiService.post(
        ApiConfig.forgotPassword,
        {'email': email},
      );
    } catch (e) {
      rethrow;
    }
  }
  
  /// Reset Password
  Future<void> resetPassword(String password, String? token) async {
    if (isAuthenticated.value) {
       try {
         await _apiService.post("auth/reset-password", {'password': password});
       } catch (e) {
         rethrow;
       }
    } else {
      throw ApiException('User must be authenticated to set password');
    }
  }

  /// Resend OTP
  Future<void> resendOtp(String email) async {
    try {
      // Use the new endpoint for resending as well
      await _apiService.post(
        ApiConfig.resendOtp,
        {'email': email},
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Logout current user
  Future<void> logout() async {
    try {
      // Call backend logout
      try {
        await _apiService.post(ApiConfig.logout, {});
      } catch (e) {
        // Ignore specific API logout errors (e.g. already logged out)
      }

      // Clear cookies
      await _apiService.clearCookies();

      // Clear local user data
      await _clearStorage();

      // Update state
      currentUser.value = null;
      isAuthenticated.value = false;
    } catch (e) {
      rethrow;
    }
  }

  /// Get current user from backend (Session check)
  Future<User?> getCurrentUser() async {
    try {
      // This request will send the persistent cookie automatically.
      final response = await _apiService.get(ApiConfig.me);
      
      // Adaptation to backend response structure
      // Response might be { user: {...} } or just {...} or { data: {...} }
      final userData = response['user'] ?? response['data'] ?? response;

      if (userData == null || (userData is Map && userData.isEmpty)) return null;

      // Check if userData looks like a user (has email/id)
      // Safely parsing:
      User user;
      try {
         user = User.fromJson(userData);
      } catch (e) {
         // If parsing fails, maybe response wasn't a user object?
         // If unauthorized, ApiService usually throws. 
         return null;
      }
      
      currentUser.value = user;
      isAuthenticated.value = true;
      await _saveUser(user);

      return user;
    } catch (e) {
      // If unauthorized (401), ApiService throws. Use that to assume logged out.
      await _clearStorage();
      currentUser.value = null;
      isAuthenticated.value = false;
      return null;
    }
  }

  /// Save user data cache
  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, user.toJson().toString());
  }

  /// Load user from storage on app start (Optimistic, then verify)
  Future<void> _loadUserFromStorage() async {
    try {
      // 1. Try to load cached user for immediate UI
      final prefs = await SharedPreferences.getInstance();
      final userStr = prefs.getString(_userKey);
      
      if (userStr != null) {
         // Just show cached user temporarily?
         // Often better to verify session.
      }
      
      // 2. Perform real session check
      await getCurrentUser();
      
    } catch (e) {
      await _clearStorage();
    }
  }

  /// Clear all stored user cache
  Future<void> _clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  /// Force clear all auth data (Nuclear option for 409/429/Debug)
  Future<void> forceClearAuth() async {
    try {
      // 1. Clear Cookies (Session)
      await _apiService.clearCookies();

      // 2. Clear Local Storage (Cache)
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // We can stick to clear() as requested by user or just remove userKey

      // 3. Reset State
      currentUser.value = null;
      isAuthenticated.value = false;
      
      print('AuthService: Nuclear clear executed.');
    } catch (e) {
      print('AuthService: Failed to force clear: $e');
    }
  }

  /// Check if user is authenticated
  bool get authenticated => isAuthenticated.value;

  /// Get current user
  User? get user => currentUser.value;
}
