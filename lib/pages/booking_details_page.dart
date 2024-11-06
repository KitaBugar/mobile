import 'package:kitabugar/components/buttons/custom_button.dart';
import 'package:kitabugar/pages/succes_payment_page.dart';
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class BookingDetailsPage extends StatelessWidget {
  const BookingDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Booking Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Booking Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Cek terlebih dahulu detail bookingnya!',
                style: TextStyle(
                  color: AppPallete.colorTextSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              _buildDetailItem('Nama', 'Christian Weber'),
              _buildDetailItem('Nomor Telepon', '0338161271'),
              _buildDetailItem('Email', 'christian@gmail.com'),
              const SizedBox(height: 24),
              _buildGymPackage(),
              const SizedBox(height: 24),
              _buildDetailItem('Booking ID', 'FIT30596'),
              _buildDetailItem('Subtotal', 'Rp 399.000'),
              _buildDetailItem('PPN 11%', 'Rp 43.890'),
              const SizedBox(height: 16),
              _buildTotalPayment(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButton(context),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppPallete.colorTextSecondary,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGymPackage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE1F2E0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.shopping_cart,
              color: AppPallete.colorWhite,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'The Old House Gym',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Card Paket Level Up',
                style: TextStyle(
                  color: AppPallete.colorTextSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPayment() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFDEF3F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Total Payment',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Rp 442.890',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppPallete.colorPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppPallete.colorWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: CustomElevatedButton(
        buttonText: 'Berlangganan Sekarang',
        navigateTo: const SuccessPaymentPage(
          bookingId: 'FIT30596',
        ),
      ),
    );
  }
}
