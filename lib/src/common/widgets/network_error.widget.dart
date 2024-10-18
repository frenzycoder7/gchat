import 'package:flutter/material.dart';
import 'package:gchat/src/common/strings/image.strings.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({
    super.key,
    required this.onRetry,
  });
  final Function onRetry;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            alignment: Alignment.center,
            child: ClipRRect(
              child: Image.asset(
                ImageString.networkError,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text('Network Error! Please check your internet connection.'),
          ElevatedButton(
            onPressed: () {
              onRetry();
            },
            child: const Text("Retry"),
          )
        ],
      ),
    );
  }
}
