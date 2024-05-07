import 'package:crop/services/messages.dart';
import 'package:crop/user.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List data = [];
  Messages msg = Messages();

  @override
  void initState() {
    super.initState();
    // Start a timer to refresh the data every 5 seconds
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _refreshData();
    });
  }

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _controller = ScrollController();

  void _addMessage(String message) async {
    Map<String, dynamic> body = {
      'sender': Provider.of<SignedInUser>(context, listen: false).id,
      'content': message,
    };
    await msg.send(body);
  }

  Future _getMessages() async {
    List<dynamic> messages = await msg.get();
    return messages;
  }

  Future<void> _refreshData() async {
    final newData = await _getMessages();
    Function deepEq = const DeepCollectionEquality().equals;
    if (!deepEq(newData, data)) {
      setState(() {
        data = newData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Farmer's Community"),
        FutureBuilder(
          future: _getMessages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final List<dynamic> messages = snapshot.data as List<dynamic>;
              SchedulerBinding.instance.addPostFrameCallback((_) {
                if (_controller.hasClients) {
                  _controller.animateTo(
                    _controller.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              });
              return Expanded(
                child: ListView.builder(
                    controller: _controller,
                    padding: const EdgeInsets.all(16.0),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      dynamic message = messages[index];
                      return _BuildMessageItem(
                          message: message['content'],
                          senderId: message['sender']);
                    }),
              );
            }
          },
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

class _BuildMessageItem extends StatelessWidget {
  final String message;
  final int senderId;

  const _BuildMessageItem({required this.message, required this.senderId});

  @override
  Widget build(BuildContext context) {
    int userId = Provider.of<SignedInUser>(context, listen: false).id;
    bool isReceived = (senderId == userId) ? false : true;
    var alignment =
        (senderId == userId) ? Alignment.centerRight : Alignment.centerLeft;
    var crossAlignment = (senderId == userId)
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: crossAlignment,
          children: [
            Text(senderId.toString()),
            const SizedBox(
              height: 5.0,
            ),
            ChatBubble(
              message: message,
              isReceived: isReceived,
            ),
            const SizedBox(
              height: 10.0,
            )
          ],
        ));
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isReceived;

  const ChatBubble(
      {super.key, required this.message, required this.isReceived});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: !isReceived
              ? const Color.fromARGB(255, 94, 160, 98)
              : Colors.grey[700],
          borderRadius: isReceived
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(16.0),
                  topRight: Radius.circular(16.0))
              : const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(20.0),
                )),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
