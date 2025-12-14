import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/common/navigator_key.dart';

Future<void> sendVrificationDialog({required void Function() onSend}) async {
  final BuildContext context = navigationKey.currentContext as BuildContext;
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: SendVrificationDialog(onSend: onSend),
      );
    },
  );
}

class SendVrificationDialog extends StatelessWidget {
  const SendVrificationDialog({
    super.key,
    required this.onSend,
  });

  final void Function() onSend;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Email not Virified",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(height: 20),
        const Text("Would you like to get another virification email ?"),
        SizedBox(
          height: context.screenHeight * .06,
          width: context.screenWidth * .5,
          child: MaterialButton(
            onPressed: onSend,
            color: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: borderRaduis(10.0),
            ),
            child: const Text("Send email"),
          ),
        )
      ],
    );
  }
}
