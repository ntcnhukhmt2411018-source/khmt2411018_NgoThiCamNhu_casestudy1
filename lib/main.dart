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
      title: 'Expense Manager',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
      ),
      home: const AddTransactionScreen(),
    );
  }
}

// =====================================================
// MÀN HÌNH THÊM GIAO DỊCH
// =====================================================

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState
    extends State<AddTransactionScreen> {
  bool isExpense = true;

  String selectedCategory = 'Ăn uống';

  DateTime selectedDate = DateTime(2025, 4, 12);

  final amountController = TextEditingController();
  final noteController = TextEditingController();

  String get dateText {
    return '${selectedDate.day.toString().padLeft(2, '0')}/'
        '${selectedDate.month.toString().padLeft(2, '0')}/'
        '${selectedDate.year}';
  }

  Future<void> chooseDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (result != null) {
      setState(() {
        selectedDate = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ================= TIÊU ĐỀ =================
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 20,
                top: 8,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 21,
                    ),
                  ),

                  const Expanded(
                    child: Text(
                      'Thêm giao dịch',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF10233F),
                      ),
                    ),
                  ),

                  const SizedBox(width: 45),
                ],
              ),
            ),

            // ================= NỘI DUNG =================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  10,
                  20,
                  25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CHI TIÊU / THU NHẬP
                    Row(
                      children: [
                        Expanded(
                          child: _typeButton(
                            text: 'Chi tiêu',
                            selected: isExpense,
                            onTap: () {
                              setState(() {
                                isExpense = true;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _typeButton(
                            text: 'Thu nhập',
                            selected: !isExpense,
                            onTap: () {
                              setState(() {
                                isExpense = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // DANH MỤC
                    _title('Danh mục'),

                    const SizedBox(height: 7),

                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFF718096),
                      ),
                      decoration: _inputDecoration(
                        prefixIcon: Icons.restaurant,
                        prefixColor: const Color(0xFFFF6670),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Ăn uống',
                          child: Text('Ăn uống'),
                        ),
                        DropdownMenuItem(
                          value: 'Di chuyển',
                          child: Text('Di chuyển'),
                        ),
                        DropdownMenuItem(
                          value: 'Mua sắm',
                          child: Text('Mua sắm'),
                        ),
                        DropdownMenuItem(
                          value: 'Giải trí',
                          child: Text('Giải trí'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedCategory = value;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 17),

                    // SỐ TIỀN
                    _title('Số tiền'),

                    const SizedBox(height: 7),

                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration(
                        hintText: 'Nhập số tiền',
                        suffixText: 'đ',
                      ),
                    ),

                    const SizedBox(height: 17),

                    // NGÀY GIAO DỊCH
                    _title('Ngày giao dịch'),

                    const SizedBox(height: 7),

                    TextField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: dateText,
                      ),
                      onTap: chooseDate,
                      decoration: _inputDecoration(
                        suffixIcon: Icons.calendar_month_outlined,
                      ),
                    ),

                    const SizedBox(height: 17),

                    // GHI CHÚ
                    _title('Ghi chú'),

                    const SizedBox(height: 7),

                    TextField(
                      controller: noteController,
                      maxLines: 3,
                      decoration: _inputDecoration(
                        hintText: 'Nhập ghi chú (tùy chọn)',
                      ),
                    ),

                    const SizedBox(height: 24),

                    // NÚT LƯU
                    _saveButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const EditTransactionScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Color(0xFF172B4D),
      ),
    );
  }

  Widget _typeButton({
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFF5D66)
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected
                ? const Color(0xFFFF5D66)
                : const Color(0xFFE0E5EC),
            width: 1.2,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: selected
                ? Colors.white
                : const Color(0xFF344054),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    String? hintText,
    String? suffixText,
    IconData? prefixIcon,
    Color? prefixColor,
    IconData? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFF9AA5B5),
        fontSize: 13,
      ),
      suffixText: suffixText,
      suffixStyle: const TextStyle(
        color: Color(0xFF7C8798),
        fontWeight: FontWeight.bold,
      ),
      prefixIcon: prefixIcon != null
          ? Icon(
        prefixIcon,
        color: prefixColor,
        size: 21,
      )
          : null,
      suffixIcon: suffixIcon != null
          ? Icon(
        suffixIcon,
        color: const Color(0xFF7A8798),
        size: 20,
      )
          : null,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 13,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: Color(0xFFE0E5EC),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: Color(0xFFE0E5EC),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: Color(0xFF2775E8),
        ),
      ),
    );
  }

  Widget _saveButton({
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2675E8),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: const Text(
          'Lưu',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// =====================================================
// MÀN HÌNH SỬA GIAO DỊCH
// =====================================================

class EditTransactionScreen extends StatefulWidget {
  const EditTransactionScreen({super.key});

  @override
  State<EditTransactionScreen> createState() =>
      _EditTransactionScreenState();
}

class _EditTransactionScreenState
    extends State<EditTransactionScreen> {
  bool isExpense = true;

  String selectedCategory = 'Ăn uống';

  DateTime selectedDate = DateTime(2025, 4, 12);

  final amountController = TextEditingController(
    text: '100.000',
  );

  final noteController = TextEditingController(
    text: 'Ăn trưa',
  );

  String get dateText {
    return '${selectedDate.day.toString().padLeft(2, '0')}/'
        '${selectedDate.month.toString().padLeft(2, '0')}/'
        '${selectedDate.year}';
  }

  Future<void> chooseDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (result != null) {
      setState(() {
        selectedDate = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ================= TIÊU ĐỀ =================
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 20,
                top: 8,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 21,
                    ),
                  ),

                  const Expanded(
                    child: Text(
                      'Sửa giao dịch',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF10233F),
                      ),
                    ),
                  ),

                  const SizedBox(width: 45),
                ],
              ),
            ),

            // ================= NỘI DUNG =================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  10,
                  20,
                  25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CHI TIÊU / THU NHẬP
                    Row(
                      children: [
                        Expanded(
                          child: _typeButton(
                            text: 'Chi tiêu',
                            selected: isExpense,
                            onTap: () {
                              setState(() {
                                isExpense = true;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _typeButton(
                            text: 'Thu nhập',
                            selected: !isExpense,
                            onTap: () {
                              setState(() {
                                isExpense = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // DANH MỤC
                    _title('Danh mục'),

                    const SizedBox(height: 7),

                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFF718096),
                      ),
                      decoration: _inputDecoration(
                        prefixIcon: Icons.restaurant,
                        prefixColor: const Color(0xFFFF6670),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Ăn uống',
                          child: Text('Ăn uống'),
                        ),
                        DropdownMenuItem(
                          value: 'Di chuyển',
                          child: Text('Di chuyển'),
                        ),
                        DropdownMenuItem(
                          value: 'Mua sắm',
                          child: Text('Mua sắm'),
                        ),
                        DropdownMenuItem(
                          value: 'Giải trí',
                          child: Text('Giải trí'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedCategory = value;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 17),

                    // SỐ TIỀN
                    _title('Số tiền'),

                    const SizedBox(height: 7),

                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration(
                        suffixText: 'đ',
                      ),
                    ),

                    const SizedBox(height: 17),

                    // NGÀY GIAO DỊCH
                    _title('Ngày giao dịch'),

                    const SizedBox(height: 7),

                    TextField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: dateText,
                      ),
                      onTap: chooseDate,
                      decoration: _inputDecoration(
                        suffixIcon: Icons.calendar_month_outlined,
                      ),
                    ),

                    const SizedBox(height: 17),

                    // GHI CHÚ
                    _title('Ghi chú'),

                    const SizedBox(height: 7),

                    TextField(
                      controller: noteController,
                      maxLines: 3,
                      decoration: _inputDecoration(),
                    ),

                    const SizedBox(height: 24),

                    // NÚT LƯU
                    _saveButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Đã lưu giao dịch',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Color(0xFF172B4D),
      ),
    );
  }

  Widget _typeButton({
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFF5D66)
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected
                ? const Color(0xFFFF5D66)
                : const Color(0xFFE0E5EC),
            width: 1.2,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: selected
                ? Colors.white
                : const Color(0xFF344054),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    String? hintText,
    String? suffixText,
    IconData? prefixIcon,
    Color? prefixColor,
    IconData? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFF9AA5B5),
        fontSize: 13,
      ),
      suffixText: suffixText,
      suffixStyle: const TextStyle(
        color: Color(0xFF7C8798),
        fontWeight: FontWeight.bold,
      ),
      prefixIcon: prefixIcon != null
          ? Icon(
        prefixIcon,
        color: prefixColor,
        size: 21,
      )
          : null,
      suffixIcon: suffixIcon != null
          ? Icon(
        suffixIcon,
        color: const Color(0xFF7A8798),
        size: 20,
      )
          : null,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 13,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: Color(0xFFE0E5EC),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: Color(0xFFE0E5EC),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: Color(0xFF2675E8),
        ),
      ),
    );
  }

  Widget _saveButton({
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2675E8),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: const Text(
          'Lưu',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}