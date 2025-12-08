import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/notification_detail_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../utils/colors.dart';

class NotificationDetailView extends GetView<NotificationDetailController> {
  const NotificationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SekureAppBar(title: "Détail de la notification"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Lundi 23 Décembre 2024", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 10),
            Text("Titre de la notification", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            
            // Description Text
            Text(
              "Lorem ipsum dolor sit amet consectetur. Eleifend nibh consectetur sed varius pharetra pharetra nam. Augue enim ipsum massa sed adipiscing. Amet volutpat hendrerit aliquet vel iaculis tellus congue faucibus ipsum. Pulvinar at aliquam morbi urna amet volutpat tristique. Quam quis.",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87, height: 1.6),
            ),
            const SizedBox(height: 30),
            
            Center(child: Text("Veuillez scanner le code QR", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey))),
            const SizedBox(height: 15),

            // QR Code Placeholder
            Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            
            const SizedBox(height: 15),
            Center(child: Text("ou cliquez sur ce lien", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey))),
            const SizedBox(height: 5),
            
            // Link
            Center(
              child: Text(
                "https://loremipsumdolorsitamet.com",
                style: GoogleFonts.poppins(fontSize: 13, color: AppColors.primaryBlue, decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
              ),
            ),
            
            const SizedBox(height: 50),

            // Action Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {},
                child: Text("Bouton d'action", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}