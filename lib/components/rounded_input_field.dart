import "package:flutter/material.dart";
import 'package:sac/components/input_container.dart';
import 'package:sac/constant.dart';

class InputRound extends StatelessWidget {
  final IconData icon;
  final ValueChanged<String> onchanged;
  final ValueChanged<String> validator;
  final InputDecoration deco;
  final TextEditingController controller;
  final TextInputType keyboardType;
  const InputRound({
    Key key,
    this.icon,
    this.onchanged,
    this.validator,
    this.deco,
    this.controller,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        cursorColor: kPrimaryColor,
        onChanged: onchanged,
        validator: validator,
        decoration: deco,

      ),
    );
  }
}