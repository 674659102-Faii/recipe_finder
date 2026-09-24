// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'Home.dart';
import 'categorier.dart';
import 'Favorites.dart';
import 'MealPlanner.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  const AppBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == currentIndex) return;
        Widget targetScreen;
        switch (index) {
          case 0:
            targetScreen = const HomeScreen();
            break;
          case 1:
            targetScreen = const CategorierScreen();
            break;
          case 2:
            targetScreen = const FavoritesScreen();
            break;
          case 3:
            targetScreen = const MealPlannerScreen();
            break;
          default:
            return;
        }
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => targetScreen,
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'หน้าหลัก',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'หมวดหมู่',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'รายการโปรด',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'วางแผนมื้ออาหาร',
        ),
      ],
    );
  }
}
