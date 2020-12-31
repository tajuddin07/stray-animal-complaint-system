import 'package:flutter/material.dart';
import 'package:sac/components/text_field_container.dart';
import 'package:sac/constant.dart';
import 'input_container.dart';


class InputPasswordRound extends StatefulWidget {
  final ValueChanged<String> onchanged;
  final ValueChanged<String> deco;
  final TextEditingController controller;
  final ValueChanged<String> validator;
  const InputPasswordRound({
    this.validator,
    this.onchanged,
    this.deco,
    this.controller,
    Key key,
  }) : super(key: key);

  @override
  _InputPasswordRoundState createState() => _InputPasswordRoundState();
}

class _InputPasswordRoundState extends State<InputPasswordRound> {
  bool hide=true;
  IconData icon= Icons.visibility_off;
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextFormField(
        onChanged: widget.onchanged,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: hide,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(Icons.lock,
            color: kPrimaryColor,),
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: (){
              setState(() {
                hide=!hide;
                if(icon==Icons.visibility){
                  icon = Icons.visibility_off;
                }
                else{
                  icon=Icons.visibility;
                }
              });
            },
            child: Icon(
              icon,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),

    );
  }
}