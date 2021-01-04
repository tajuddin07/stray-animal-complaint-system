import 'package:flutter/material.dart';
import 'package:sac/components/rounded_input_field.dart';
import 'package:sac/constant.dart';
import 'package:sac/components/rounded_password_field.dart';
import 'package:sac/viewModel/signup_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:sac/components/busybutton.dart';

class SignUpView extends StatelessWidget {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController PhoneNoCtrl = TextEditingController();
  bool dataFilled = false;

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return ViewModelBuilder<SignUpViewModel>.reactive(
         viewModelBuilder: () => SignUpViewModel(),

           builder: (context, model, child) => Scaffold(
            body: Padding(

                 padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(

            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                  Text(
                        "SIGNUP",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height*0.03),
                      InputRound(
                        controller: emailCtrl,
                        deco: InputDecoration(
                          hintText: 'Email',
                          border: InputBorder.none,
                          icon: Icon(Icons.email,color: kPrimaryColor,)
                        ),
                      ),
                      SizedBox(height: size.height*0.03),
                      InputRound(
                        controller: emailCtrl,
                        deco: InputDecoration(
                            hintText: 'Name',
                            border: InputBorder.none,
                            icon: Icon(Icons.people,color: kPrimaryColor,)
                        ),
                      ),
                      SizedBox(height: size.height*0.03),
                      InputPasswordRound(
                        controller: passwordCtrl,

                        ),
                      SizedBox(height: size.height*0.03),
                      InputRound(
                        controller: PhoneNoCtrl,
                        deco: InputDecoration(
                            hintText: 'Phone Number',
                            border: InputBorder.none,
                            icon: Icon(Icons.email,color: kPrimaryColor,)
                        ),
                      ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BusyButton(
                    title: 'Sign Up',
                    busy: model.busy,
                    onPressed: () {
                      model.signUp(
                          email: emailCtrl.text,
                          password: passwordCtrl.text,
                          fullName: nameCtrl.text);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}




