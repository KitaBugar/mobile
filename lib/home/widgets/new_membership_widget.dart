// new_membership_widget.dart
import 'package:flutter/material.dart';

class NewMembershipWidget extends StatelessWidget {
  const NewMembershipWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Membership Terbaru',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.cyan.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.card_membership),
              title: const Text(
                'Old House Gym',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Cek detail Member'),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text('Detail'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
