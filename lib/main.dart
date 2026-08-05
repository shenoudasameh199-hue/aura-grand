import 'package:flutter/material.dart';

void main() {
  runApp(const AuraGrandApp());
}

// ==========================================
// 📦 Models (نماذج البيانات لتفادي أي خطأ)
// ==========================================
class SuiteModel {
  final String title;
  final int price;
  final double rating;
  final String features;
  SuiteModel(this.title, this.price, this.rating, this.features);
}

class MenuItemModel {
  final String name;
  final double price;
  MenuItemModel(this.name, this.price);
}

class RoomModel {
  final String id;
  String status;
  String guest;
  Color color;
  RoomModel(this.id, this.status, this.guest, this.color);
}

// ==========================================
// 🚀 التطبيق الرئيسي
// ==========================================
class AuraGrandApp extends StatelessWidget {
  const AuraGrandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aura Grand',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0E17),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8A2BE2),
          secondary: Color(0xFFB15EFF),
          surface: Color(0xFF141322),
        ),
      ),
      home: const RoleSelectionScreen(),
    );
  }
}

// ==========================================
// 1️⃣ شاشة الدخول واختيار الصفة
// ==========================================
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.hotel_class, size: 70, color: Color(0xFFFFD700)),
              const SizedBox(height: 16),
              const Text(
                'AURA GRAND',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 3),
              ),
              const SizedBox(height: 8),
              const Text('فندق ونادي أورا جراند الفاخر', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8A2BE2),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GuestMainShell())),
                icon: const Icon(Icons.person),
                label: const Text('دخول كـ (نزيل / ضيف)', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFFFD700),
                  side: const BorderSide(color: Color(0xFFFFD700)),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminMainShell())),
                icon: const Icon(Icons.admin_panel_settings),
                label: const Text('لوحة تحكم الإدارة Executive', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 2️⃣ قسم النزلاء (Guest Portal)
// ==========================================
class GuestMainShell extends StatefulWidget {
  const GuestMainShell({super.key});

  @override
  State<GuestMainShell> createState() => _GuestMainShellState();
}

class _GuestMainShellState extends State<GuestMainShell> {
  int _tabIndex = 0;
  final List<Widget> _tabs = [
    const GuestSuitesTab(),
    const GuestRoomServiceTab(),
    const GuestSmartKeyTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aura Grand - بوابة الضيوف', style: TextStyle(fontSize: 16)),
        backgroundColor: const Color(0xFF141322),
      ),
      body: _tabs[_tabIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (i) => setState(() => _tabIndex = i),
        backgroundColor: const Color(0xFF141322),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.apartment), label: 'الأجنحة'),
          NavigationDestination(icon: Icon(Icons.room_service), label: 'خدمة الغرف'),
          NavigationDestination(icon: Icon(Icons.key), label: 'المفتاح الذكي'),
        ],
      ),
    );
  }
}

class GuestSuitesTab extends StatefulWidget {
  const GuestSuitesTab({super.key});

  @override
  State<GuestSuitesTab> createState() => _GuestSuitesTabState();
}

class _GuestSuitesTabState extends State<GuestSuitesTab> {
  int _selectedNights = 1;

