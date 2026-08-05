import 'package:flutter/material.dart';

void main() {
  runApp(const AuraGrandApp());
}

class AuraGrandApp extends StatelessWidget {
  const AuraGrandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aura Grand Resort & Club',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0B12),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8A2BE2),
          secondary: Color(0xFFB15EFF),
          surface: Color(0xFF141322),
          tertiary: Color(0xFFFFD700),
        ),
        fontFamily: 'Roboto',
      ),
      home: const RoleSelectionScreen(),
    );
  }
}

// ============================================================================
// 1️⃣ شاشة الدخول الفاخرة واختيار النمط
// ============================================================================
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Glow Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.5, -0.6),
                radius: 1.2,
                colors: [Color(0xFF3C096C), Color(0xFF0B0B12)],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF8A2BE2).withOpacity(0.15),
                      border: Border.all(color: const Color(0xFFFFD700), width: 1.5),
                    ),
                    child: const Icon(Icons.hotel_class_sharp, size: 70, color: Color(0xFFFFD700)),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'A U R A   G R A N D',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.black,
                      letterSpacing: 4,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'LUXURY RESORT & PRIVATE CLUB',
                    style: TextStyle(fontSize: 11, letterSpacing: 2, color: Color(0xFFB15EFF)),
                  ),
                  const Spacer(),
                  
                  // Customer Mode
                  _buildRoleCard(
                    context,
                    title: 'تجربة النزلاء والضيوف',
                    subtitle: 'حجز أجنحة، خدمات الغرف، والمفتاح الذكي',
                    icon: Icons.king_bed_outlined,
                    accentColor: const Color(0xFF8A2BE2),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const GuestMainShell()),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Admin Mode
                  _buildRoleCard(
                    context,
                    title: 'الإدارة التنفيذية',
                    subtitle: 'الخزنة المركزية، شبكة التشغيل، والمالية',
                    icon: Icons.admin_panel_settings_outlined,
                    accentColor: const Color(0xFFFFD700),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AdminMainShell()),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF141322),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withOpacity(0.4), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: accentColor, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 2️⃣ بيئة النزلاء والضيوف (GUEST APP SHELL)
// ============================================================================
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
        title: const Text('Aura Grand Guest Portal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFF141322),
        elevation: 0,
        centerTitle: true,
      ),
      body: IndexedStack(index: _tabIndex, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (i) => setState(() => _tabIndex = i),
        backgroundColor: const Color(0xFF141322),
        indicatorColor: const Color(0xFF8A2BE2).withOpacity(0.4),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.apartment), label: 'الأجنحة'),
          NavigationDestination(icon: Icon(Icons.room_service_outlined), label: 'خدمة الغرف'),
          NavigationDestination(icon: Icon(Icons.vibration), label: 'المفتاح الذكي'),
        ],
      ),
    );
  }
}

// --- تاب الأجنحة والحجز ---
class GuestSuitesTab extends StatefulWidget {
  const GuestSuitesTab({super.key});

  @override
  State<GuestSuitesTab> createState() => _GuestSuitesTabState();
}

class _GuestSuitesTabState extends State<GuestSuitesTab> {
  int _selectedNights = 1;

  final List<Map<String, dynamic>> _suites = [
    {
      'title': 'الجناح الملكي (Royal Penthouse)',
      'price': 1200,
      'rating': 4.9,
      'features': 'إطلالة على المسبح • جاكوزي خاص • خادم شخصي'
    },
    {
      'title': 'جناح أورا التنفيذي (Executive Aura)',
      'price': 750,
      'rating': 4.8,
      'features': 'شاشة 75 بوصة • صالون خاص • بوفيه مفتوح'
    },
    {
      'title': 'غرفة فيلا ديلوكس (Deluxe Villa)',
      'price': 450,
      'rating': 4.7,
      'features': 'مدخل مباشر للنادي • حديقة خاصة'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('الأجنحة والڤيلال المتاحة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: [
                const Text('الليالي: ', style: TextStyle(color: Colors.grey)),
                DropdownButton<int>(
                  value: _selectedNights,
                  dropdownColor: const Color(0xFF141322),
                  items: [1, 2, 3, 5, 7].map((e) => DropdownMenuItem(value: e, child: Text('$e'))).toList(),
                  onChanged: (v) => setState(() => _selectedNights = v!),
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 12),
        ..._suites.map((suite) {
          int totalPrice = (suite['price'] as int) * _selectedNights;
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF141322),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    gradient: LinearGradient(
                      colors: [const Color(0xFF8A2BE2).withOpacity(0.4), const Color(0xFF141322)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.king_bed, size: 50, color: const Color(0xFFFFD700).withOpacity(0.8)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(suite['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Color(0xFFFFD700), size: 16),
                              Text(' ${suite['rating']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(suite['features'] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$$totalPrice / $_selectedNights ليلة',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFB15EFF))),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8A2BE2),
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('تم تأكيد طلب حجز ${suite['title']} لعدد $_selectedNights ليلة!')),
                              );
                            },
                            child: const Text('حجز الآن'),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ],
    );
  }
}

