import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int count;
  final int selectedIndex;

  const PageIndicator({
    super.key,
    required this.count,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isSelected = index == selectedIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isSelected ? 12 : 8,
          height: isSelected ? 12 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Colors.white : Colors.white38,
          ),
        );
      }),
    );
  }
}
