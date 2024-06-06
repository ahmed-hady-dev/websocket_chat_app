import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:websocket_chat_app/main.dart';
import 'package:websocket_chat_app/widgets/avatar.dart';

import '../widgets/message_bubble.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key, required this.chatRoom});
  final ChatRoom chatRoom;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final messageController = TextEditingController();
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentParticipant = widget.chatRoom.participants.firstWhere(
      (user) => user.id == userId1,
    );
    final otherParticipant = widget.chatRoom.participants.firstWhere(
      (user) => user.id != currentParticipant.id,
    );
    final viewInsets = MediaQuery.viewInsetsOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: <Widget>[
            Avatar(imageUrl: otherParticipant.avatarUrl, radius: 18),
            Text(
              otherParticipant.username,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          const SizedBox(width: 8.0),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0, bottom: (viewInsets.bottom > 0) ? 10 : 6),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final showImage =
                        (index + 1 == messages.length) || (messages[index + 1].senderUserId != message.senderUserId);
                    return Row(
                      mainAxisAlignment:
                          (messages[index].senderUserId == userId1) ? MainAxisAlignment.start : MainAxisAlignment.end,
                      children: [
                        if (showImage && message.senderUserId == userId1)
                          Avatar(imageUrl: currentParticipant.avatarUrl, radius: 18),
                        MessageBubble(message: message),
                        if (showImage && message.senderUserId != userId1)
                          Avatar(imageUrl: otherParticipant.avatarUrl, radius: 18),
                      ],
                    );
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  IconButton(onPressed: () {}, icon: const Icon(Icons.attach_file)),
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primary.withAlpha(100),
                        hintText: 'Type a message',
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(16.0), borderSide: BorderSide.none),
                        suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
