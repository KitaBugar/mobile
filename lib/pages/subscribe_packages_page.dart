import 'package:flutter/material.dart';
import 'package:kitabugar/api/api_service.dart';
import 'package:kitabugar/pages/booking_details_page.dart';
import 'package:kitabugar/pages/xendit_payment_page.dart';
import 'package:intl/intl.dart';
import 'package:kitabugar/theme/text_styles.dart'; // Impor intl

class SubscribePackagePage extends StatefulWidget {
  final int gymId;

  const SubscribePackagePage({Key? key, required this.gymId}) : super(key: key);

  @override
  _SubscribePackagePageState createState() => _SubscribePackagePageState();
}

class _SubscribePackagePageState extends State<SubscribePackagePage> {
  final ApiService apiService = ApiService();
  List<dynamic> membershipOptions = [];
  Map? gym;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMembershipOptions();
  }

  Future<void> _fetchMembershipOptions() async {
    try {
      final data = await apiService.getGymDetails(widget.gymId);
      if (!mounted) return;
      print('Gym details received: $data');

      if (data['items'] != null) {
        gym = data["items"];
        membershipOptions = data['items']['membership_option'] ?? [];
      } else {
        membershipOptions = [];
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching membership options: $e')),
      );
    }
  }

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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: membershipOptions.map((option) {
                  List<String> features = List<String>.from(
                    option['features'].map(
                      (e) => e.toString(),
                    ),
                  );

                  // Format harga
                  String formattedPrice =
                      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ')
                          .format(option['price']);

                  return _buildPackageCard(
                    context: context,
                    option: option,
                    title: option['name'],
                    subtitle: option['description'],
                    price: formattedPrice, // Gunakan harga yang diformat
                    period: '/ 1 Bulan',
                    benefits: features,
                    imagePath: 'assets/images/thumbnails/Regular-plan.png',
                  );
                }).toList(),
              ),
            ),
    );
  }

  Widget _buildPackageCard({
    required Map option,
    required BuildContext context,
    required String title,
    required String subtitle,
    required String price,
    required String period,
    required List<String> benefits,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookingDetailsPage(
              membership: gym!,
              option: option,
            ),
          ),
        );
      },
      child: Card(
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
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.heading2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: TextStyles.body2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: TextStyles.heading5,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    period,
                    style: TextStyles.body2,
                  ),
                  const SizedBox(height: 8),
                  ...benefits.map((benefit) => Text('• $benefit')).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
