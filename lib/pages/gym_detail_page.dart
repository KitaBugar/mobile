// import 'package:kitabugar/components/buttons/custom_button.dart';
import 'package:kitabugar/pages/subscribe_packages_page.dart';
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:kitabugar/theme/text_styles.dart';

class GymDetailPage extends StatefulWidget {
  final String gymName;
  final String description;
  final String imageUrl;
  final String operatingHours;
  final String address;
  final int gymId;

  const GymDetailPage({
    Key? key,
    required this.gymName,
    required this.description,
    required this.imageUrl,
    required this.operatingHours,
    required this.address,
    required this.gymId,
  }) : super(key: key);

  @override
  State<GymDetailPage> createState() => _GymDetailPageState();
}

class _GymDetailPageState extends State<GymDetailPage> {
  int _currentIndex = 0;

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
                        options: CarouselOptions(
                          height: double.infinity,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: [widget.imageUrl].map((image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Image.network(
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
                          dotsCount: 1, // Hanya satu gambar
                          position: _currentIndex
                              .toDouble(), // Pastikan ini adalah int
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
                      Text(widget.gymName,
                          style: TextStyles.body1
                              .copyWith(color: AppPallete.colorTextPrimary)),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 16, color: AppPallete.colorPrimary),
                          SizedBox(width: 4),
                          Text(widget.address,
                              style: TextStyles.body3
                                  .copyWith(color: AppPallete.colorPrimary)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text('Fasilitas Tersedia',
                          style: TextStyles.body4
                              .copyWith(color: AppPallete.colorTextPrimary)),
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
                      Text(
                        widget.description,
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      _buildInfoSection(
                        icon: Icons.access_time,
                        title: 'Opening',
                        subtitle: widget.operatingHours,
                      ),
                      const SizedBox(height: 16),
                      // Add more info sections as needed
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
              child: ElevatedButton(
                onPressed: () {
                  print('Gym ID: ${widget.gymId}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubscribePackagePage(
                          gymId: widget.gymId), // Gunakan widget.gymId
                    ),
                  );
                },
                child: const Text('Pilih Paket Langganan'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilities() {
    // Replace with actual facilities data if available
    final facilities = ['Sauna', 'Gym', 'Swimming Pool', 'Yoga'];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: facilities.length,
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
            Text(facilities[index],
                style: TextStyles.body4
                    .copyWith(color: AppPallete.colorTextPrimary)),
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
