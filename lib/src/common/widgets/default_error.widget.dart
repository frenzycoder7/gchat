import 'package:flutter/material.dart';
import 'package:gchat/src/common/extensions/context.extension.dart';
import 'package:gchat/src/common/strings/image.strings.dart';

class DefaultError extends StatelessWidget {
  const DefaultError({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });
  final String errorMessage;
  final Function onRetry;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImageString.defaultError,
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 10),
          Text(
            errorMessage,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          context.customButton(
            text: "Retry",
            onTap: () {
              onRetry();
            },
            height: 40,
            width: 100,
            color: context.theme.primaryColor,
          ),
        ],
      ),
    );
  }
}
