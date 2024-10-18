// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gchat/src/common/extensions/context.extension.dart';
import 'package:gchat/src/modules/chat/sub-views/chatbox/model/message.model.dart';
import 'package:gchat/src/modules/chat/sub-views/conversation_list/model/conversation.model.dart';
import 'package:intl/intl.dart';

class MessageBubbleWidget extends StatelessWidget {
  MessageBubbleWidget(
      {super.key, required this.conversation, required this.message});
  final Message message;
  final Conversation conversation;
  bool get isNotMe => message.from == conversation.userId;
  DateFormat formator = DateFormat('hh:mm:ss a');
  DateTime get d => DateTime.parse(message.createdAt);
  String get date =>
      formator.format(d.add(const Duration(hours: 5, minutes: 30)));

  @override
  Widget build(BuildContext context) {
    return message.type == "UPDATE"
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.pinkAccent.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message.text,
                style: context.theme.textTheme.bodyMedium,
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: MediaQuery.of(context).size.width,
            alignment: isNotMe ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              alignment: isNotMe ? Alignment.centerLeft : Alignment.centerRight,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                children: [
                  Container(
                    height: 15,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment:
                        isNotMe ? Alignment.centerLeft : Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: isNotMe
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [
                        isNotMe
                            ? Container()
                            : _messageStatusIcon(message.status, isNotMe),
                        const SizedBox(width: 5),
                        Text(
                          date,
                          style: context.theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment:
                        isNotMe ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: !isNotMe
                            ? Colors.blue
                            : context.theme.appBarTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(message.text,
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _messageStatusIcon(String status, bool showWhite) {
    switch (status) {
      case "SENT":
        return const Icon(
          Icons.check_circle_outline_outlined,
          size: 16,
        );
      case "DELIVERED":
        return const Icon(
          Icons.check_circle_rounded,
          size: 16,
        );
      case "READ":
        return const Icon(
          Icons.check_circle_rounded,
          color: Colors.green,
          size: 16,
        );
      case "PENDING":
        return const Icon(
          Icons.check_circle_outline_outlined,
          size: 16,
        );
      default:
        return Container();
    }
  }
}
