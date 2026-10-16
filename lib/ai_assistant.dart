import 'package:flutter/material.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({Key? key}) : super(key: key);

  @override
  _AIAssistantScreenState createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      'role': 'ai',
      'text': 'أهلاً بك أيها المتفوق. أنا مساعدك الذكي المتخصص في الإجابة على الأسئلة الدراسية والعلمية فقط. كيف يمكنني مساعدتك في تحصيلك العلمي اليوم؟'
    }
  ];

  void _sendMessage() {
    String text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _controller.clear();

      // محاكاة الرد الذكي والدقيق للأسئلة العلمية فقط
      String aiResponse = _processAcademicQuery(text);
      _messages.add({'role': 'ai', 'text': aiResponse});
    });
  }

  String _processAcademicQuery(String query) {
    // تصفية المحتوى لضمان التركيز على الأسئلة المفيدة فقط
    if (query.contains('لعبة') || query.contains('نكتة') || query.contains('تسالي') || query.length < 3) {
      return 'عذراً، أنا مساعد أكاديمي مخصص حصرياً للإجابة على الأسئلة العلمية، الدراسية، وخطط الإنتاجية فقط. تفضل بسؤالي عن أي مسألة أو موضوع دراسي.';
    }
    return 'سؤال ممتاز! بناءً على المعطيات العلمية لـ "$query"، فإن الإجابة الدقيقة تعتمد على فهم المفاهيم الأساسية وتطبيقها بتركيز. هل تريد تفصيل هذه القاعدة أو حل مسألة مشابهة عليها؟';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('مساعد الذكاء الاصطناعي الأكاديمي', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1E293B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                bool isUser = _messages[index]['role'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.indigoAccent : const Color(0xFF334155),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _messages[index]['text']!,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xFF1E293B),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'اكتب سؤالك الدراسي هنا...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.indigoAccent),
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
