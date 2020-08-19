import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool enabled;
  final ValueChanged<String> onChanged;
  final String hint;
  CustomTextField({this.enabled, this.onChanged, this.hint});
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          child: Card(
            child: TextField(
              keyboardType: TextInputType.text,
              autocorrect: true,
              enabled: enabled,
              onChanged: onChanged,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                hintText: hint,
              ),
            ),
          ),
        )
      ],
    );
  }
}
