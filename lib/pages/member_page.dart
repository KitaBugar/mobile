import 'package:kitabugar/api/api_service.dart';
import 'package:kitabugar/pages/home_page.dart';
import 'package:kitabugar/pages/ticket_detail_page.dart';
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:kitabugar/components/buttons/floating_bottom_navbar.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 1; // 1 untuk Member tab di bottom navigation
  List membership = [];

  @override
  void initState() {
    super.initState();
    init();
    _tabController = TabController(length: 1, vsync: this);
  }

  Future<void> init() async {
    membership = await ApiService().getMembers();
    print(membership);
    setState(() {});
  }

  // Fungsi untuk menangani navigasi halaman
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Arahkan ke halaman sesuai dengan indeks
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/member');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
      // Tambahkan kasus lain untuk halaman lain jika ada
    }
  }

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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
        ),
        title: const Text(
          'Tiket Membership',
          style: TextStyle(color: AppPallete.colorTextPrimary),
        ),
        actions: const [
          IconButton(
            icon: Icon(Icons.more_vert, color: AppPallete.colorTextPrimary),
            onPressed: null,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppPallete.colorTextPrimary,
          unselectedLabelColor: AppPallete.colorTextSecondary,
          indicatorColor: AppPallete.colorPrimary,
          tabs: const [
            Tab(text: 'Member Aktif'), // Hanya satu tab
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Member Aktif Tab
          _buildMemberList(),
        ],
      ),
      bottomNavigationBar: FloatingBottomNavBar(
        currentIndex: _currentIndex,
        onPageChanged: _onPageChanged,
      ),
    );
  }

  Widget _buildMemberList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: membership.length,
      itemBuilder: (context, index) {
        var row = membership[index];
        return _buildMemberCard(
          gymName: row["gym"] != null ? row["gym"]["name"] : "-",
          location: row["gym"]["address"] ?? "-",
          date: "${row["start_date_format"]}-${row["end_date_format"]}",
          ticketId: row["card_number"],
          ticketIdColor: AppPallete.colorPrimary,
          membership: row,
        );
      },
    );
  }

  Widget _buildMemberCard({
    required String gymName,
    required String location,
    required String date,
    required String? ticketId,
    required Color ticketIdColor,
    Map<String, dynamic> membership = const {},
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to the TicketDetailPage and pass the ticket details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TicketDetailPage(
              membership: membership,
              option: membership["membership_option"],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppPallete.colorWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                gymName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 16,
                    color: AppPallete.colorPrimary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    location,
                    style: TextStyle(
                      color: AppPallete.colorTextSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: AppPallete.colorTextSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        date,
                        style: TextStyle(
                          color: AppPallete.colorTextSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  if (ticketId != "")
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: ticketIdColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.confirmation_number_outlined,
                            size: 16,
                            color: AppPallete.colorPrimary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            ticketId ?? "",
                            style: TextStyle(
                              color: ticketIdColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
