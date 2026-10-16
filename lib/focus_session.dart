import 'package:flutter/material.dart';

class FocusSessionScreen extends StatefulWidget {
  const FocusSessionScreen({Key? key}) : super(key: key);

  @override
  State<FocusSessionScreen> createState() => _FocusSessionScreenState();
}

class _FocusSessionScreenState extends State<FocusSessionScreen> {
  bool isRunning = true;

  @override
  Widget build(BuildContext context) {
    // استخدام PopScope لمنع زِر الرجوع في نظام أندرويد نهائياً
    return PopScope(
      canPop: false, // يمنع الرجوع للخلف تماماً
      onPopInvoked: (didPop) {
        if (!didPop) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('⚠️ جلسة التركيز نشطة! لا يمكنك الخروج حتى انتهاء الوقت.'),
              backgroundColor: Colors.redAccent,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false, // إخفاء سهم الرجوع العلوي
          title: const Text('جلسة التركيز المغلقة', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // شارة وضع القفل الصارم
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFEF4444)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.lock, color: Color(0xFFEF4444), size: 20),
                      SizedBox(width: 8),
                      Text('الوضع الصارم: التطبيقات محظورة', style: TextStyle(color: Color(0xFFEF4444), fontSize: 13, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                // العداد الدائري
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 240,
                      height: 240,
                      child: CircularProgressIndicator(
                        value: 0.75,
                        strokeWidth: 12,
                        backgroundColor: Colors.white10,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('25:00', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(height: 8),
                        Text('مذاكرة الرياضيات', style: TextStyle(fontSize: 14, color: Colors.white60)),
                      ],
                    ),
                  ],
                ),

                // رسالة التزام
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    '💪 لا استسلام! الالتزام الآن يركز عقلك ويبني مستقبلك.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),

                // زر التحكم بالعدّاد (بدون خيار الخروج)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isRunning ? const Color(0xFFF59E0B) : const Color(0xFF10B981),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      setState(() {
                        isRunning = !isRunning;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(isRunning ? Icons.pause : Icons.play_arrow, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          isRunning ? 'إيقاف مؤقت للجلسة' : 'استئناف التركيز',
                          style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
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
