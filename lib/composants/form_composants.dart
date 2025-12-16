import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

/// File Upload Button Component
/// Button with file selection display
class FileUploadButton extends StatelessWidget {
  final String? selectedFileName;
  final VoidCallback onTap;
  final String buttonText;
  final String placeholderText;

  const FileUploadButton({
    super.key,
    required this.selectedFileName,
    required this.onTap,
    this.buttonText = "Ajouter un fichier",
    this.placeholderText = "Aucun fichier sélectionné",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.buyerBlue,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Text(
                buttonText,
                style: GoogleFonts.poppins(
                  color: AppColors.primaryBlue,
                  fontSize: 12
                )
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              selectedFileName ?? placeholderText,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: selectedFileName != null 
                  ? AppColors.primaryBlue 
                  : AppColors.textDark,
                fontWeight: selectedFileName != null 
                  ? FontWeight.w600 
                  : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/// Image Upload Button Component
/// Button for image selection with filename display
class ImageUploadButton extends StatelessWidget {
  final String? selectedImageName;
  final VoidCallback onTap;
  final String buttonText;
  final String placeholderText;

  const ImageUploadButton({
    super.key,
    required this.selectedImageName,
    required this.onTap,
    this.buttonText = "Ajouter une image",
    this.placeholderText = "Aucune image sélectionnée",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFDDE1EF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              buttonText,
              style: GoogleFonts.poppins(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          selectedImageName ?? placeholderText,
          style: GoogleFonts.poppins(fontSize: 11),
        ),
      ],
    );
  }
}

/// Vendor Picker Field Component
/// Dropdown field with modal bottom sheet for vendor selection
class VendorPickerField extends StatelessWidget {
  final String? selectedVendor;
  final List<String> vendors;
  final Function(String) onVendorSelected;
  final String hint;

  const VendorPickerField({
    super.key,
    required this.selectedVendor,
    required this.vendors,
    required this.onVendorSelected,
    this.hint = "Vendeur*",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showVendorPicker(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 55,
        decoration: BoxDecoration(
          color: AppColors.inputFill,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedVendor ?? hint,
              style: GoogleFonts.poppins(
                color: selectedVendor != null
                    ? Colors.black
                    : Colors.grey[400],
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: AppColors.primaryBlue),
          ],
        ),
      ),
    );
  }

  void _showVendorPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Sélectionner un vendeur",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ...vendors.map((vendor) {
                return ListTile(
                  title: Text(vendor, style: GoogleFonts.poppins()),
                  onTap: () {
                    onVendorSelected(vendor);
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

/// Form Container Component
/// White container wrapper for forms
class FormContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const FormContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: child,
    );
  }
}
