import 'package:kitabugar/theme/app_pallete.dart';
import 'package:kitabugar/theme/text_styles.dart';
import 'package:flutter/material.dart';

// Komponen Button Kustom
class CustomElevatedButton extends StatelessWidget {
  final String buttonText; // Teks yang ditampilkan pada tombol
  final Widget? navigateTo; // Halaman yang akan dinavigasi
  final Color? backgroundColor; // Warna latar belakang tombol (opsional)
  final Color? textColor; // Warna teks (opsional)

  const CustomElevatedButton({
    Key? key,
    required this.buttonText,
    this.navigateTo,
    this.backgroundColor,
    this.textColor,
    required Future<Null> Function() onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Navigasi ke halaman yang ditentukan
          if (navigateTo != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => navigateTo!),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppPallete.colorPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyles.body1.copyWith(
            color: AppPallete.colorWhite,
          ),
        ),
      ),
    );
  }
}
