import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/order_tracking_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../utils/colors.dart';

class OrderTrackingView extends GetView<OrderTrackingController> {
  const OrderTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SekureAppBar(title: "Commande n°165TYFHJG"),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Articles & Details (Same as before) ---
                  _sectionTitle("Articles"),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.inputFill, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Container(
                          width: 50, height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(image: NetworkImage('https://i.pravatar.cc/150?img=33'), fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nom de l'article", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
                              Text("Nom du client", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                        Text("12K Fcfa", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  _sectionTitle("Détails de la transaction"),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: AppColors.inputFill, borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        _detailRow("Date", "Mardi 17 Septembre 2025"),
                        const SizedBox(height: 10),
                        _detailRow("Transaction ID", "#678YUIHFGCJ876TY"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _sectionTitle("Livraison"),
                      Text("En cours", style: GoogleFonts.poppins(color: const Color(0xFFE67E22), fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.inputFill, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.map_outlined, color: Colors.green),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Adresse de livraison", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13)),
                              Text("22 Rue du Chinks, Malibu, ETAT", style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87)),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Timeline (Updated State) ---
                  _sectionTitle("Suivi de commande"),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    decoration: BoxDecoration(color: AppColors.inputFill, borderRadius: BorderRadius.circular(12)),
                    child: Stack(
                      children: [
                        Positioned(left: 6, top: 0, bottom: 0, child: Container(width: 2, color: Colors.white)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Previous step (Inactive now)
                            _buildTimelineStep(
                              title: "Payée",
                              description: "Paiement effectué avec succès...",
                              isActive: false, 
                            ),
                            // CURRENT STEP (Active)
                            _buildTimelineStep(
                              title: "Livraison",
                              description: "Vous avez commencé la livraison de la\ncommande",
                              isActive: true, // Blue Dot Here
                            ),
                            // Next Step
                             _buildTimelineStep(
                              title: "Validation",
                              description: "Vous avez marqué comme livrée la\ncommande. Veuillez patienter la\nvalidation...",
                              isActive: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          // --- GREEN BUTTON ---
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF14C61F), // Explicit Bright Green
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => _showDeliveryConfirmDialog(context),
                child: Text(
                  "Commande livrée",
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // --- THE DIALOG (Frame 66) ---
  void _showDeliveryConfirmDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Livraison",
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                  children: [
                    const TextSpan(text: "Vous êtes sur le point de déclarer cette\ncommande "),
                    TextSpan(text: "livrée", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    const TextSpan(text: ". Êtes-vous sûr de\nvouloir poursuivre cette action ?"),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // NON Button (Red)
                  SizedBox(
                    width: 120,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryRed,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      onPressed: () => Get.back(),
                      child: Text("Non", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // OUI Button (Text)
                  TextButton(
                    onPressed: () {
                      Get.back();
                      // Next State Logic
                    },
                    child: Text(
                      "Oui",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: AppColors.primaryBlue, fontSize: 16),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // --- Helpers ---
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 5.0),
      child: Text(title, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13)),
        Text(value, style: GoogleFonts.poppins(fontSize: 13)),
      ],
    );
  }

  Widget _buildTimelineStep({required String title, required String description, bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 15, height: 20,
            child: isActive
                ? Center(child: Container(width: 14, height: 14, decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle)))
                : Container(),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14, color: isActive ? Colors.black : Colors.grey[400])),
                const SizedBox(height: 4),
                Text(description, style: GoogleFonts.poppins(fontSize: 12, color: isActive ? Colors.black87 : Colors.grey[400], height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}