import 'package:assignment12_front_end/presentation/widgets/link_button.dart';
import 'package:flutter/material.dart';

class GenericDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function onConfirm;
  final String confirmButtonText;
  final String cancelButtonText;

  const GenericDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.confirmButtonText,
    required this.cancelButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        LinkButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: cancelButtonText,
        ),
        LinkButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          text: confirmButtonText,
        ),
      ],
    );
  }
}
