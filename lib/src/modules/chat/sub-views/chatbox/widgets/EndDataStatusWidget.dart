import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gchat/src/core/api/api.enums.dart';
import 'package:gchat/src/modules/chat/sub-views/chatbox/cubit/chatbox_cubit.dart';

class EndMessageDataStatusWidget extends StatelessWidget {
  const EndMessageDataStatusWidget({super.key, required this.state});
  final ChatboxState state;
  @override
  Widget build(BuildContext context) {
    return state.status.isCalling
        ? Container(
            height: 25,
            width: 25,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: Colors.indigo,
              strokeWidth: 1,
            ),
          )
        : state.status.isAnyError
            ? Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(state.message),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<ChatboxCubit>().fetchMessages();
                    },
                    child: const Text('Retry'),
                  )
                ],
              )
            : state.canFetchMore == false
                ? Container(
                    alignment: Alignment.center,
                    child: const Text("No More data found"),
                  )
                : Container();
  }
}
