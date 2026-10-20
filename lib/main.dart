import 'package:flutter/material.dart';

void main() {
  runApp(const AlMutafawiqApp());
}

class AlMutafawiqApp extends StatelessWidget {
  const AlMutafawiqApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'المتفوق',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo',
        primaryColor: const Color(0xFF6C3FD9),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF6C3FD9),
          secondary: const Color(0xFF172B4D),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

// ==========================================
// 1. شاشة البداية والترحيب
// ==========================================
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.school, size: 40, color: Color(0xFF6C3FD9)),
                    SizedBox(width: 8),
                    Text(
                      'المتفوق',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF172B4D)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'طريقك نحو التفوق يبدأ من هنا',
                  style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0EBFB),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/file_0000000037c881f49b41687f48f122b9.png',
                          fit: BoxFit.contain,
                          errorBuilder: (c, e, s) => const Icon(Icons.school_outlined, size: 120, color: Color(0xFF6C3FD9)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C3FD9),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 2,
                    ),
                    child: const Text('ابدأ رحلتك الآن', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF6C3FD9), width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('تسجيل الدخول', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF6C3FD9))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 2. شاشات إنشاء الحساب وتسجيل الدخول
// ==========================================
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Color(0xFF172B4D))),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('إنشاء حساب جديد', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF172B4D))),
              const SizedBox(height: 8),
              const Text('ابدأ رحلتك نحو التفوق وتنظيم وقتك', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 30),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'الاسم الكامل',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // الانتقال لمعالج الإعداد
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SetupGoalScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C3FD9),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('إنشاء الحساب ومتابعة الإعداد', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Color(0xFF172B4D))),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('تسجيل الدخول', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF172B4D))),
              const SizedBox(height: 8),
              const Text('مرحباً بعودتك! استكمل رحلة تفوقك', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainHomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C3FD9),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('دخول', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 3. رحلة الإعداد الأولي (تحديد مدة المذاكرة)
// ==========================================
class SetupGoalScreen extends StatefulWidget {
  const SetupGoalScreen({Key? key}) : super(key: key);

  @override
  State<SetupGoalScreen> createState() => _SetupGoalScreenState();
}

class _SetupGoalScreenState extends State<SetupGoalScreen> {
  int selectedMinutes = 120;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LinearProgressIndicator(value: 0.33, backgroundColor: Color(0xFFE2E8F0), color: Color(0xFF6C3FD9)),
                const SizedBox(height: 24),
                const Text('ما مدة المذاكرة اليومية التي تناسبك؟', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF172B4D))),
                const SizedBox(height: 8),
                const Text('اختر المدة التي تريد أن تذاكرها كل يوم لتحقيق هدفك.', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [30, 60, 90, 120, 180, 240].map((mins) {
                    final isSelected = selectedMinutes == mins;
                    return ChoiceChip(
                      label: Text(mins >= 60 ? '${mins ~/ 60} ساعة' : '$mins دقيقة'),
                      selected: isSelected,
                      selectedColor: const Color(0xFF6C3FD9),
                      labelStyle: TextStyle(color: isSelected ? Colors.white : const Color(0xFF172B4D), fontWeight: FontWeight.bold),
                      onSelected: (val) {
                        setState(() => selectedMinutes = mins);
                      },
                    );
                  }).toList(),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SetupAppBlockerScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C3FD9),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('التالي', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 4. اختيار التطبيقات المحظورة
// ==========================================
class SetupAppBlockerScreen extends StatefulWidget {
  const SetupAppBlockerScreen({Key? key}) : super(key: key);

  @override
  State<SetupAppBlockerScreen> createState() => _SetupAppBlockerScreenState();
}

class _SetupAppBlockerScreenState extends State<SetupAppBlockerScreen> {
  final Map<String, bool> _apps = {
    'YouTube': true,
    'Instagram': true,
    'TikTok': true,
    'Facebook': false,
    'WhatsApp': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LinearProgressIndicator(value: 0.66, backgroundColor: Color(0xFFE2E8F0), color: Color(0xFF6C3FD9)),
                const SizedBox(height: 24),
                const Text('اختر التطبيقات المشتتة للانتباه', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF172B4D))),
                const SizedBox(height: 8),
                const Text('سيتم تقييد الوصول لهذه التطبيقات أثناء جلسة التركيز.', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: _apps.keys.map((appName) {
                      return CheckboxListTile(
                        title: Text(appName, style: const TextStyle(fontWeight: FontWeight.bold)),
                        value: _apps[appName],
                        activeColor: const Color(0xFF6C3FD9),
                        onChanged: (val) {
                          setState(() => _apps[appName] = val ?? false);
                        },
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainHomeScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C3FD9),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('تفعيل وضع التركيز والانطلاق', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 5. الواجهة الرئيسية والجلسات والمساعد الذكي
// ==========================================
class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const FocusTimerTab(),
    const AIAssistantTab(),
    const AnalyticsTab(),
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
        selectedItemColor: const Color(0xFF6C3FD9),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'جلسة التركيز'),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'المساعد الذكي'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'الإحصائيات'),
        ],
      ),
    );
  }
}

