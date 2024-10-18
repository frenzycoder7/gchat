import 'package:flutter/material.dart';
import 'package:gchat/src/common/extensions/context.extension.dart';
import 'package:gchat/src/common/strings/image.strings.dart';
import 'package:gchat/src/modules/loginAndRegister/views/loginAndRegister.view.dart';

class UnAuthorizedWidget extends StatelessWidget {
  const UnAuthorizedWidget({super.key});

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
            child: Image.asset(
              ImageString.sessionExipre,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'UnAuthorized! Please login to continue.',
            style: context.theme.textTheme.bodyMedium?.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          context.customButton(
            text: "Go to Login",
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginAndRegister(),
                ),
              );
            },
            height: 40,
            width: 150,
            color: context.theme.primaryColor,
          )
        ],
      ),
    );
  }
}
