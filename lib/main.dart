import 'package:flutter/material.dart';

void main() {
  runApp(const AuraGrandApp());
}

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
        primaryColor: const Color(0xFF7B2CBF),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF9D4EDD),
          secondary: Color(0xFFC77DFF),
          surface: Color(0xFF1B1A29),
        ),
        fontFamily: 'Cairo',
      ),
      home: const AuraHomeDashboard(),
    );
  }
}

class AuraHomeDashboard extends StatefulWidget {
  const AuraHomeDashboard({super.key});

  @override
  State<AuraHomeDashboard> createState() => _AuraHomeDashboardState();
}

class _AuraHomeDashboardState extends State<AuraHomeDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HotelClubOverviewTab(),
    const LiveChatTab(),
    const MoneySafeTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.diamond, color: Color(0xFFC77DFF)),
            const SizedBox(width: 10),
            Text(
              _currentIndex == 0
                  ? 'نظام إدارة Aura Grand'
                  : _currentIndex == 1
                      ? 'الدردشة الحية'
                      : 'خزنة الأموال',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1B1A29),
        centerTitle: false,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: const Color(0xFF1B1A29),
        indicatorColor: const Color(0xFF7B2CBF).withOpacity(0.4),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.hotel_outlined),
            selectedIcon: Icon(Icons.hotel, color: Color(0xFFC77DFF)),
            label: 'الفندق والنادي',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble, color: Color(0xFFC77DFF)),
            label: 'الدردشة الحية',
          ),
          NavigationDestination(
            icon: Icon(Icons.lock_outline),
            selectedIcon: Icon(Icons.lock, color: Color(0xFFC77DFF)),
            label: 'الخزنة',
          ),
        ],
      ),
    );
  }
}

// 1. تبويب إدارة الفندق والنادي
class HotelClubOverviewTab extends StatelessWidget {
  const HotelClubOverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildWelcomeBanner(),
          const SizedBox(height: 20),
          const Text('إحصائيات سريعة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildStatCard('الغرف المتاحة', '24', Icons.door_front, Colors.blue)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard('أعضاء النادي', '142', Icons.group, Colors.orange)),
            ],
          ),
          const SizedBox(height: 20),
          const Text('الخدمات النشطة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildServiceTile('خدمة الغرف الفاخرة', 'نشط - طلبات جديدة قيد التنفيذ', Icons.room_service),
          _buildServiceTile('حجوزات النادي الرياضي', 'مكتمل - 12 حجز اليوم', Icons.sports_gymnastics),
          _buildServiceTile('صالة الحفلات والمؤتمرات', 'مفعل للمساء', Icons.event),
        ],
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7B2CBF), Color(0xFF3C096C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('مرحباً بك، المدير العام', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 8),
          Text('نظام Aura Grand يعمل بكفاءة تامة لإدارة الفندق والنادي.', style: TextStyle(fontSize: 14, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1A29),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildServiceTile(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1A29),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF7B2CBF).withOpacity(0.2),
          child: Icon(icon, color: const Color(0xFFC77DFF)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }
}

// 2. تبويب الدردشة الحية
class LiveChatTab extends StatefulWidget {
  const LiveChatTab({super.key});

  @override
  State<LiveChatTab> createState() => _LiveChatTabState();
}

class _LiveChatTabState extends State<LiveChatTab> {
  final List<String> _messages = [
    'أهلاً بك في خدمة العملاء لفندق ونادي Aura Grand.',
    'هل تحتاج إلى مساعدة في حجز الغرفة أو خدمات النادي؟',
  ];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add(_controller.text);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              bool isMe = index % 2 != 0;
              return Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe ? const Color(0xFF7B2CBF) : const Color(0xFF1B1A29),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(_messages[index], style: const TextStyle(color: Colors.white)),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          color: const Color(0xFF1B1A29),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'اكتب رسالتك هنا...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Color(0xFFC77DFF)),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 3. تبويب خزنة الأموال والتحكم الآمن
class MoneySafeTab extends StatefulWidget {
  const MoneySafeTab({super.key});

