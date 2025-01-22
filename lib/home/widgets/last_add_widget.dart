// last_add_widget.dart
import 'package:kitabugar/pages/gym_detail_page.dart';
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:kitabugar/theme/text_styles.dart';
import 'package:flutter/material.dart';  
// Pastikan untuk mengimpor halaman GymDetailsPage

class LastAddWidget extends StatelessWidget {
  const LastAddWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Terakhir Ditambahkan',
                style: TextStyles.body1.copyWith(
                  color: AppPallete.colorTextPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildGymCard(
            context, // Tambahkan context di sini
            'The Old House Gym',
            'Cirebon',
            'assets/images/thumbnails/th1.png',
          ),
          const SizedBox(height: 16),
          _buildGymCard(
            context, // Tambahkan context di sini
            'Iron Factory Cirebon',
            'Cirebon',
            'assets/images/thumbnails/th2.png',
          ),
        ],
      ),
    );
  }

  // Tambahkan parameter context agar dapat digunakan untuk navigasi
  Widget _buildGymCard(
      BuildContext context, String name, String location, String assetPath) {
    return InkWell(
      onTap: () {
        // Navigasi ke halaman detail gym
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GymDetailPage(
                // gymName: name, // Bisa tambahkan argumen tambahan sesuai kebutuhan
                ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  assetPath, // Menggunakan Image.asset untuk gambar lokal
                  height: 200,
                  width: double.infinity,
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
                    name,
                    style: TextStyles.body2.copyWith(
                      color: AppPallete.colorTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: TextStyles.body3
                            .copyWith(color: AppPallete.colorTextSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fasilitas',
                        style: TextStyles.body4
                            .copyWith(color: AppPallete.colorTextPrimary),
                      ),
                      Text('Lihat semua',
                          style: TextStyles.body5
                              .copyWith(color: AppPallete.colorPrimary)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: List.generate(
                      4,
                      (index) => Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppPallete.colorPrimary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.hot_tub,
                                color: AppPallete.colorWhite,
                                size: 20,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Sauna',
                              style: TextStyles.body4
                                  .copyWith(color: AppPallete.colorTextPrimary),
                            ),
                            Text(
                              'Relax Body',
                              style: TextStyles.body5.copyWith(
                                  color: AppPallete.colorTextSecondary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: AppPallete.colorPrimary,
                        child: Icon(Icons.access_time,
                            color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Opening',
                            style: TextStyles.body4
                                .copyWith(color: AppPallete.colorTextPrimary),
                          ),
                          Text(
                            '08:00 - 22:00',
                            style: TextStyles.body5
                                .copyWith(color: AppPallete.colorTextSecondary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
