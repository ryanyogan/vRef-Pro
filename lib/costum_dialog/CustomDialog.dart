import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final Widget child;

  const CustomDialog({Key? key, required this.child}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: widget.child,
    );
  }
}