// --- تاب خدمة الغرف والسلة الحية ---
class GuestRoomServiceTab extends StatefulWidget {
  const GuestRoomServiceTab({super.key});

  @override
  State<GuestRoomServiceTab> createState() => _GuestRoomServiceTabState();
}

class _GuestRoomServiceTabState extends State<GuestRoomServiceTab> {
  final Map<String, int> _cart = {};

  final List<Map<String, dynamic>> _menu = [
    {'name': 'وجبة ستيك واجيو فاخرة', 'price': 85, 'category': 'الأطباق الرئيسية'},
    {'name': 'سوشي أورا المخصوص', 'price': 65, 'category': 'الأطباق الرئيسية'},
    {'name': 'كوكتيل الفواكه الاستوائية', 'price': 20, 'category': 'المشروبات'},
    {'name': 'قهوة إسبانيول كولد بريو', 'price': 15, 'category': 'المشروبات'},
  ];

  double get _cartTotal {
    double sum = 0;
    _cart.forEach((itemName, qty) {
      final item = _menu.firstWhere((element) => element['name'] == itemName);
      sum += (item['price'] as int) * qty;
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
              final name = item['name'] as String;
              final qty = _cart[name] ?? 0;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF141322),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Color(0xFF8A2BE2),
                      child: Icon(Icons.restaurant, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('\$${item['price']}', style: const TextStyle(color: Color(0xFFFFD700), fontSize: 13)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        if (qty > 0)
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                            onPressed: () {
                              setState(() {
                                if (qty == 1) {
                                  _cart.remove(name);
                                } else {
                                  _cart[name] = qty - 1;
                                }
                              });
                            },
                          ),
                        if (qty > 0) Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline, color: Color(0xFFB15EFF)),
                          onPressed: () {
                            setState(() {
                              _cart[name] = qty + 1;
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),

        // Cart Summary Bar
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color(0xFF141322),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('إجمالي الطلب:', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text('\$${_cartTotal.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFFFD700))),
                ],
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8A2BE2),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: _cartTotal == 0
                    ? null
                    : () {
                        setState(() => _cart.clear());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم إرسال الطلب إلى المطبخ بنجاح!')),
                        );
                      },
                icon: const Icon(Icons.send_rounded),
                label: const Text('إرسال للغرفة'),
              )
            ],
          ),
        )
      ],
    );
  }
}

// --- تاب المفتاح الرقمي الذكي ---
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
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      _isUnlocked = !_isUnlocked;
      _isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('غرفة رقم 402 - الجناح الملكي', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('قرّب الموبايل من قفل الباب الذكي للفتح عبر NFC', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 40),

            GestureDetector(
              onTap: _isProcessing ? null : _toggleKey,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isUnlocked ? Colors.green.withOpacity(0.15) : const Color(0xFF8A2BE2).withOpacity(0.15),
                  border: Border.all(
                    color: _isUnlocked ? Colors.green : const Color(0xFF8A2BE2),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (_isUnlocked ? Colors.green : const Color(0xFF8A2BE2)).withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Center(
                  child: _isProcessing
                      ? const CircularProgressIndicator(color: Color(0xFFFFD700))
                      : Icon(
                          _isUnlocked ? Icons.lock_open_rounded : Icons.sensors,
                          size: 70,
                          color: _isUnlocked ? Colors.green : const Color(0xFFFFD700),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              _isUnlocked ? 'الباب مفتوح الآن' : 'اضغط للمسح والفتح',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _isUnlocked ? Colors.green : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 3️⃣ بيئة الإدارة والتنفيذ (ADMIN EXECUTIVE SHELL)
// ============================================================================
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
        title: const Text('Aura Grand Executive Management', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF141322),
        elevation: 0,
        centerTitle: true,
      ),
      body: IndexedStack(index: _tabIndex, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (i) => setState(() => _tabIndex = i),
        backgroundColor: const Color(0xFF141322),
        indicatorColor: const Color(0xFFFFD700).withOpacity(0.3),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: 'شبكة التشغيل'),
          NavigationDestination(icon: Icon(Icons.shield_outlined), label: 'الخزنة المركزية'),
        ],
      ),
    );
  }
}

