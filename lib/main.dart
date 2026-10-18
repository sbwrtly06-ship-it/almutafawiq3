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
      home: const StrictLoginOrWelcomeScreen(),
    );
  }
}

// 1. شاشة تسجيل الدخول / الترحيب الأولى (إجبارية ولا يمكن تخطيها إلا بالضغط هنا)
class StrictLoginOrWelcomeScreen extends StatelessWidget {
  const StrictLoginOrWelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'تسجيل الدخول / شاشة الترحيب',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 20),
              
              // الصورة الأولى الإجبارية للترحيب/التسجيل
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
                        'assets/images/file_0000000037c881f49b41687f48f122b9.png',
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => const Center(
                          child: Text('جاري تحميل شاشة الترحيب...', style: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // زر الدخول الإجباري للانتقال لباقي الجداول
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // الانتقال المحسوم بعد إتمام تسجيل الدخول / الترحيب
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SequentialImagesScreen()),
                    );
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('إتمام الدخول والانتقال للجداول', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2. شاشة عرض الصور والجداول الأصلية المتبقية واحدة تلو الأخرى بالأزرار
class SequentialImagesScreen extends StatefulWidget {
  const SequentialImagesScreen({Key? key}) : super(key: key);

  @override
  State<SequentialImagesScreen> createState() => _SequentialImagesScreenState();
}

class _SequentialImagesScreenState extends State<SequentialImagesScreen> {
  int currentImageIndex = 1; // تبدأ من الصورة الثانية لأن الأولى كانت للترحيب

  // باقي الصور الأصلية
  final List<String> remainingImages = [
    'assets/images/file_00000000dcb081f48b5f5eb66e29f4e8.png',
    'assets/images/file_00000000ebf081f48549bc8ef97aeb19.png',
    'assets/images/file_00000000f04881f49888a9435e3b4682.png',
    'assets/images/file_00000000fb2881f483ab267660e3271e.png',
  ];

  void _nextImage() {
    if (currentImageIndex < remainingImages.length - 1) {
      setState(() => currentImageIndex++);
    } else {
      // الانتقال النهائي للشاشة الرئيسية (جلسة التركيز والمساعد)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainHomeScreen()),
      );
    }
  }

  void _prevImage() {
    if (currentImageIndex > 0) {
      setState(() => currentImageIndex--);
    } else {
      // العودة لشاشة الترحيب إذا أراد المستخدم
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const StrictLoginOrWelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الجدول الأصلي (${currentImageIndex + 1} من ${remainingImages.length + 1})'),
        backgroundColor: const Color(0xFF1E293B),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                      remainingImages[currentImageIndex],
                      fit: BoxFit.contain,
                      errorBuilder: (c, e, s) => const Center(
                        child: Text('جاري تحميل الجدول...', style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _prevImage,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('السابق', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _nextImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      currentImageIndex == remainingImages.length - 1 ? 'الانتقال للرئيسية' : 'التالي',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 3. الشاشة الرئيسية: جلسة التركيز (تخصيص الوقت وحظر التطبيقات) والمساعد الأكاديمي
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

// 4. جلسة التركيز المخصصة
class FocusTimerTab extends StatefulWidget {
  const FocusTimerTab({Key? key}) : super(key: key);

  @override
  State<FocusTimerTab> createState() => _FocusTimerTabState();
}

class _FocusTimerTabState extends State<FocusTimerTab> {
  bool isAppBlockerActive = true;
  bool isTimerRunning = false;
  int selectedMinutes = 25;

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
              title: const Text('15 دقيقة', style: TextStyle(color: Colors.white70)),
              onTap: () { setState(() => selectedMinutes = 15); Navigator.pop(context); },
            ),
            ListTile(
              title: const Text('25 دقيقة (قياسي)', style: TextStyle(color: Colors.white)),
              onTap: () { setState(() => selectedMinutes = 25); Navigator.pop(context); },
            ),
            ListTile(
              title: const Text('45 دقيقة', style: TextStyle(color: Colors.white70)),
              onTap: () { setState(() => selectedMinutes = 45); Navigator.pop(context); },
            ),
            ListTile(
              title: const Text('60 دقيقة', style: TextStyle(color: Colors.white70)),
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
            OutlinedButton.icon(
              onPressed: isTimerRunning ? null : _showTimePickerModal,
              icon: const Icon(Icons.edit, color: Color(0xFF6366F1)),
              label: Text('وقت الجلسة: $selectedMinutes دقيقة (اضغط للتغيير)', style: const TextStyle(color: Colors.white)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF6366F1)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
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
                      Text('حظر التطبيقات المشتتة', style: TextStyle(color: Colors.white, fontSize: 13)),
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
                  isTimerRunning ? 'إيقاف الجلسة' : 'بدء الجلسة وحظر التطبيقات',
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

// 5. المساعد الأكاديمي
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
      'text': 'أهلاً بك يا مرتضى! أنا مساعدك الأكاديمي الذكي. اطرح أي سؤال علمي وسأجيبك فوراً.'
    }
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    final text = _controller.text;
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      
      String aiReply = 'بناءً على دراستك العلمية، سؤالك حول "$text" يتطلب تطبيق القوانين والتحليل السليم.';
      if (text.contains('فيزياء') || text.contains('حركة') || text.contains('متجهات')) {
        aiReply = 'في الفيزياء والرياضيات، تحليل المتجهات والحركة يعتمد على القوانين الأساسية والتحليل الاتجاهي.';
      } else if (text.contains('ميكاترونكس') || text.contains('برمجة') || text.contains('تحكم')) {
        aiReply = 'في هندسة الميكاترونكس، أنظمة التحكم الذكية والخوارزميات تلعب الدور الأكبر في استقرار الأجهزة.';
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
