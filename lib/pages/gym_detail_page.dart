// gym_detail_page.dart
import 'package:kitabugar/components/buttons/custom_button.dart';
import 'package:kitabugar/pages/subscribe_packages_page.dart';
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class GymDetailPage extends StatefulWidget {
  const GymDetailPage({Key? key}) : super(key: key);

  @override
  State<GymDetailPage> createState() => _GymDetailPageState();
}

class _GymDetailPageState extends State<GymDetailPage> {
  // final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;

  final List<String> gymImages = [
    'assets/images/thumbnails/th1.png',
    'assets/images/thumbnails/th2.png',
    'assets/images/thumbnails/th3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          CustomScrollView(
            slivers: [
              // App Bar with Carousel
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      CarouselSlider(
                        // carouselController: _carouselController,
                        options: CarouselOptions(
                          height: double.infinity,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: gymImages.map((image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Image.asset(
                                image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              );
                            },
                          );
                        }).toList(),
                      ),
                      // Dots Indicator
                      Positioned(
                        bottom: 16,
                        left: 0,
                        right: 0,
                        child: DotsIndicator(
                          dotsCount: gymImages.length,
                          position: _currentIndex,
                          decorator: DotsDecorator(
                            color: AppPallete.colorWhite,
                            activeColor: AppPallete.colorPrimary,
                            size: const Size.square(8.0),
                            activeSize: const Size(20.0, 8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'The Old House Gym',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.location_on,
                              size: 16, color: AppPallete.colorPrimary),
                          SizedBox(width: 4),
                          Text(
                            'Cirebon',
                            style: TextStyle(color: AppPallete.colorPrimary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Fasilitas Tersedia',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildFacilities(),
                      const SizedBox(height: 24),
                      const Text(
                        'Deskripsi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Largest gym in Indonesia, top-tier facilities, premiu kjdjhdjhdasjdf kjdsfjhsdjfhsdjkfjhsdjhfjsdjds jkdsfmskdfjsdf fjsdfjsdfsmenities, and nationwide access to all gym location',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      _buildInfoSection(
                        icon: Icons.access_time,
                        title: 'Opening',
                        subtitle: '08:00 - 22:00',
                      ),
                      const SizedBox(height: 16),
                      _buildInfoSection(
                        icon: Icons.person,
                        title: 'Lili Marlini',
                        subtitle: '083-834-767-667',
                      ),
                      const SizedBox(height: 16),
                      _buildInfoSection(
                        icon: Icons.location_on,
                        title: 'Alamat Lengkap',
                        subtitle:
                            'Jalan Cihampelas Walk No. 123, Bandung 40114, Indonesia.',
                      ),
                      // Add padding at bottom for the fixed button
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Fixed Bottom Button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: CustomElevatedButton(
                buttonText: 'Berlangganan Sekarang',
                navigateTo:
                    const SubscribePackagePage(), // Halaman yang dinavigasi
                textColor: Colors.white, // Opsional: warna teks
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilities() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppPallete.colorPrimary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.hot_tub,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Sauna',
              style: TextStyle(fontSize: 12),
            ),
            const Text(
              'Relax Body',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppPallete.colorPrimary.withOpacity(0.1),
          child: Icon(icon, color: AppPallete.colorPrimary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
