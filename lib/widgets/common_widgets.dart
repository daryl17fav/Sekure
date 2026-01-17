import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SekureBackground extends StatelessWidget {
  final Widget child;
  final bool showWhiteFooter;  

  const SekureBackground({super.key, required this.child, this.showWhiteFooter = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            right: -100,
            top: 150,
            child: Opacity(
              opacity: 0.05,
              child: Icon(Icons.lock, size: 500, color: AppColors.primaryBlue),
            ),
          ),
          
          SafeArea(child: child),
        ],
      ),
    );
  }
}

class SekureLogo extends StatelessWidget {
  final double size;
  const SekureLogo({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.lock, color: AppColors.primaryRed, size: size),
        const SizedBox(width: 8),
        RichText(
          text: TextSpan(
            style: GoogleFonts.poppins(fontSize: size * 0.8, fontWeight: FontWeight.bold),
            children: [
              const TextSpan(text: 'Sékure', style: TextStyle(color: AppColors.primaryBlue)),
              const TextSpan(text: 'pay', style: TextStyle(color: AppColors.primaryRed)),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final VoidCallback? onSuffixIconTap;

  const CustomTextField({
    super.key,
    required this.hint,
    this.isPassword = false,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          suffixIcon: suffixIcon != null 
            ? GestureDetector(
                onTap: onSuffixIconTap,
                child: Icon(suffixIcon, color: AppColors.primaryBlue),
              )
            : null,
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(text, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
    );
  }
}

class SocialLoginRow extends StatelessWidget {
  final VoidCallback? onGoogleTap;
  final VoidCallback? onFacebookTap;
  final VoidCallback? onAppleTap;

  const SocialLoginRow({
    super.key,
    this.onGoogleTap,
    this.onFacebookTap,
    this.onAppleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialIcon("assets/images/facebook_logo.svg", onTap: onFacebookTap),
        const SizedBox(width: 20),
        _socialIcon("assets/images/google_logo.svg", onTap: onGoogleTap),
        const SizedBox(width: 20),
        _socialIcon("assets/images/apple_logo.svg", onTap: onAppleTap),
      ],
    );
  }

  Widget _socialIcon(String asset, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10), // Optional background/padding
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade100, // Light background for better visibility
        ),
        child: SvgPicture.asset(
          asset,
          width: 30, // Adjust size as needed
          height: 30,
        ),
      ),
    );
  }
}