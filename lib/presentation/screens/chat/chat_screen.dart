import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_buble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'http://sii.uveg.edu.mx/controlescolaruveg/resources/images/avatar.png'),
          ),
        ),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: ' My Chat ',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              WidgetSpan(
                child: Icon(
                  Icons.circle_rounded,
                  size: 18,
                  color: Color.fromARGB(255, 102, 255, 0),
                ), // Replace with your desired icon
              ),
            ],
          ),
        ),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatProvider.chatScrollController,
                itemCount: chatProvider.messageList.length,
                /*itemBuilder: (context, index) {
                      return (index % 2 == 0)
                          ? HerMessageBubble()
                          : MyMessageBubble();
                    },*/
                itemBuilder: (context, index) {
                  final message = chatProvider.messageList[index];

                  return (message.fromWho == FromWho.you)
                      ? HerMessageBubble(mensaje: message)
                      : MyMessageBubble(
                          message: message,
                        );
                },
              ),
            ),

            // Caja de texto
            MessageFieldBox(
              //onValue: (value) => chatProvider.sendMessage(value),
              onValue: chatProvider.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
