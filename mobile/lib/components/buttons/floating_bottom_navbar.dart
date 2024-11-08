import 'package:kitabugar/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class FloatingBottomNavBar extends StatefulWidget {
  final Function(int) onPageChanged;
  final int currentIndex;

  const FloatingBottomNavBar({
    Key? key,
    required this.onPageChanged,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<FloatingBottomNavBar> createState() => _FloatingBottomNavBarState();
}

class _FloatingBottomNavBarState extends State<FloatingBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(0, Icons.home_outlined, 'Home'),
            _buildNavItem(1, Icons.confirmation_number_outlined, 'Member'),
            _buildNavItem(2, Icons.person_outline, 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = widget.currentIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        horizontal: isSelected ? 30.0 : 24.0,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppPallete.colorPrimary : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: InkWell(
        onTap: () => widget.onPageChanged(index),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
