import 'package:flutter/material.dart';
import 'package:gchat/src/common/extensions/context.extension.dart';

class ChatInputBoxWidget extends StatefulWidget {
  const ChatInputBoxWidget({
    super.key,
    required this.onMessage,
    required this.onChange,
  });
  final Function(String) onMessage;
  final Function(String) onChange;

  @override
  State<ChatInputBoxWidget> createState() => _ChatInputBoxWidgetState();
}

class _ChatInputBoxWidgetState extends State<ChatInputBoxWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: context.theme.appBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: InputBorder.none,
                hintMaxLines: 1,
              ),
              maxLines: 3,
              expands: false,
              minLines: 1,
              onChanged: (value) {
                value = value;
                widget.onChange(value);
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              widget.onMessage(controller.text);
              controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
