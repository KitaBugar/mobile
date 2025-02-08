// last_add_widget.dart
import 'package:kitabugar/pages/gym_detail_page.dart';
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:kitabugar/theme/text_styles.dart';
import 'package:flutter/material.dart';

class LastAddWidget extends StatelessWidget {
  final List<dynamic> gyms; // Tambahkan parameter untuk menerima data gym

  const LastAddWidget({Key? key, required this.gyms})
      : super(key: key); // Tambahkan required

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
          // Tampilkan gym berdasarkan data yang diterima
          ...gyms.map((gym) {
            return _buildGymCard(
              context,
              gym['name'],
              gym['address'],
              gym['image'] != null && gym['image'].isNotEmpty
                  ? gym['image'][0]
                      ['image_url'] // Menggunakan URL gambar dari API
                  : 'assets/images/thumbnails/default.png', // Gambar default jika tidak ada
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildGymCard(
      BuildContext context, String name, String location, String assetPath) {
    return InkWell(
      onTap: () {
        // Navigasi ke halaman detail gym
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GymDetailPage(
                gymId: 1,
                gymName: name,
                description: '',
                imageUrl: '',
                operatingHours: '',
                address: ''
                // Tambahkan argumen tambahan sesuai kebutuhan
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
                child: Image.network(
                  assetPath, // Menggunakan URL gambar dari API
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
                  // Tambahkan informasi lainnya sesuai kebutuhan
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