  final List<SuiteModel> _suites = [
    SuiteModel('الجناح الملكي (Royal Penthouse)', 1200, 4.9, 'إطلالة شاطئية • جاكوزي خاص • خادم شخصي'),
    SuiteModel('جناح أورا التنفيذي (Executive Aura)', 750, 4.8, 'شاشة 75 بوصة • صالون خاص • بوفيه مفتوح'),
    SuiteModel('غرفة فيلا ديلوكس (Deluxe Villa)', 450, 4.7, 'مدخل مباشر للنادي • حديقة خاصة'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('الأجنحة المتاحة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                const Text('الليالي: ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                DropdownButton<int>(
                  value: _selectedNights,
                  dropdownColor: const Color(0xFF141322),
                  items: [1, 2, 3, 5, 7].map((e) => DropdownMenuItem<int>(value: e, child: Text('$e'))).toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedNights = v);
                  },
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 12),
        ..._suites.map((suite) {
          final totalPrice = suite.price * _selectedNights;
          return Card(
            color: const Color(0xFF141322),
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(suite.title, style: const TextStyle(fontWeight: FontWeight.bold))),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Color(0xFFFFD700), size: 16),
                          Text(' ${suite.rating}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(suite.features, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$$totalPrice / $_selectedNights ليلة',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFB15EFF))),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8A2BE2)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('تم تأكيد حجز ${suite.title}')),
                          );
                        },
                        child: const Text('حجز الآن', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class GuestRoomServiceTab extends StatefulWidget {
  const GuestRoomServiceTab({super.key});

  @override
  State<GuestRoomServiceTab> createState() => _GuestRoomServiceTabState();
}

class _GuestRoomServiceTabState extends State<GuestRoomServiceTab> {
  final Map<String, int> _cart = {};

  final List<MenuItemModel> _menu = [
    MenuItemModel('وجبة ستيك واجيو فاخرة', 85.0),
    MenuItemModel('سوشي أورا المخصوص', 65.0),
    MenuItemModel('كوكتيل الفواكه الاستوائية', 20.0),
    MenuItemModel('قهوة إسبانيول كولد بريو', 15.0),
  ];

  double get _cartTotal {
    double sum = 0;
    _cart.forEach((itemName, qty) {
      final item = _menu.firstWhere((e) => e.name == itemName);
      sum += item.price * qty;
    });
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _menu.length,
            itemBuilder: (context, i) {
              final item = _menu[i];
              final qty = _cart[item.name] ?? 0;

              return Card(
                color: const Color(0xFF141322),
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF8A2BE2),
                    child: Icon(Icons.restaurant, color: Colors.white, size: 18),
                  ),
                  title: Text(item.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  subtitle: Text('\$${item.price}', style: const TextStyle(color: Color(0xFFFFD700))),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (qty > 0)
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                          onPressed: () {
                            setState(() {
                              if (qty == 1) {
                                _cart.remove(item.name);
                              } else {
                                _cart[item.name] = qty - 1;
                              }
                            });
                          },
                        ),
                      if (qty > 0) Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, color: Color(0xFFB15EFF)),
                        onPressed: () {
                          setState(() {
                            _cart[item.name] = qty + 1;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: const Color(0xFF141322),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('الإجمالي:', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text('\$${_cartTotal.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFFD700))),
                ],
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8A2BE2)),
                onPressed: _cartTotal == 0
                    ? null
                    : () {
                        setState(() => _cart.clear());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم إرسال الطلب للمطبخ بنجاح!')),
                        );
                      },
                icon: const Icon(Icons.send, color: Colors.white),
                label: const Text('طلب للغرفة', style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        )
      ],
    );
  }
}

class GuestSmartKeyTab extends StatefulWidget {
  const GuestSmartKeyTab({super.key});

  @override
  State<GuestSmartKeyTab> createState() => _GuestSmartKeyTabState();
}

class _GuestSmartKeyTabState extends State<GuestSmartKeyTab> {
  bool _isUnlocked = false;
  bool _isProcessing = false;

  void _toggleKey() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {
        _isUnlocked = !_isUnlocked;
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('جناح رقم 402 - المفتاح الرقمي', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: _isProcessing ? null : _toggleKey,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isUnlocked ? Colors.green.withOpacity(0.2) : const Color(0xFF8A2BE2).withOpacity(0.2),
                border: Border.all(color: _isUnlocked ? Colors.green : const Color(0xFF8A2BE2), width: 3),
              ),
              child: Center(
                child: _isProcessing
                    ? const CircularProgressIndicator(color: Color(0xFFFFD700))
                    : Icon(
                        _isUnlocked ? Icons.lock_open : Icons.key,
                        size: 60,
                        color: _isUnlocked ? Colors.green : const Color(0xFFFFD700),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _isUnlocked ? 'الباب مفتوح' : 'اضغط للفتح الحسي',
            style: TextStyle(fontWeight: FontWeight.bold, color: _isUnlocked ? Colors.green : Colors.grey),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 3️⃣ قسم الإدارة (Admin Executive)
// ==========================================
class AdminMainShell extends StatefulWidget {
  const AdminMainShell({super.key});

  @override
  State<AdminMainShell> createState() => _AdminMainShellState();
}

class _AdminMainShellState extends State<AdminMainShell> {
  int _tabIndex = 0;
  final List<Widget> _tabs = [
    const AdminMatrixTab(),
    const AdminVaultSecureTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة الإدارة التنفيذية', style: TextStyle(fontSize: 16)),
        backgroundColor: const Color(0xFF141322),
      ),
      body: _tabs[_tabIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (i) => setState(() => _tabIndex = i),
        backgroundColor: const Color(0xFF141322),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view), label: 'شبكة الغرف'),
          NavigationDestination(icon: Icon(Icons.shield), label: 'الخزنة المركزية'),
        ],
      ),
    );
  }
}

