import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Import file_picker
import 'package:kitabugar/api/api_service.dart'; // Pastikan Anda memiliki ApiService
import 'package:kitabugar/components/buttons/custom_button.dart'; // Pastikan file ini ada
import 'package:kitabugar/pages/succes_payment_page.dart';
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:kitabugar/theme/text_styles.dart';
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler
import 'package:flutter/services.dart'; // Import untuk Clipboard

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({Key? key}) : super(key: key);

  @override
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  final ApiService apiService = ApiService(); // Inisialisasi ApiService
  String? uploadedFileName;
  String? uploadedFilePath;

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
                  _buildGymPackage(),
                  const SizedBox(height: 24),
                  _buildDashedLine(),
                  _buildTotalPayment(),
                  const SizedBox(height: 24),
                  _buildBankTransferDetails(), // Tambahkan detail transfer bank
                  const SizedBox(height: 24),
                  _buildDashedLine(),
                  _buildFileUpload(),
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

  Widget _buildBankTransferDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE1F2E0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transfer Bank',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Bank: BCA',
            style: TextStyle(fontSize: 14),
          ),
          const Text(
            'Nomor Rekening: 1234567890',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(const ClipboardData(text: '1234567890'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nomor rekening disalin!')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFileUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload File',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            // Meminta izin untuk akses penyimpanan
            var status = await Permission.storage.status;
            if (!status.isGranted) {
              await Permission.storage.request();
            }

            // Menggunakan file picker untuk memilih file
            FilePickerResult? result = await FilePicker.platform.pickFiles();

            if (result != null) {
              setState(() {
                uploadedFileName = result.files.single.name;
                uploadedFilePath = result.files.single.path; // Simpan path file
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE1F2E0),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green),
            ),
            child: Center(
              child: Text(
                uploadedFileName ?? 'Tap to upload file',
                style: TextStyle(
                  color: uploadedFileName != null ? Colors.black : Colors.grey,
                ),
              ),
            ),
          ),
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
        buttonText: 'Berlangganan Sekarang',
        onPressed: () async {
          // Kumpulkan data yang diperlukan untuk dikirim
          Map<String, dynamic> membershipData = {
            'total': 442890,
            'uploadedFile':
                uploadedFileName, // Tambahkan nama file yang di-upload
            // Tambahkan data lain yang diperlukan sesuai dengan API
          };

          try {
            // Jika Anda perlu meng-upload file, Anda bisa menggunakan metode upload di ApiService
            if (uploadedFilePath != null) {
              await apiService.uploadFile(
                  uploadedFilePath!); // Ganti dengan metode upload yang sesuai
            }
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
        navigateTo: const SizedBox(),
      ),
    );
  }
}
