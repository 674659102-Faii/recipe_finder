// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'app_bottom_nav.dart';

class CategorierScreen extends StatelessWidget {
  const CategorierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'name': 'อาหารเพื่อสุขภาพ', 'icon': Icons.favorite, 'color': Colors.green},
      {'name': 'อาหารจานด่วน', 'icon': Icons.flash_on, 'color': Colors.amber},
      {'name': 'อาหารไทย', 'icon': Icons.restaurant_menu, 'color': Colors.orange},
      {'name': 'อาหารนานาชาติ', 'icon': Icons.public, 'color': Colors.blue},
      {'name': 'อาหารมังสวิรัติ', 'icon': Icons.eco, 'color': Colors.lightGreen},
      {'name': 'ของหวาน', 'icon': Icons.cake, 'color': Colors.pink},
      {'name': 'อาหารเช้า', 'icon': Icons.free_breakfast, 'color': Colors.deepOrange},
      {'name': 'ซุป', 'icon': Icons.soup_kitchen, 'color': Colors.brown},
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'หมวดหมู่',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.3,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];
              return InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('เลือกหมวดหมู่: ${cat['name']}')),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: (cat['color'] as Color).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          cat['icon'] as IconData,
                          size: 32,
                          color: cat['color'] as Color,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        cat['name'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
    );
  }
}
