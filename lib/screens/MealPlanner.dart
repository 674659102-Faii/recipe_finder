// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'app_bottom_nav.dart';

class MealPlannerScreen extends StatefulWidget {
  const MealPlannerScreen({super.key});

  @override
  State<MealPlannerScreen> createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  int _selectedDay = 28; // Default selected day (e.g. 28)
  String _selectedMonth = 'กันยายน'; // Default selected month

  final List<String> _months = [
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม',
  ];

  // Key: "Month-Day", Value: Map of meal time to recipe name
  final Map<String, Map<String, String>> _mealPlans = {};

  final List<String> _availableRecipes = [
    'ข้าวไก่ย่างซอสเทอริยากิ (20 นาที)',
    'สลัดโรลไก่ย่างกับขนมปังโฮลวีต (15 นาที)',
    'ข้าวผัดกุ้งไข่เยิ้มผักรวม (15 นาที)',
    'ข้าวแซลมอนย่างผักรวม (25 นาที)',
  ];

  void _showMonthPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'เลือกเดือน',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: _months.length,
                  itemBuilder: (context, index) {
                    final month = _months[index];
                    final isSelected = month == _selectedMonth;
                    return ListTile(
                      title: Text(
                        month,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.orange : Colors.black87,
                        ),
                      ),
                      trailing: isSelected ? const Icon(Icons.check, color: Colors.orange) : null,
                      onTap: () {
                        setState(() {
                          _selectedMonth = month;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRecipeSelector(String mealTime) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'เลือกสูตรอาหารสำหรับ$mealTime (วันที่ $_selectedDay $_selectedMonth)',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: _availableRecipes.length,
                  itemBuilder: (context, index) {
                    final recipe = _availableRecipes[index];
                    return ListTile(
                      leading: const Icon(Icons.restaurant, color: Colors.orange),
                      title: Text(recipe),
                      onTap: () {
                        final key = '$_selectedMonth-$_selectedDay';
                        setState(() {
                          if (!_mealPlans.containsKey(key)) {
                            _mealPlans[key] = {};
                          }
                          _mealPlans[key]![mealTime] = recipe;
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('เพิ่ม $recipe ใน$mealTime เรียบร้อย!')),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'วางแผนมื้ออาหาร',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Calendar / Date Grid (Vertical 1 - 31)
              Container(
                padding: const EdgeInsets.all(12),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: _showMonthPicker,
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            child: Row(
                              children: [
                                Text(
                                  '$_selectedMonth 2024',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.arrow_drop_down, color: Colors.orange),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_month, color: Colors.orange),
                          onPressed: _showMonthPicker,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Weekday headers
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ['จ.', 'อ.', 'พ.', 'พฤ.', 'ศ.', 'ส.', 'อา.']
                          .map((day) => Text(
                                day,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                    // Vertical Grid for dates 1 to 31
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: 31,
                      itemBuilder: (context, index) {
                        final dayNum = index + 1;
                        final isSelected = dayNum == _selectedDay;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDay = dayNum;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.orange : Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected ? Colors.orange : Colors.grey.shade200,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$dayNum',
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Planned Meals Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'แผนมื้ออาหาร (วันที่ $_selectedDay $_selectedMonth 2024)',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  children: [
                    _buildMealSlot('มื้อเช้า', Icons.wb_sunny_outlined),
                    _buildMealSlot('มื้อกลางวัน', Icons.lunch_dining),
                    _buildMealSlot('มื้อเย็น', Icons.dinner_dining),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Generate Shopping List Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('สร้างรายการซื้อของสำหรับวันที่ $_selectedDay $_selectedMonth เรียบร้อย!'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: const Text(
                    'สร้างรายการซื้อของ',
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildMealSlot(String mealTime, IconData icon) {
    final key = '$_selectedMonth-$_selectedDay';
    final currentMeal = _mealPlans[key]?[mealTime] ?? 'ยังไม่ได้วางแผนสำหรับวันที่ $_selectedDay $_selectedMonth';
    final hasMeal = _mealPlans[key]?.containsKey(mealTime) ?? false;

    return InkWell(
      onTap: () => _showRecipeSelector(mealTime),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.orange),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mealTime,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    currentMeal,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: hasMeal ? Colors.orange.shade800 : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              hasMeal ? Icons.check_circle : Icons.add_circle_outline,
              color: hasMeal ? Colors.green : Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
