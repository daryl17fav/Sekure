import 'package:flutter/material.dart';
import '../utils/colors.dart';

class TicketWidget extends StatelessWidget {
  final Widget child;
  const TicketWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.addOval(Rect.fromCircle(center: Offset(0, size.height / 1.5), radius: 10)); // Left notch
    path.addOval(Rect.fromCircle(center: Offset(size.width, size.height / 1.5), radius: 10)); // Right notch
    path.fillType = PathFillType.evenOdd;
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
