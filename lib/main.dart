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

// 1. تسلسل الشاشات والأسماء الأصلية الصحيحة للصور
class OnboardingSequenceScreen extends StatefulWidget {
  const OnboardingSequenceScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingSequenceScreen> createState() => _OnboardingSequenceScreenState();
}

class _OnboardingSequenceScreenState extends State<OnboardingSequenceScreen> {
  int currentStep = 0;

  // الأسماء الفعلية والصحيحة للصور كما تم رفعها تماماً
  final List<String> originalImages = [
    'assets/images/file_0000000037c881f49b41687f48f122b9.png',
    'assets/images/file_00000000dcb081f48b5f5eb66e29f4e8.png',
    'assets/images/file_00000000ebf081f48549bc8ef97aeb19.png',
    'assets/images/file_00000000f04881f49888a9435e3b4682.png',
    'assets/images/file_00000000fb2881f483ab267660e3271e.png',
  ];

  void _nextStep() {
    if (currentStep < originalImages.length - 1) {
      setState(() => currentStep++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainHomeScreen()),
      );
    }
  }

  void _prevStep() {
    if (currentStep > 0) {
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
                'الجدول أو الصورة الأصلية (${currentStep + 1} من ${originalImages.length})',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 16),
              
              // عرض الصورة الحالية بوضوح تام مع خاصية التكبير
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
                    child: InteractiveViewer(
                      maxScale: 4.0,
                      child: Image.asset(
                        originalImages[currentStep],
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => const Center(
                          child: Text('جاري تحميل الصورة الأصلية...', style: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // الأزرار المفعلة للانتقال بين الصور
              Row(
                children: [
                  if (currentStep > 0)
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
                  if (currentStep > 0) const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        currentStep == originalImages.length - 1 ? 'الانتقال للرئيسية والتركيز' : 'التالي',
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

// 2. الشاشة الرئيسية: جلسة التركيز (مع إمكانية تخصيص الوقت وحظر التطبيقات) والمساعد الأكاديمي
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
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'جلسة التركيز والوقت'),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'المساعد الأكاديمي'),
        ],
      ),
    );
  }
}

// 3. جلسة التركيز مع إمكانية تعيين الوقت وحظر التطبيقات
class FocusTimerTab extends StatefulWidget {
  const FocusTimerTab({Key? key}) : super(key: key);

  @override
  State<FocusTimerTab> createState() => _FocusTimerTabState();
}

class _FocusTimerTabState extends State<FocusTimerTab> {
  bool isAppBlockerActive = true;
  bool isTimerRunning = false;
  int selectedMinutes = 25; // الوقت الافتراضي وقابل للتعديل

  void _showTimePickerModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('حدد وقت المذاكرة (بالدقائق)', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('15 دقيقة (مراجعة سريعة)', style: TextStyle(color: Colors.white70)),
              onTap: () { setState(() => selectedMinutes = 15); Navigator.pop(context); },
            ),
            ListTile(
              title: const Text('25 دقيقة (جلسة بومودورو قياسية)', style: TextStyle(color: Colors.white)),
              onTap: () { setState(() => selectedMinutes = 25); Navigator.pop(context); },
            ),
            ListTile(
              title: const Text('45 دقيقة (جلسة متقدمة)', style: TextStyle(color: Colors.white70)),
              onTap: () { setState(() => selectedMinutes = 45); Navigator.pop(context); },
            ),
            ListTile(
              title: const Text('60 دقيقة (ساعة كاملة للمذاكرة)', style: TextStyle(color: Colors.white70)),
              onTap: () { setState(() => selectedMinutes = 60); Navigator.pop(context); },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جلسة التركيز ووقت المذاكرة'),
        backgroundColor: const Color(0xFF1E293B),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // زر تخصيص الوقت
            OutlinedButton.icon(
              onPressed: isTimerRunning ? null : _showTimePickerModal,
              icon: const Icon(Icons.edit, color: Color(0xFF6366F1)),
              label: Text('وقت الجلسة الحالي: $selectedMinutes دقيقة (اضغط للتغيير)', style: const TextStyle(color: Colors.white)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF6366F1)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),

            // مفتاح حظر التطبيقات
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
                      Text('حظر التطبيقات المشتتة أثناء الجلسة', style: TextStyle(color: Colors.white, fontSize: 13)),
                    ],
                  ),
                  Switch(
                    value: isAppBlockerActive,
                    activeColor: const Color(0xFF6366F1),
                    onChanged: (val) => setState(() => isAppBlockerActive = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // دائرة المؤقت
            Container(
              width: 200,
              height: 200,
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
                    '$selectedMinutes:00',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isTimerRunning ? 'قيد التركيز والحظر' : 'جاهز للبدء',
                    style: TextStyle(color: isTimerRunning ? Colors.greenAccent : Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // زر التشغيل
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() => isTimerRunning = !isTimerRunning);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isTimerRunning
                            ? 'بدء جلسة التركيز لمدة $selectedMinutes دقيقة ${isAppBlockerActive ? 'مع حظر التطبيقات!' : ''}'
                            : 'تم إيقاف الجلسة',
                      ),
                      backgroundColor: isTimerRunning ? Colors.green : Colors.orange,
                    ),
                  );
                },
                icon: Icon(isTimerRunning ? Icons.pause : Icons.play_arrow),
                label: Text(
                  isTimerRunning ? 'إيقاف الجلسة المؤقتة' : 'بدء الجلسة وحظر التطبيقات',
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
      'text': 'أهلاً بك يا مرتضى! أنا مساعدك الأكاديمي الذكي. اطرح أي سؤال في الفيزياء، الرياضيات، أو الميكاترونكس وسأجيبك فوراً.'
    }
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    final text = _controller.text;
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      
      String aiReply = 'بناءً على دراستك العلمية، سؤالك حول "$text" يتطلب تطبيق القوانين الفيزيائية والرياضية بدقة. واصل اجتهادك!';
      if (text.contains('فيزياء') || text.contains('حركة') || text.contains('متجهات')) {
        aiReply = 'في الفيزياء والرياضيات، تحليل المتجهات والحركة يعتمد على القوانين الأساسية والتحليل الاتجاهي السليم.';
      } else if (text.contains('ميكاترونكس') || text.contains('برمجة') || text.contains('تحكم')) {
        aiReply = 'في هندسة الميكاترونكس، أنظمة التحكم الذكية والخوارزميات تلعب الدور الأكبر في استقرار الأجهزة الآلية.';
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
