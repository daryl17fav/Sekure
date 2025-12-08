import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String? status; // 'En attente', 'Payées', 'Expirées', or null for checkmarks
  final bool isNegative; // For red price
  final bool showCheck; // For the green check icon
  final bool showCross; // For the red cross icon
  final VoidCallback? onTap;

  const ItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    this.status,
    this.isNegative = false,
    this.showCheck = false,
    this.showCross = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = AppColors.pendingOrange;
    if (status == 'Payées') statusColor = AppColors.successGreen;
    if (status == 'Expirées') statusColor = AppColors.expiredRed;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: NetworkImage('https://i.pravatar.cc/150?img=33'), // Placeholder product
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15),
            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            // Price & Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isNegative ? AppColors.primaryRed : Colors.black,
                  ),
                ),
                if (status != null)
                  Text(status!, style: GoogleFonts.poppins(fontSize: 10, color: statusColor, fontWeight: FontWeight.bold)),
                if (showCheck)
                  const Icon(Icons.check_circle, color: AppColors.successGreen, size: 16),
                if (showCross)
                  const Icon(Icons.cancel, color: AppColors.primaryRed, size: 16),
                if (status == null && !showCheck && !showCross)
                   const Icon(Icons.access_time_filled, color: AppColors.pendingOrange, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