// --- تاب شبكة الغرف والتشغيل ---
class AdminMatrixTab extends StatefulWidget {
  const AdminMatrixTab({super.key});

  @override
  State<AdminMatrixTab> createState() => _AdminMatrixTabState();
}

class _AdminMatrixTabState extends State<AdminMatrixTab> {
  final List<Map<String, dynamic>> _rooms = [
    {'id': '101', 'status': 'مشغولة', 'guest': 'أحمد السيد', 'color': Colors.redAccent},
    {'id': '102', 'status': 'جاهزة', 'guest': '-', 'color': Colors.green},
    {'id': '103', 'status': 'صيانة', 'guest': '-', 'color': Colors.orangeAccent},
    {'id': '104', 'status': 'مشغولة', 'guest': 'م. محمود', 'color': Colors.redAccent},
    {'id': '201', 'status': 'جاهزة', 'guest': '-', 'color': Colors.green},
    {'id': '202', 'status': 'جاهزة', 'guest': '-', 'color': Colors.green},
  ];

  void _cycleStatus(int index) {
    setState(() {
      if (_rooms[index]['status'] == 'جاهزة') {
        _rooms[index]['status'] = 'مشغولة';
        _rooms[index]['color'] = Colors.redAccent;
        _rooms[index]['guest'] = 'حجز جديد';
      } else if (_rooms[index]['status'] == 'مشغولة') {
        _rooms[index]['status'] = 'صيانة';
        _rooms[index]['color'] = Colors.orangeAccent;
        _rooms[index]['guest'] = '-';
      } else {
        _rooms[index]['status'] = 'جاهزة';
        _rooms[index]['color'] = Colors.green;
        _rooms[index]['guest'] = '-';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('مصفوفة حالة الغرف الحية', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('انقر على أي غرفة لتغيير حالتها فورياً', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 16),
          Expanded(
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
                final Color roomColor = room['color'] as Color;

                return GestureDetector(
                  onTap: () => _cycleStatus(index),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF141322),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: roomColor.withOpacity(0.6), width: 1.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('غرفة ${room['id']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            CircleAvatar(radius: 5, backgroundColor: roomColor),
                          ],
                        ),
                        Text('النزيل: ${room['guest']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: roomColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            room['status'] as String,
                            style: TextStyle(color: roomColor, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
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

// --- تاب الخزنة والPIN الاحترافي ---
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
            const SnackBar(content: Text('رمز PIN غير صحيح! (الرمز: 1234)')),
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
              const Icon(Icons.security, size: 60, color: Color(0xFFFFD700)),
              const SizedBox(height: 16),
              const Text('الخزنة المركزية الحصينة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('أدخل رمز PIN الافتراضي (1234)', style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 24),

              // PIN Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) {
                  bool filled = i < _enteredPin.length;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: filled ? const Color(0xFFFFD700) : Colors.transparent,
                      border: Border.all(color: const Color(0xFFFFD700)),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),

              // Numpad Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: 9,
                itemBuilder: (context, i) {
                  final number = '${i + 1}';
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF141322),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => _onKeyPress(number),
                    child: Text(number, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    // Vault Opened Screen
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF3C096C), Color(0xFF141322)]),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFFFD700), width: 1.5),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('الرصيد المالي الحالي', style: TextStyle(color: Colors.white70)),
                    IconButton(
                      icon: const Icon(Icons.lock, color: Colors.redAccent),
                      onPressed: () => setState(() => _unlocked = false),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '\$ ${_vaultBalance.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.black, color: Color(0xFFFFD700)),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800),
                        onPressed: () {
                          setState(() {
                            _vaultBalance += 1000;
                            _transactions.insert(0, 'إيداع إيراد سريع: +$1,000');
                          });
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text('إيداع $1000', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerRight,
            child: Text('سجل حركة الأموال الخزنة:', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, i) {
                return Card(
                  color: const Color(0xFF141322),
                  child: ListTile(
                    leading: const Icon(Icons.monetization_on_outlined, color: Color(0xFFFFD700)),
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
