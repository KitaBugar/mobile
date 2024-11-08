import 'package:kitabugar/pages/booking_details_page.dart';
import 'package:kitabugar/pages/xendit_payment_page.dart';
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SubscribePackagePage extends StatelessWidget {
  const SubscribePackagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Subscribe Package'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => XenditPaymentPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildPackageCard(
              context: context,
              title: 'Card Paket Level Up',
              subtitle: 'Enjoy all subscribe package benefits',
              price: 'Rp. 199.000',
              period: '/ 1 Bulan',
              benefits: [
                'Akses bebas ke area gym',
                'Kelas-kelas pemula (Yoga, Pilates, Cardio)',
                'Konsultasi dengan pelatih',
                'Dapatkan Diskon',
              ],
              imagePath:
                  'assets/images/thumbnails/Regular-plan.png', // Add your image asset path
            ),
            const SizedBox(height: 16),
            _buildPackageCard(
              context: context,
              title: 'Card Paket Next Level',
              subtitle: 'Enjoy all subscribe package benefits',
              price: 'Rp. 299.000',
              period: '/ 1 Bulan',
              benefits: [
                'Semua benefit Level Up',
                'Akses ke kelas-kelas HIIT, CrossFit',
                'Penggunaan fasilitas sauna dan kolam renang',
                'Diskon untuk produk nutrisi',
              ],
              imagePath:
                  'assets/images/thumbnails/super-plan.png', // Add your image asset path
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String price,
    required String period,
    required List<String> benefits,
    required String imagePath,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                imagePath,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppPallete.colorTextSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                ...benefits.map((benefit) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle,
                              color: AppPallete.colorPrimary, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              benefit,
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          period,
                          style: TextStyle(
                            color: AppPallete.colorTextSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BookingDetailsPage(), // Create your next page
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppPallete.colorPrimary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Langganan',
                        style: TextStyle(
                          color: AppPallete.colorWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
