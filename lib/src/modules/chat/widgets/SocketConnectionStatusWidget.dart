import 'package:flutter/material.dart';
import 'package:gchat/src/common/extensions/context.extension.dart';
import 'package:gchat/src/modules/chat/cubit/chat_cubit.dart';
import 'package:gchat/src/modules/chat/enums/socket_status.enums.dart';

class SocketConnectionStatusWidget extends StatelessWidget {
  const SocketConnectionStatusWidget({super.key, required this.state});
  final ChatState state;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: context.appBackground,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('STATUS'),
          const SizedBox(width: 10),
          state.status.isConnected
              ? Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Connected",
                      style: context.theme.textTheme.bodyMedium,
                    )
                  ],
                )
              : const Text(
                  "Unable to connect to server",
                ),
        ],
      ),
    );
  }
}