  @override
  State<MoneySafeTab> createState() => _MoneySafeTabState();
}

class _MoneySafeTabState extends State<MoneySafeTab> {
  bool _isUnlocked = false;
  final double _balance = 125450.00;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF1B1A29),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _isUnlocked ? Colors.green : Colors.red, width: 2),
            ),
            child: Column(
              children: [
                Icon(
                  _isUnlocked ? Icons.lock_open : Icons.lock,
                  size: 64,
                  color: _isUnlocked ? Colors.green : Colors.redAccent,
                ),
                const SizedBox(height: 16),
                Text(
                  _isUnlocked ? 'الخزنة مفتوحة وآمنة' : 'الخزنة مقفلة برمز الحماية',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  _isUnlocked ? '\$ ${_balance.toStringAsFixed(2)}' : '**********',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFC77DFF)),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isUnlocked ? Colors.red.shade800 : Colors.green.shade800,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isUnlocked = !_isUnlocked;
                    });
                  },
                  icon: Icon(_isUnlocked ? Icons.lock : Icons.lock_open),
                  label: Text(_isUnlocked ? 'قفل الخزنة فوراً' : 'فتح الخزنة بالرقم السري'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('آخر المعاملات المالية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                _buildTransactionTile('حجز جناح ملكي - فندق', '+\$ 1,200.00', Colors.green),
                _buildTransactionTile('اشتراك شهري - النادي', '+\$ 350.00', Colors.green),
                _buildTransactionTile('مصاريف صيانة المساء', '-\$ 450.00', Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(String title, String amount, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1A29),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}


class _AuraHomeDashboardState extends State<AuraHomeDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HotelClubOverviewTab(),
    const LiveChatTab(),
    const MoneySafeTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.diamond, color: Color(0xFFC77DFF)),
            const SizedBox(width: 10),
            Text(
              _currentIndex == 0 ? 'نظام إدارة Aura Grand' : _currentIndex == 1 ? 'الدردشة الحية' : 'خزنة الأموال',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1B1A29),
        centerTitle: false,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: const Color(0xFF1B1A29),
        indicatorColor: const Color(0xFF7B2CBF).withOpacity(0.4),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.hotel_outlined),
            selectedIcon: Icon(Icons.hotel, color: Color(0xFFC77DFF)),
            label: 'الفندق والنادي',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble, color: Color(0xFFC77DFF)),
            label: 'الدردشة الحية',
          ),
          NavigationDestination(
            icon: Icon(Icons.lock_outline),
            selectedIcon: Icon(Icons.lock, color: Color(0xFFC77DFF)),
            label: 'الخزنة',
          ),
        ],
      ),
    );
  }
}

// 1. تبويب إدارة الفندق والنادي
class HotelClubOverviewTab extends StatelessWidget {
  const HotelClubOverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      chuildren: ListView(
        children: [
          _buildWelcomeBanner(),
          const SizedBox(height: 20),
          const Text('إحصائيات سريعة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildStatCard('الغرف المتاحة', '24', Icons.door_front, Colors.blue)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard('أعضاء النادي', '142', Icons.group, Colors.orange)),
            ],
          ),
          const SizedBox(height: 20),
          const Text('الخدمات النشطة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildServiceTile('خدمة الغرف الفاخرة', 'نشط - طلبات جديدة قيد التنفيذ', Icons.room_service),
          _buildServiceTile('حجوزات النادي الرياضي', 'مكتمل - 12 حجز اليوم', Icons.sports_gymnastics),
          _buildServiceTile('صالة الحفلات والمؤتمرات', 'مفعل للمساء', Icons.event),
        ],
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7B2CBF), Color(0xFF3C096C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('مرحباً بك، المدير العام', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 8),
          Text('نظام Aura Grand يعمل بكفاءة تامة لإدارة الفندق والنادي.', style: TextStyle(fontSize: 14, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1A29),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildServiceTile(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1A29),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF7B2CBF).withOpacity(0.2),
          child: Icon(icon, color: const Color(0xFFC77DFF)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }
}

// 2. تبويب الدردشة الحية
class LiveChatTab extends StatefulWidget {
  const LiveChatTab({super.key});

  @override
  State<LiveChatTab> createState() => _LiveChatTabState();
}

class _LiveChatTabState extends State<LiveChatTab> {
  final List<String> _messages = [
    'أهلاً بك في خدمة العملاء لفندق ونادي Aura Grand.',
    'هل تحتاج إلى مساعدة في حجز الغرفة أو خدمات النادي؟',
  ];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add(_controller.text);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              bool isMe = index % 2 != 0;
              return Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe ? const Color(0xFF7B2CBF) : const Color(0xFF1B1A29),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(_messages[index], style: const TextStyle(color: Colors.white)),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          color: const Color(0xFF1B1A29),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'اكتب رسالتك هنا...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Color(0xFFC77DFF)),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 3. تبويب خزنة الأموال والتحكم الآمن
class MoneySafeTab extends StatefulWidget {
  const MoneySafeTab({super.key});

  @override
  State<MoneySafeTab> createState() => _MoneySafeTabState();
}

class _MoneySafeTabState extends State<MoneySafeTab> {
  bool _isUnlocked = false;
  double _balance = 125450.00;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF1B1A29),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _isUnlocked ? Colors.green : Colors.red, width: 2),
            ),
            child: Column(
              children: [
                Icon(
                  _isUnlocked ? Icons.lock_open : Icons.lock,
                  size: 64,
                  color: _isUnlocked ? Colors.green : Colors.redAccent,
                ),
                const SizedBox(height: 16),
                Text(
                  _isUnlocked ? 'الخزنة مفتوحة وآمنة' : 'الخزنة مقفلة برمز الحماية',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  _isUnlocked ? '\$ ${_balance.toStringAsFixed(2)}' : '**********',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFC77DFF)),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isUnlocked ? Colors.red.shade800 : Colors.green.shade800,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isUnlocked = !_isUnlocked;
                    });
                  },
                  icon: Icon(_isUnlocked ? Icons.lock : Icons.lock_open),
                  label: Text(_isUnlocked ? 'قفل الخزنة فوراً' : 'فتح الخزنة بالرقم السري'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('آخر المعاملات المالية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                _buildTransactionTile('حجز جناح ملكي - فندق', '+\$ 1,200.00', Colors.green),
                _buildTransactionTile('اشتراك شهري - النادي', '+\$ 350.00', Colors.green),
                _buildTransactionTile('مصاريف صيانة المساء', '-\$ 450.00', Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(String title, String amount, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1A29),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
