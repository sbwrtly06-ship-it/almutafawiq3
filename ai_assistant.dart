import 'package:flutter/material.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({Key? key}) : super(key: key);

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {"sender": "ai", "text": "أهلاً بك يا بطل! أنا مساعدك الذكي في تطبيق المتفوق. كيف يمكنني مساعدتك في دراستك اليوم؟ 🤖📚"}
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    String userMessage = _controller.text;
    setState(() {
      _messages.add({"sender": "user", "text": userMessage});
      // محاكاة رد الذكاء الاصطناعي (يمكن ربطه بـ API لاحقاً)
      _messages.add({
        "sender": "ai", 
        "text": "سؤال ممتاز حول '$userMessage'! استمر في التركيز، أنصحك بتقسيم هذه الفكرة إلى خطوات صغيرة لتفهمها بشكل أفضل."
      });
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
        title: const Text('مساعد الذكاء الاصطناعي', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                bool isAi = _messages[index]["sender"] == "ai";
                return Align(
                  alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isAi ? const Color(0xFF1E293B) : const Color(0xFF6366F1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _messages[index]["text"]!,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
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
                      hintText: 'اسأل مساعد الذكاء الاصطناعي سؤالاً دراسياً...',
                      hintStyle: TextStyle(color: Colors.white60),
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
