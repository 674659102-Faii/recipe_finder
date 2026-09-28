// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'Home.dart';
import 'categorier.dart';
import 'Favorites.dart';
import 'MealPlanner.dart';
import 'CommunityRecipes.dart';
import 'Profile.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  const AppBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> navItems = [
      {'icon': Icons.home, 'label': 'หน้าหลัก', 'screen': const HomeScreen()},
      {'icon': Icons.category, 'label': 'หมวดหมู่', 'screen': const CategorierScreen()},
      {'icon': Icons.favorite, 'label': 'โปรด', 'screen': const FavoritesScreen()},
      {'icon': Icons.calendar_today, 'label': 'วางแผน', 'screen': const MealPlannerScreen()},
      {'icon': Icons.people, 'label': 'คอมมูนิตี้', 'screen': const CommunityRecipesScreen()},
      {'icon': Icons.person, 'label': 'โปรไฟล์', 'screen': const ProfileScreen()},
    ];

    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          final item = navItems[index];
          final isSelected = index == currentIndex;
          return InkWell(
            onTap: () {
              if (index == currentIndex) return;
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, a1, a2) => item['screen'] as Widget,
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item['icon'] as IconData,
                    size: 22,
                    color: isSelected ? Colors.purple.shade300 : Colors.grey,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item['label'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.purple.shade300 : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