class FocusTimerTab extends StatefulWidget {
  const FocusTimerTab({Key? key}) : super(key: key);

  @override
  State<FocusTimerTab> createState() => _FocusTimerTabState();
}

class _FocusTimerTabState extends State<FocusTimerTab> {
  bool isTimerRunning = false;
  bool isAppBlockerActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جلسة التركيز بومودورو'),
        backgroundColor: const Color(0xFF6C3FD9),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('تفعيل حظر التطبيقات المشتتة', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF172B4D))),
                Switch(
                  value: isAppBlockerActive,
                  activeColor: const Color(0xFF6C3FD9),
                  onChanged: (val) => setState(() => isAppBlockerActive = val),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF0EBFB),
                border: Border.all(color: isTimerRunning ? Colors.green : const Color(0xFF6C3FD9), width: 8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isTimerRunning ? '24:59' : '25:00',
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Color(0xFF172B4D)),
                    ),
                    Text(
                      isTimerRunning ? 'التركيز نشط' : 'جاهز للمذاكرة',
                      style: TextStyle(color: isTimerRunning ? Colors.green : Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() => isTimerRunning = !isTimerRunning);
                },
                icon: Icon(isTimerRunning ? Icons.pause : Icons.play_arrow),
                label: Text(
                  isTimerRunning ? 'إيقاف الجلسة' : 'بدء جلسة التركيز',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isTimerRunning ? Colors.redAccent : const Color(0xFF6C3FD9),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AIAssistantTab extends StatefulWidget {
  const AIAssistantTab({Key? key}) : super(key: key);

  @override
  State<AIAssistantTab> createState() => _AIAssistantTabState();
}

class _AIAssistantTabState extends State<AIAssistantTab> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {'role': 'ai', 'text': 'مرحباً بك! أنا مساعدك الأكاديمي الذكي في منصة المتفوق. اطرح أي سؤال علمي أو دراسي.'}
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    final text = _controller.text;
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _messages.add({'role': 'ai', 'text': 'سؤالك حول "$text" مهم جداً. في الفيزياء والرياضيات والميكاترونكس، نعتمد على التحليل المنطقي والقوانين العلمية الأساسية.'});
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المساعد الأكاديمي الذكي'), backgroundColor: const Color(0xFF6C3FD9), centerTitle: true),
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
                      color: isUser ? const Color(0xFF6C3FD9) : const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(_messages[index]['text']!, style: TextStyle(color: isUser ? Colors.white : const Color(0xFF172B4D))),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'اسأل عن المناهج والفيزياء...', border: InputBorder.none),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send, color: Color(0xFF6C3FD9)), onPressed: _sendMessage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnalyticsTab extends StatelessWidget {
  const AnalyticsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإحصائيات والتقدم'), backgroundColor: const Color(0xFF6C3FD9), centerTitle: true),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('إجمالي ساعات المذاكرة اليوم'),
                subtitle: Text('2 ساعة و 15 دقيقة'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.block, color: Colors.red),
                title: Text('محاولات التشتت الممنوعة'),
                subtitle: Text('3 محاولات'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