class AdminMatrixTab extends StatefulWidget {
  const AdminMatrixTab({super.key});

  @override
  State<AdminMatrixTab> createState() => _AdminMatrixTabState();
}

class _AdminMatrixTabState extends State<AdminMatrixTab> {
  final List<RoomModel> _rooms = [
    RoomModel('101', 'مشغولة', 'أحمد السيد', Colors.redAccent),
    RoomModel('102', 'جاهزة', '-', Colors.green),
    RoomModel('103', 'صيانة', '-', Colors.orangeAccent),
    RoomModel('104', 'مشغولة', 'محمود علي', Colors.redAccent),
    RoomModel('201', 'جاهزة', '-', Colors.green),
    RoomModel('202', 'جاهزة', '-', Colors.green),
  ];

  void _cycleStatus(int index) {
    setState(() {
      if (_rooms[index].status == 'جاهزة') {
        _rooms[index].status = 'مشغولة';
        _rooms[index].color = Colors.redAccent;
        _rooms[index].guest = 'نزيل جديد';
      } else if (_rooms[index].status == 'مشغولة') {
        _rooms[index].status = 'صيانة';
        _rooms[index].color = Colors.orangeAccent;
        _rooms[index].guest = '-';
      } else {
        _rooms[index].status = 'جاهزة';
        _rooms[index].color = Colors.green;
        _rooms[index].guest = '-';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.3,
        ),
        itemCount: _rooms.length,
        itemBuilder: (context, index) {
          final room = _rooms[index];
          return InkWell(
            onTap: () => _cycleStatus(index),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF141322),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: room.color.withOpacity(0.6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('غرفة ${room.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      CircleAvatar(radius: 4, backgroundColor: room.color),
                    ],
                  ),
                  Text('النزيل: ${room.guest}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  Text(room.status, style: TextStyle(color: room.color, fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AdminVaultSecureTab extends StatefulWidget {
  const AdminVaultSecureTab({super.key});

  @override
  State<AdminVaultSecureTab> createState() => _AdminVaultSecureTabState();
}

class _AdminVaultSecureTabState extends State<AdminVaultSecureTab> {
  bool _unlocked = false;
  String _enteredPin = '';
  double _vaultBalance = 248900.00;

  final List<String> _transactions = [
    'إيداع تسوية النادي: +$12,500',
    'مصروفات صيانة الأجنحة: -$1,200',
    'إيراد حجز جناح 101: +$3,600',
  ];

  void _onKeyPress(String digit) {
    if (_enteredPin.length < 4) {
      setState(() => _enteredPin += digit);
      if (_enteredPin.length == 4) {
        if (_enteredPin == '1234') {
          setState(() {
            _unlocked = true;
            _enteredPin = '';
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('رمز PIN خاطئ! (الرمز: 1234)')),
          );
          setState(() => _enteredPin = '');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_unlocked) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.security, size: 50, color: Color(0xFFFFD700)),
              const SizedBox(height: 12),
              const Text('الخزنة المركزية', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Text('رمز PIN التجريبي: 1234', style: TextStyle(fontSize: 11, color: Colors.grey)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i < _enteredPin.length ? const Color(0xFFFFD700) : Colors.transparent,
                      border: Border.all(color: const Color(0xFFFFD700)),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 9,
                itemBuilder: (context, i) {
                  final number = '${i + 1}';
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141322)),
                    onPressed: () => _onKeyPress(number),
                    child: Text(number, style: const TextStyle(fontSize: 18, color: Colors.white)),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF141322),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFFFD700)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('رصيد الخزنة الحصينة', style: TextStyle(color: Colors.grey)),
                    IconButton(
                      icon: const Icon(Icons.lock, color: Colors.redAccent),
                      onPressed: () => setState(() => _unlocked = false),
                    )
                  ],
                ),
                Text(
                  '\$ ${_vaultBalance.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFFFFD700)),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800),
                  onPressed: () {
                    setState(() {
                      _vaultBalance += 1000;
                      _transactions.insert(0, 'إيداع سريع: +$1,000');
                    });
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('إيداع $1000', style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, i) {
                return Card(
                  color: const Color(0xFF141322),
                  child: ListTile(
                    leading: const Icon(Icons.monetization_on, color: Color(0xFFFFD700)),
                    title: Text(_transactions[i], style: const TextStyle(fontSize: 13)),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
