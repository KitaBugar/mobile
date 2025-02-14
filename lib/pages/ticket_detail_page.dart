import 'package:kitabugar/components/buttons/custom_button.dart';
import 'package:kitabugar/pages/booking_details_page.dart';
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';

class TicketDetailPage extends StatelessWidget {
  final bool isExpired;
  final Map<String, dynamic> membership;

  const TicketDetailPage({
    super.key,
    this.membership = const {},
    this.isExpired = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.colorBackground,
      appBar: AppBar(
        backgroundColor: AppPallete.colorBackground,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: AppPallete.colorTextPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail Tiket Member',
          style: TextStyle(color: AppPallete.colorTextPrimary),
        ),
        actions: const [
          IconButton(
            icon: Icon(Icons.more_vert, color: AppPallete.colorTextPrimary),
            onPressed: null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TicketWidget(
              width: double.infinity,
              height: 480,
              isCornerRounded: true,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo Container
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        'assets/images/thumbnails/Regular.png', // Pastikan path sesuai dengan struktur project Anda
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Gym Name and Location
                  Text(
                    membership["gym"] != null ? membership["gym"]["name"] : "-",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppPallete.colorPrimary,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        membership["gym"]["address"] ?? "-",
                        style: TextStyle(
                          color: AppPallete.colorPrimary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Booking Details
                  _buildDetailRow('Booking ID', membership["card_number"]),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                      'Started At', membership["start_date_format"]),
                  const SizedBox(height: 12),
                  _buildDetailRow('Ended At', membership["end_date_format"]),
                  const SizedBox(height: 12),
                  _buildDetailRow('Total Payment',
                      'Rp ${membership["membership_option"]["price"]}'),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(color: AppPallete.colorTextSecondary),
                  ),

                  // Package Details
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rp. ${membership["membership_option"]["price"]}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "/ 1 Bulan",
                            style: TextStyle(
                              color: AppPallete.colorTextSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      if (membership["is_expired"] == true)
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingDetailsPage(
                                  membership: membership,
                                ), // Create your next page
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Expired',
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
            if (membership["is_expired"] == false) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomElevatedButton(
                  onPressed: () async {},
                  buttonText: 'Perpanjang Membeship',
                  navigateTo: BookingDetailsPage(
                    membership: membership,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppPallete.colorTextSecondary,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppPallete.colorTextSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
