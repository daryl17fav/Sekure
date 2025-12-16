import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

/// Full screen loading overlay
/// Use this when you want to block the entire screen with a loading indicator
class LoadingOverlay extends StatelessWidget {
  final String? message;
  
  const LoadingOverlay({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
              ),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(
                  message!,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Inline loading indicator
/// Use this for embedded loading states within a section
class InlineLoader extends StatelessWidget {
  final String? message;
  final double size;
  
  const InlineLoader({
    super.key,
    this.message,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
              strokeWidth: 3,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 12),
            Text(
              message!,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textGrey,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Shimmer loading effect for cards
/// Use this for skeleton loading in lists and grids
class ShimmerCard extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerCard({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  State<ShimmerCard> createState() => _ShimmerCardState();
}

class _ShimmerCardState extends State<ShimmerCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.inputFill,
                Colors.grey[300]!,
                AppColors.inputFill,
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((e) => e.clamp(0.0, 1.0)).toList(),
            ),
          ),
        );
      },
    );
  }
}

/// Grid shimmer loader
/// Use this for grid views while loading data
class GridShimmerLoader extends StatelessWidget {
  final int itemCount;
  final double childAspectRatio;
  
  const GridShimmerLoader({
    super.key,
    this.itemCount = 6,
    this.childAspectRatio = 0.75,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: childAspectRatio,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return ShimmerCard(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
            );
          },
        );
      },
    );
  }
}

/// List shimmer loader
/// Use this for list views while loading data
class ListShimmerLoader extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  
  const ListShimmerLoader({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 100,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: ShimmerCard(
            width: double.infinity,
            height: itemHeight,
          ),
        );
      },
    );
  }
}

/// Small spinner for buttons
/// Use this for inline button loading states
class ButtonSpinner extends StatelessWidget {
  final Color color;
  final double size;
  
  const ButtonSpinner({
    super.key,
    this.color = Colors.white,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: 2,
      ),
    );
  }
}
