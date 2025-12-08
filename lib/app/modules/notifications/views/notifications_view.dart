import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/notifications_controller.dart';
import '../../../../widgets/core_widgets.dart'; // For SekureAppBar
import '../../../../utils/colors.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SekureAppBar(title: "Notifications"),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          // --- Section: Aujourd'hui ---
          _sectionHeader("Aujourd'hui"),
          _buildNotificationCard(
            title: "Titre de la notification",
            description: "Lorem ipsum dolor sit amet consectetur. Aliquet turpis lobortis dolor laoreet nunc ac. Auctor sem lorem felis pulvinar morbi.",
            hasButton: true,
          ),
          const SizedBox(height: 15),
          _buildNotificationCard(
            title: "Titre de la notification",
            description: "Lorem ipsum dolor sit amet consectetur. Aliquet turpis lobortis dolor laoreet nunc ac. Auctor sem lorem felis pulvinar morbi.",
            hasButton: false,
          ),

          const SizedBox(height: 25),

          // --- Section: Hier ---
          _sectionHeader("Hier"),
          _buildNotificationCard(
            title: "Titre de la notification",
            description: "Lorem ipsum dolor sit amet consectetur. Aliquet turpis lobortis dolor laoreet nunc ac. Auctor sem lorem felis pulvinar morbi.",
            hasButton: true,
          ),
          const SizedBox(height: 15),
          _buildNotificationCard(
            title: "Titre de la notification",
            description: "Lorem ipsum dolor sit amet consectetur. Aliquet turpis lobortis dolor laoreet nunc ac. Auctor sem lorem felis pulvinar morbi.",
            hasButton: false,
          ),

          const SizedBox(height: 25),

          // --- Section: Specific Date ---
          _sectionHeader("Lundi 23 Décembre 2024"),
          _buildNotificationCard(
            title: "Titre de la notification",
            description: "Lorem ipsum dolor sit amet consectetur. Aliquet turpis lobortis dolor laoreet nunc ac. Auctor sem lorem felis pulvinar morbi.",
            hasButton: false,
          ),
          
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 5),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.grey[400], // Light grey text for headers
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String description,
    bool hasButton = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F9), // Light blue-grey background
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circular Icon Placeholder
              Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                  color: Color(0xFFAAAAAA), // Medium grey circle
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 15),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF4A4A4A), // Darker grey for readability
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Optional Button
          if (hasButton) ...[
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 60), // Indent to align with text
              child: SizedBox(
                height: 40,
                width: 180, // Fixed width as per design
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Bouton d'action",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}