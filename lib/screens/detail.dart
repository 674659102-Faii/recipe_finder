import 'package:flutter/material.dart';
import 'MealPlanner.dart';

class DetailScreen extends StatelessWidget {
  final String recipeName;
  const DetailScreen({super.key, this.recipeName = 'รายละเอียดสูตรอาหาร'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          recipeName,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipe Image Header
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Icon(
                    Icons.restaurant,
                    size: 64,
                    color: Colors.orange,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Cooking Time & Info
              const Row(
                children: [
                  Icon(Icons.timer, size: 20, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    '10 นาที',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Ingredients Section
              _buildSectionCard(
                title: 'วัตถุดิบ',
                children: const [
                  Text('• วัตถุดิบที่ 1 (ปริมาณตามชอบ)'),
                  Text('• วัตถุดิบที่ 2'),
                  Text('• วัตถุดิบที่ 3'),
                ],
              ),
              const SizedBox(height: 16),
              // Cooking Tools Section
              _buildSectionCard(
                title: 'อุปกรณ์การทำ',
                children: const [
                  Text('• อุปกรณ์ที่ 1'),
                  Text('• อุปกรณ์ที่ 2'),
                ],
              ),
              const SizedBox(height: 16),
              // Tips & Tricks Section
              _buildSectionCard(
                title: 'เคล็ดลับ',
                children: const [
                  Text('• เคล็ดลับความอร่อยและวิธีเตรียมวัตถุดิบให้สดใหม่'),
                ],
              ),
              const SizedBox(height: 16),
              // Nutrition Info Section
              _buildSectionCard(
                title: 'คุณค่าทางโภชนาการ',
                children: const [
                  Text('• พลังงาน: 250 kcal'),
                  Text('• โปรตีน: 15g | คาร์บ: 30g | ไขมัน: 8g'),
                ],
              ),
              const SizedBox(height: 24),
              // Add to Meal Planner Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MealPlannerScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text(
                    'เพิ่มลงในแผนมื้ออาหาร',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}
