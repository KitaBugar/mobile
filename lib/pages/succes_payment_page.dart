import 'package:kitabugar/components/buttons/custom_button.dart';
import 'package:kitabugar/pages/home_page.dart';
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SuccessPaymentPage extends StatelessWidget {
  final String bookingId;

  const SuccessPaymentPage({
    Key? key,
    required this.bookingId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Image
              Image.asset(
                'assets/images/Success.png', // Pastikan tambahkan gambar di assets
                width: 315,
                height: 200,
              ),
              const SizedBox(height: 24),

              // Success Title
              const Text(
                'Booking Completed',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppPallete.colorTextPrimary,
                ),
              ),
              const SizedBox(height: 8),

              // Success Message
              const Text(
                'Selamat Transaksi anda berhasil! Cek detailnya dibagian subscribtion.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppPallete.colorTextSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // Booking ID Container
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFFE1F2E0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Booking ID: $bookingId',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Button Lihat Detail
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  onPressed: () async {},
                  buttonText: 'Lihat Detail Langganan',
                  navigateTo: const HomePage(), // Halaman yang dinavigasi
                  textColor: AppPallete.colorWhite, // Opsional: warna teks
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
