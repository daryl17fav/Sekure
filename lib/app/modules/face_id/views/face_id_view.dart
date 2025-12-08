import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/face_id_controller.dart';
import '../../../../widgets/common_widgets.dart';

class FaceIdView extends GetView<FaceIdController> {
  const FaceIdView({super.key});

  @override
  Widget build(BuildContext context) {
    return SekureBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          const SekureLogo(size: 50),
          const Spacer(),
          // This page is unique, the white card is floating or full bottom
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Text("Face ID", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("Autorisez l'accès à Face ID pour une\nconnexion plus sécurisé et rapide.", textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 14)),
                const SizedBox(height: 30),
                Icon(Icons.face_retouching_natural, size: 80, color: Colors.black), // Use SVG if available
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}