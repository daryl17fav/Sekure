import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/notifications_controller.dart';
import '../../../../widgets/core_widgets.dart'; // For SekureAppBar
import '../../../../utils/colors.dart';
import '../../../../composants/notification_composants.dart';

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
          const NotificationSectionHeader(title: "Aujourd'hui"),
          const NotificationCard(
            title: "Titre de la notification",
            description: "Lorem ipsum dolor sit amet consectetur. Aliquet turpis lobortis dolor laoreet nunc ac. Auctor sem lorem felis pulvinar morbi.",
            hasButton: true,
          ),
          const SizedBox(height: 15),
          const NotificationCard(
            title: "Titre de la notification",
            description: "Lorem ipsum dolor sit amet consectetur. Aliquet turpis lobortis dolor laoreet nunc ac. Auctor sem lorem felis pulvinar morbi.",
            hasButton: false,
          ),

          const SizedBox(height: 25),

          // --- Section: Hier ---
          const NotificationSectionHeader(title: "Hier"),
          const NotificationCard(
            title: "Titre de la notification",
            description: "Lorem ipsum dolor sit amet consectetur. Aliquet turpis lobortis dolor laoreet nunc ac. Auctor sem lorem felis pulvinar morbi.",
            hasButton: true,
          ),
          const SizedBox(height: 15),
          const NotificationCard(
            title: "Titre de la notification",
            description: "Lorem ipsum dolor sit amet consectetur. Aliquet turpis lobortis dolor laoreet nunc ac. Auctor sem lorem felis pulvinar morbi.",
            hasButton: false,
          ),

          const SizedBox(height: 25),

          // --- Section: Specific Date ---
          const NotificationSectionHeader(title: "Lundi 23 Décembre 2024"),
          const NotificationCard(
            title: "Titre de la notification",
            description: "Lorem ipsum dolor sit amet consectetur. Aliquet turpis lobortis dolor laoreet nunc ac. Auctor sem lorem felis pulvinar morbi.",
            hasButton: false,
          ),
          
          const SizedBox(height: 30),
        ],
      ),
    );
  }