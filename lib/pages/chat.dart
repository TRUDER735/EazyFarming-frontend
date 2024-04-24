import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = ['hello', 'zvirisei', 'habho baba'];

  void _addMessage(String message) {
    setState(() {
      _messages.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Farmer's Community"),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              return _buildMessageItem(message: _messages[index], sender: 'sender@username.com1');
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your message...',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  String message = _messageController.text;
                  if (message.isNotEmpty) {
                    _addMessage(message);
                    _messageController.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _buildMessageItem extends StatelessWidget {
  final String message;
  final String sender;

  const _buildMessageItem({required this.message, required this.sender});

  @override
  Widget build(BuildContext context) {
    var alignment = (sender == 'sender@username.com')
        ? Alignment.centerRight
        : Alignment.centerLeft;
    var crossAlignment = (sender == 'sender@username.com')
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: crossAlignment,
          children: [
            Text(sender),
            const SizedBox(
              height: 5.0,
            ),
            ChatBubble(message: message),
            const SizedBox(
              height: 10.0,
            )
          ],
        ));
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.green[700],
          borderRadius: const BorderRadius.all(Radius.circular(16.0))),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
