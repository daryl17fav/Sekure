import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/order_details_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../utils/colors.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SekureAppBar(title: "Un bon de commande"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Header Info
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: const Color(0xFFEBEBF1), borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Client", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  Text("Nom du client", style: GoogleFonts.poppins()),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // The Blue Ticket
            TicketWidget(
              child: Column(
                children: [
                  // Product Image
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(image: NetworkImage('https://i.pravatar.cc/150?img=33'), fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Dashed Line
                  Row(
                    children: List.generate(15, (index) => Expanded(
                      child: Container(
                        height: 2,
                        color: Colors.white.withOpacity(0.5),
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                      ),
                    )),
                  ),
                  const SizedBox(height: 15),

                  Text("12.000 Fcfa", style: GoogleFonts.poppins(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text(
              "Ce bon de commande vous est adressé par un client. Veuillez lui donner une réponse...",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 13),
            ),
            const SizedBox(height: 20),

            // Action Buttons
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () {},
                child: Text("Accepter la commande", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {},
              child: Text("Refuser la commande", style: GoogleFonts.poppins(color: AppColors.primaryRed, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}