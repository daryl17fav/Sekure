import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController extends GetxController {
  // Services
  final AuthService _authService = Get.find<AuthService>();

  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  // Observable states
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final rememberMe = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

   void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

   void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

   void goToForgotPassword() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }

   bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

   void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

     if (email.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer votre adresse email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    if (!isValidEmail(email)) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer une adresse email valide',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    // Validate password
    if (password.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer votre mot de passe',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
        'Erreur',
        'Le mot de passe doit contenir au moins 6 caractères',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    // Call real API
    if (isLoading.value) return;  
    isLoading.value = true;
    
    try {
       await _authService.login(email, password);
      
      isLoading.value = false;
      
      Get.snackbar(
        'Succès',
        'Veuillez vérifier votre email pour le code de connexion',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      );
      
      // Navigate to verification
      Get.toNamed(
        Routes.VERIFICATION,
        arguments: {
          'email': email,
          // We don't know the role yet, but verification controller mainly needs email to resend/verify.
          // Role might be needed for next step specific navigation, but let's assume standard behavior or fetch from me after verify.
        },
      );
    } catch (e) {
      isLoading.value = false;
      
      // Strict clear on rate limit or critical errors
      if (e.toString().contains('Too many')) {
        _authService.forceClearAuth();
      }

      Get.snackbar(
        'Erreur',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 3),
      );
    }
  }

  void signInWithGoogle() async {
    try {
      isLoading.value = true;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      
      if (googleUser != null) {
        final userData = {
          'email': googleUser.email,
          'name': googleUser.displayName,
          'socialId': googleUser.id,
          'provider': 'google',
        };
        await _checkSocialUserAndRedirect(userData);
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Erreur', 'Google Sign In Failed: $e');
    }
  }

  void signInWithFacebook() async {
    try {
      isLoading.value = true;
      final LoginResult result = await FacebookAuth.instance.login();
      
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        final mappedData = {
          'email': userData['email'],
          'name': userData['name'],
          'socialId': userData['id'],
          'provider': 'facebook',
        };
        await _checkSocialUserAndRedirect(mappedData);
      } else {
        Get.snackbar('Erreur', 'Facebook Sign In Failed: ${result.message}');
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Erreur', 'Facebook Sign In Error: $e');
    }
  }

  void signInWithApple() async {
    try {
      isLoading.value = true;
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      
      final userData = {
        'email': credential.email,
        'name': '${credential.givenName ?? ''} ${credential.familyName ?? ''}'.trim(),
        'socialId': credential.userIdentifier,
        'provider': 'apple',
      };
      
      // Apple only returns name/email on first sign in, so might be null on subsequent logins
      // Handling that would require local storage or backend check, assuming passed data for now
      await _checkSocialUserAndRedirect(userData);

    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Erreur', 'Apple Sign In Failed: $e');
    }
  }

  Future<void> _checkSocialUserAndRedirect(Map<String, dynamic> userData) async {
    try {
      // TODO: Call backend to check if user exists
      // bool userExists = await _authService.checkSocialUser(userData['socialId']);
      
      // Simulating "New User" scenario for this task as requested
      // logic: if (userExists) { login } else { goToRoleSelection }
      
      bool isNewUser = true; // Force new user flow for demo/implementation
      
      if (isNewUser) {
        isLoading.value = false;
        Get.toNamed(Routes.ROLE_SELECTION, arguments: userData);
      } else {
        // Handle existing user login (fetch token/session)
        isLoading.value = false;
        Get.offAllNamed(Routes.HOME); 
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Erreur', 'Validation failed: $e');
    }
  }
}
