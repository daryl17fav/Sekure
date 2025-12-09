import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

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
  const SocialLoginRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialIcon(Icons.facebook, Colors.blue),
        const SizedBox(width: 20),
        _socialIcon(Icons.g_mobiledata, Colors.red, size: 35),  
        _socialIcon(Icons.apple, Colors.black),
      ],
    );
  }

  Widget _socialIcon(IconData icon, Color color, {double size = 30}) {
    return Icon(icon, color: color, size: size);
  }
}