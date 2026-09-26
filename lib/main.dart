import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenseManagerApp());
}

class ExpenseManagerApp extends StatelessWidget {
  const ExpenseManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quản lý thu chi',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

// ============================================================
// DASHBOARD - MÀN HÌNH CHÍNH
// ============================================================

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FC),

      // Thanh điều hướng phía dưới
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black87,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TransactionsScreen(),
              ),
            );
          }

          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StatisticsScreen(),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Giao dịch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline),
            activeIcon: Icon(Icons.pie_chart),
            label: 'Thống kê',
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // =========================
              // HEADER
              // =========================
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 4),

                  const Expanded(
                    child: Text(
                      'Quản lý thu chi',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_none,
                          size: 30,
                        ),
                      ),

                      Positioned(
                        right: 5,
                        top: 3,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '3',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // =========================
              // SỐ DƯ HIỆN TẠI
              // =========================
              Container(
                width: double.infinity,
                height: 255,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4285F4),
                      Color(0xFF1769E0),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  children: [

                    // Nội dung số dư
                    Positioned(
                      left: 20,
                      right: 20,
                      top: 35,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'SỐ DƯ HIỆN TẠI',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.visibility_outlined,
                                color: Colors.white,
                                size: 22,
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          const Text(
                            '5.000.000 đ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 39,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Hình minh họa ví tiền
                    Positioned(
                      right: 25,
                      bottom: 40,
                      child: Container(
                        width: 110,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet,
                          color: Color(0xFFB9D6FF),
                          size: 75,
                        ),
                      ),
                    ),

                    // Dấu trang
                    Positioned(
                      bottom: 12,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _dot(true),
                          _dot(false),
                          _dot(false),
                          _dot(false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // =========================
              // THU NHẬP + CHI TIÊU
              // =========================
              Row(
                children: [
                  Expanded(
                    child: _summaryCard(
                      title: 'TỔNG THU NHẬP',
                      amount: '8.000.000 đ',
                      icon: Icons.arrow_downward,
                      iconColor: Colors.green,
                      backgroundColor: const Color(0xFFEFF9EE),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _summaryCard(
                      title: 'TỔNG CHI TIÊU',
                      amount: '3.000.000 đ',
                      icon: Icons.arrow_upward,
                      iconColor: Colors.red,
                      backgroundColor: const Color(0xFFFFF0F0),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // =========================
              // GIAO DỊCH GẦN ĐÂY
              // =========================
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Giao dịch gần đây',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const TransactionsScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Xem tất cả',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // Danh sách giao dịch
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  children: [
                    _transactionItem(
                      icon: Icons.restaurant,
                      iconColor: Colors.orange,
                      title: 'Ăn trưa',
                      category: 'Ăn uống',
                      date: '03/09/2024',
                      amount: '-50.000 đ',
                      amountColor: Colors.red,
                    ),

                    _transactionItem(
                      icon: Icons.directions_car,
                      iconColor: Colors.blue,
                      title: 'Xăng xe',
                      category: 'Di chuyển',
                      date: '03/09/2024',
                      amount: '-100.000 đ',
                      amountColor: Colors.red,
                    ),

                    _transactionItem(
                      icon: Icons.attach_money,
                      iconColor: Colors.green,
                      title: 'Lương tháng 9',
                      category: 'Thu nhập',
                      date: '01/09/2024',
                      amount: '+8.000.000 đ',
                      amountColor: Colors.green,
                    ),

                    _transactionItem(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.purple,
                      title: 'Mua sắm',
                      category: 'Mua sắm',
                      date: '31/08/2024',
                      amount: '-300.000 đ',
                      amountColor: Colors.red,
                    ),

                    _transactionItem(
                      icon: Icons.school,
                      iconColor: Colors.teal,
                      title: 'Học phí',
                      category: 'Giáo dục',
                      date: '30/08/2024',
                      amount: '-500.000 đ',
                      amountColor: Colors.red,
                      showDivider: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // =========================
      // NÚT +
      // =========================
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 5,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 34,
        ),
      ),
    );
  }

  static Widget _dot(bool selected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: selected ? 22 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: selected
            ? Colors.white
            : Colors.white.withOpacity(0.35),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  static Widget _summaryCard({
    required String title,
    required String amount,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
  }) {
    return Container(
      height: 112,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: iconColor,
                    width: 4,
                  ),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 25,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            amount,
            style: TextStyle(
              color: iconColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _transactionItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String category,
    required String date,
    required String amount,
    required Color amountColor,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 13,
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 25,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Text(
                          category,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          date,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Text(
                amount,
                style: TextStyle(
                  color: amountColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        if (showDivider)
          Divider(
            height: 1,
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade200,
          ),
      ],
    );
  }
}

// ============================================================
// MÀN HÌNH THÊM GIAO DỊCH - GIỮ LẠI TỪ BUỔI 3
// ============================================================

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thêm giao dịch',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'Màn hình Thêm giao dịch của Buổi 3',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

// ============================================================
// MÀN HÌNH GIAO DỊCH
// ============================================================

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Giao dịch',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: Text(
          'Danh sách giao dịch',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// ============================================================
// MÀN HÌNH THỐNG KÊ
// ============================================================

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thống kê',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: Text(
          'Màn hình thống kê',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}