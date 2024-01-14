import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:greenpurse/utils/colors.dart';
import 'package:greenpurse/utils/const.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({super.key});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  final _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(
        receiveTimeout: const Duration(
      seconds: 5,
    )),
    enableLog: true,
  );

  final ChatUser _currentUser =
      ChatUser(id: '1', firstName: "Jane", lastName: "Doe");

  final ChatUser _greenBotUser =
      ChatUser(id: '2', firstName: "Green", lastName: "Bot");

  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/green_purse_logo.png"),
        title: const Text("Green Bot",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            )),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CartPage(),
                //   ),
                // );
              },
              icon: const Icon(Icons.headphones))
        ],
      ),
      body: DashChat(
        currentUser: _currentUser,
        typingUsers: _typingUsers,
        messageOptions: MessageOptions(
          currentUserContainerColor: AppColors.grey,
          containerColor: AppColors.green,
          textColor: AppColors.whitish,
        ),
        onSend: (ChatMessage message) {
          getChatResponse(message);
        },
        messages: _messages,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage message) async {
    setState(() {
      _messages.insert(0, message);
      _typingUsers.add(_greenBotUser);
    });
    List<Messages> _messagesHistory = _messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();
    final request = ChatCompleteText(
        model: GptTurbo0301ChatModel(),
        messages: _messagesHistory,
        maxToken: 300);
    final response = await _openAI.onChatCompletion(request: request);

    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
              0,
              ChatMessage(
                  user: _greenBotUser,
                  createdAt: DateTime.now(),
                  text: element.message!.content));
        });
      }
    }
    setState(() {
      _typingUsers.remove(_greenBotUser);
    });
  }
}
