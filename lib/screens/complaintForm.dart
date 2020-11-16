import 'package:flutter/material.dart';
import 'package:sac/components/rounded_input_field.dart';
import 'package:sac/components/rounded_button.dart';
import 'package:sac/screens/signup/signup.dart';

class complaintForm extends StatefulWidget {
  @override
  _complaintFormState createState() => _complaintFormState();
}

class _complaintFormState extends State<complaintForm> {
  @override
  int _value =1;
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Container(

      color: Colors.blue[100],
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height*0.05),
            Text(
              "Issue Complaint",
              style: TextStyle(fontSize: 42,fontWeight: FontWeight.bold,color: Colors.black),
            ),
            SizedBox(height: size.height*0.05),
            DropdownButton(
                value:_value,
                items: [
                  DropdownMenuItem(child: Text("Cat"),value: 1,),
                  DropdownMenuItem(child: Text("Dog"),value: 2,),
                ],
                onChanged: (value){
                  setState(() {
                    _value=value;
                  });
                }),

            SizedBox(height: size.height*0.5),
            RoundedInputField(
              hintText: "Subject",
              onChanged: (value){},
            ),
            RoundedButton(
              text: "Next",
              color: Colors.white60,
              textColor: Colors.black,
              press: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUp();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
