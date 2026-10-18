import 'package:flutter/material.dart';

void main() {
  runApp(const AlMutafawiqApp());
}

class AlMutafawiqApp extends StatelessWidget {
  const AlMutafawiqApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق المتفوق',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF6366F1),
      ),
      home: const OnboardingSequenceScreen(),
    );
  }
}

// 1. تسلسل الشاشات والأزرار المفعلة بناءً على صورك الأصلية
class OnboardingSequenceScreen extends StatefulWidget {
  const OnboardingSequenceScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingSequenceScreen> createState() => _OnboardingSequenceScreenState();
}

class _OnboardingSequenceScreenState extends State<OnboardingSequenceScreen> {
  int currentStep = 1; // تبدأ من الصورة 1 وتتنقل عبر الأزرار

  void _nextStep() {
    if (currentStep < 3) {
      setState(() => currentStep++);
    } else {
      // عند التعدي والانتقال من الشاشات الأولى -> الذهاب للرئيسية وجلسة التركيز
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainHomeScreen()),
      );
    }
  }

  void _prevStep() {
    if (currentStep > 1) {
      setState(() => currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                currentStep == 1 ? 'شاشة الانطلاق والدخول' : 'عرض الجداول - الخطوة ${currentStep - 1}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 16),
              
              // عرض الصورة الحالية
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/$currentStep.png',
                      fit: BoxFit.contain,
                      errorBuilder: (c, e, s) => Center(
                        child: Text('الصورة رقم $currentStep', style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // الأزرار المفعلة للانتقال بين الشاشات
              Row(
                children: [
                  if (currentStep > 1)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _prevStep,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('السابق', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  if (currentStep > 1) const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        currentStep == 1
                            ? 'بدء الاستخدام الان'
                            : (currentStep == 3 ? 'الانتقال للرئيسية والتركيز' : 'التالي'),
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2. الشاشة الرئيسية: جلسة التركيز (مع خيار حظر التطبيقات) والمساعد الأكاديمي
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
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'جلسة التركيز وحظر التطبيقات'),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'المساعد الأكاديمي'),
        ],
      ),
    );
  }
}

// 3. جلسة التركيز المفعلة مع وضع حظر التشتت/التطبيقات
class FocusTimerTab extends StatefulWidget {
  const FocusTimerTab({Key? key}) : super(key: key);

  @override
  State<FocusTimerTab> createState() => _FocusTimerTabState();
}

class _FocusTimerTabState extends State<FocusTimerTab> {
  bool isAppBlockerActive = true;
  bool isTimerRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جلسة التركيز (المتفوق)'),
        backgroundColor: const Color(0xFF1E293B),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // مفتاح تفعيل حظر التطبيقات
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.block, color: Colors.redAccent),
                      SizedBox(width: 8),
                      Text('حظر التطبيقات المشتتة أثناء المذاكرة', style: TextStyle(color: Colors.white, fontSize: 13)),
                    ],
                  ),
                  Switch(
                    value: isAppBlockerActive,
                    activeColor: const Color(0xFF6366F1),
                    onChanged: (val) {
                      setState(() => isAppBlockerActive = val);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // دائر مؤقت البومودورو
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1E293B),
                border: Border.all(
                  color: isTimerRunning ? Colors.greenAccent : const Color(0xFF6366F1),
                  width: 8,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isTimerRunning ? '24:59' : '25:00',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isTimerRunning ? 'وضع المذاكرة نشط' : 'جاهز للمذاكرة',
                    style: TextStyle(color: isTimerRunning ? Colors.greenAccent : Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // زر بدء/إيقاف المؤقت وحظر التطبيقات
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() => isTimerRunning = !isTimerRunning);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isTimerRunning
                            ? (isAppBlockerActive ? 'تم بدء المذاكرة وتم تفعيل حظر التطبيقات!' : 'تم بدء المذاكرة!')
                            : 'تم إيقاف الجلسة',
                      ),
                      backgroundColor: isTimerRunning ? Colors.green : Colors.orange,
                    ),
                  );
                },
                icon: Icon(isTimerRunning ? Icons.pause : Icons.play_arrow),
                label: Text(
                  isTimerRunning ? 'إيقاف مؤقت' : 'بدء الجلسة وحظر التطبيقات',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isTimerRunning ? Colors.redAccent : const Color(0xFF6366F1),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. المساعد الأكاديمي
class AIAssistantTab extends StatefulWidget {
  const AIAssistantTab({Key? key}) : super(key: key);

  @override
  State<AIAssistantTab> createState() => _AIAssistantTabState();
}

class _AIAssistantTabState extends State<AIAssistantTab> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      'role': 'ai',
      'text': 'أهلاً بك يا مرتضى! أنا مساعدك الأكاديمي الذكي. تفضل بطرح أسئلتك الدراسية العلمية.'
    }
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    final text = _controller.text;
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      
      String aiReply = 'سؤالك حول "$text" يتطلب تطبيق القوانين والتحليل العلمي الدقيق. واصل اجتهادك!';
      if (text.contains('فيزياء') || text.contains('حركة') || text.contains('متجهات')) {
        aiReply = 'في الفيزياء والرياضيات، تحليل المتجهات والحركة يعتمد على القوانين الأساسية والتحليل الاتجاهي.';
      } else if (text.contains('ميكاترونكس') || text.contains('برمجة') || text.contains('تحكم')) {
        aiReply = 'في هندسة الميكاترونكس، أنظمة التحكم الذكية والخوارزميات تلعب الدور الأكبر في استقرار الأنظمة.';
      }

      _messages.add({'role': 'ai', 'text': aiReply});
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
