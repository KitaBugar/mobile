import 'package:flutter/material.dart';
import 'package:kitabugar/api/api_service.dart'; // Pastikan Anda memiliki ApiService
import 'package:kitabugar/components/buttons/custom_button.dart'; // Pastikan file ini ada
import 'package:kitabugar/pages/succes_payment_page.dart';
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:kitabugar/theme/text_styles.dart';
import 'package:image_picker/image_picker.dart'; // Untuk memilih gambar

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({Key? key}) : super(key: key);

  @override
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  final ApiService apiService = ApiService(); // Inisialisasi ApiService
  XFile? _image; // Untuk menyimpan gambar bukti transfer

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Booking Details',
                      style: TextStyles.heading1
                          .copyWith(color: AppPallete.colorTextPrimary)),
                  const Text(
                    'Cek terlebih dahulu detail bookingnya!',
                    style: TextStyle(
                      color: AppPallete.colorTextSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildDashedLine(),
                  _buildDetailItem('Nama', 'Christian Weber'),
                  _buildDetailItem('Nomor Telepon', '0338161271'),
                  _buildDetailItem('Email', 'christian@gmail.com'),
                  _buildDashedLine(),
                  const SizedBox(height: 24),
                  _buildGymPackage(),
                  const SizedBox(height: 24),
                  _buildDashedLine(),
                  _buildDetailItem('Booking ID', 'FIT30596'),
                  _buildDetailItem('Subtotal', 'Rp 399.000'),
                  _buildDetailItem('PPN 11%', 'Rp 43.890'),
                  const SizedBox(height: 16),
                  _buildTotalPayment(),
                  const SizedBox(height: 24),
                  _buildDashedLine(),
                  _buildBankInfo(), // Menambahkan informasi rekening bank
                  const SizedBox(height: 16),
                  _buildUploadButton(), // Menambahkan tombol upload bukti transfer
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButton(context),
    );
  }

  Widget _buildDashedLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Row(
            children: List.generate(
              (constraints.maxWidth / 10).floor(),
              (index) => const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 1,
                  ),
                ),
              ),
            ),
          );
        },
      ),
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
        color: const Color(0xFFE1F2E0),
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
        color: const Color(0xFFDEF3F9),
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

  Widget _buildBankInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi Rekening Bank',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _buildDetailItem('Bank', 'Bank Mandiri'),
        _buildDetailItem('Nomor Rekening', '123-456-7890'),
        _buildDetailItem('Atas Nama', 'Christian Weber'),
      ],
    );
  }

  Widget _buildUploadButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Bukti Transfer',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            final ImagePicker picker = ImagePicker();
            _image = await picker.pickImage(source: ImageSource.gallery);
            // Lakukan sesuatu dengan gambar yang diambil
            if (_image != null) {
              // Misalnya, simpan gambar atau tampilkan di UI
              print('Image selected: ${_image!.path}');
            }
          },
          child: const Text('Pilih Gambar'),
        ),
      ],
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
        navigateTo: const SizedBox(),
        buttonText: 'Berlangganan Sekarang',
        onPressed: () async {
          // Kumpulkan data yang diperlukan untuk dikirim
          Map<String, dynamic> membershipData = {
            'name': 'Christian Weber',
            'phone': '0338161271',
            'email': 'christian@gmail.com',
            'bookingId': 'FIT30596',
            'subtotal': 399000,
            'tax': 43890,
            'total': 442890,
            // Tambahkan data lain yang diperlukan sesuai dengan API
          };

          try {
            await apiService.subscribeMembership(membershipData);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SuccessPaymentPage(
                  bookingId: 'FIT30596',
                ),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $e')),
            );
          }
        },
      ),
    );
  }
}
