import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.amber,
        colorScheme: const ColorScheme.dark(
          primary: Colors.amber,
          secondary: Colors.amberAccent,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String serverStatus = 'جاري الاتصال بالسيرفر...';
  String ownerVault = '...';

  @override
  void initState() {
    super.initState();
    fetchServerData();
  }

  Future<void> fetchServerData() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          ownerVault = data['owner_vault']?.toString() ?? 'غير معروف';
          serverStatus = data['status']?.toString() ?? 'متصل';
        });
      } else {
        setState(() {
          serverStatus = 'خطأ في الاستجابة';
        });
      }
    } catch (e) {
      setState(() {
        serverStatus = 'فشل الاتصال بالسيرفر (تأكد من تشغيل Termux)';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aura Grand Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              color: Color(0xFF1E1E1E),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'مرحباً بك في أورا جراند',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'إدارة الخزنة، المتجر، والدردشة الحية بكفاءة عالية',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              color: const Color(0xFF1E1E1E),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('حالة السيرفر:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
                    const SizedBox(height: 5),
                    Text(serverStatus, style: const TextStyle(color: Colors.white)),
                    const Divider(color: Colors.grey),
                    const SizedBox(height: 5),
                    const Text('رصيد الخزنة (Owner Vault):', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
                    const SizedBox(height: 5),
                    Text(ownerVault, style: const TextStyle(fontSize: 20, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: fetchServerData,
              icon: const Icon(Icons.refresh),
              label: const Text('تحديث البيانات', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
