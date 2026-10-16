import 'package:flutter/material.dart';
import 'ai_assistant.dart';
import 'focus_session.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
        title: const Text('الرئيسية - المتفوق', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'مرحباً بك يا متفوق! 🚀',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 8),
            const Text(
              'اختر الأداة التي تساعدك على الإنجاز اليوم:',
              style: TextStyle(color: Colors.white70, fontSize: 14),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 24),

            // بطاقة جلسة التركيز
            Card(
              color: const Color(0xFF1E293B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: const Icon(Icons.timer_outlined, color: Color(0xFF6366F1), size: 36),
                title: const Text('بدء جلسة تركيز', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                subtitle: const Text('جلسة مذاكرة مغلقة ضد التشتت', style: TextStyle(color: Colors.white60, fontSize: 12)),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const FocusSessionScreen()));
                },
              ),
            ),
            const SizedBox(height: 16),

            // بطاقة مساعد الذكاء الاصطناعي
            Card(
              color: const Color(0xFF1E293B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: const Icon(Icons.smart_toy_outlined, color: Color(0xFF10B981), size: 36),
                title: const Text('مساعد الذكاء الاصطناعي', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                subtitle: const Text('طرح أسئلة وحلول دراسية ذكية', style: TextStyle(color: Colors.white60, fontSize: 12)),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AiAssistantScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
