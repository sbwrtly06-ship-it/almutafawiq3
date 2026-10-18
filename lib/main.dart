import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool isFirstTime = prefs.getBool('is_first_time') ?? true;
  runApp(AlMutafawiqApp(isFirstTime: isFirstTime));
}

class AlMutafawiqApp extends StatelessWidget {
  final bool isFirstTime;
  const AlMutafawiqApp({Key? key, required this.isFirstTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق المتفوق',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF6366F1),
      ),
      home: isFirstTime ? const OnboardingScreen() : const MainHomeScreen(),
    );
  }
}

// 1. شاشة تسجيل الدخول / الترحيب الأولى (تظهر لأول مرة فقط)
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  Future<void> _finishOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_first_time', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainHomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, size: 100, color: Color(0xFF6366F1)),
              const SizedBox(height: 24),
              const Text(
                'أهلاً بك في تطبيق المتفوق',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'مساعدك الأكاديمي الشامل لجداول المذاكرة، جلسات التركيز، والمراجعة الذكية.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _finishOnboarding(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('ابدأ الانطلاق', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// الشاشة الرئيسية مع التنقل السفلي المنظم
class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardTab(),
    const FocusTimerTab(),
    const AIAssistantTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: const Color(0xFF1E293B),
        selectedItemColor: const Color(0xFF6366F1),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'الرئيسية والجداول'),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'جلسة التركيز'),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'المساعد الأكاديمي'),
        ],
      ),
    );
  }
}

// 2. لوحة التحكم الرئيسية وعرض الصور والجداول الأصلية بدقة
class DashboardTab extends StatelessWidget {
  const DashboardTab({Key? key}) : super(key: key);

  final List<String> myImages = const [
    'assets/images/file_0000000037c881f49b41687f48f122b9.png',
    'assets/images/file_00000000dcb081f48b5f5eb66e29f4e8.png',
    'assets/images/file_00000000ebf081f48549bc8ef97aeb19.png',
    'assets/images/file_00000000f04881f49888a9435e3b4682.png',
    'assets/images/file_00000000fb2881f483ab267660e3271e.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة المتفوق الأكاديمية وجداول المذاكرة'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('أهلاً بك يا مرتضى 👋', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 8),
                  Text('إليك جداولك الدراسية الأصلية وصورك المعتمدة للمراجعة.', style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('جداول المذاكرة والصور الأصلية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: myImages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      myImages[index],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Center(child: Text('تعذر تحميل الصورة، تحقق من المسار', style: TextStyle(color: Colors.grey))),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 3. جلسة التركيز (البومودورو)
class FocusTimerTab extends StatelessWidget {
  const FocusTimerTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('جلسة التركيز الدراسية'), backgroundColor: const Color(0xFF1E293B), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF6366F1), width: 8),
              ),
              child: const Center(
                child: Text('25:00', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 24),
            const Text('وقت المذاكرة المركز والممنهج', style: TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow),
              label: const Text('بدء الجلسة الآن'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. المساعد الأكاديمي (محادثة الذكاء الاصطناعي)
class AIAssistantTab extends StatefulWidget {
  const AIAssistantTab({Key? key}) : super(key: key);

  @override
  State<AIAssistantTab> createState() => _AIAssistantTabState();
}

class _AIAssistantTabState extends State<AIAssistantTab> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {'role': 'ai', 'text': 'أهلاً بك! أنا مساعدك الأكاديمي الذكي. اطرح أي سؤال علمي أو استفسار دراسي وسأساعدك فوراً.'}
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    final text = _controller.text;
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _messages.add({'role': 'ai', 'text': 'تم استلام استفسارك: "$text". جارٍ إعداد الشرح العلمي والدقيق لك.'});
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المساعد الأكاديمي والذكاء الاصطناعي'), backgroundColor: const Color(0xFF1E293B), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final isUser = _messages[index]['role'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFF6366F1) : const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(_messages[index]['text']!, style: const TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF1E293B),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'اسأل المساعد الأكاديمي...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF6366F1)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
