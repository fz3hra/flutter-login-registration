import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/app/data/resources/auth_methods.dart';
import 'package:flutter_login/app/pages/registrationPage.dart';
import 'package:flutter_login/app/utils/colors.dart';
import 'package:flutter_login/app/utils/utils.dart';
import 'package:flutter_login/app/widgets/mainPage.dart';
import 'package:flutter_login/app/widgets/textField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose()
  {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signInUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signInUser(
      email: _emailController.text,
      password: _passwordController.text
    );
    if(res == "success")
      {
      //
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainPage()));
      }
    else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateSignUp() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegistrationPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2,),
              //  logo
              // const Image(image: NetworkImage('https://images.unsplash.com/photo-1546146830-2cca9512c68e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fGRldmVsb3BlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60')),
              const SizedBox(height: 64,),

              //  input fields (email address)
              TextFieldInput(
                  hintText: "Enter your email",
                  textEditingController: _emailController,
                  textInputType: TextInputType.emailAddress
              ),
              const SizedBox(height: 24,),
              //  input fields (password)
              TextFieldInput(
                  hintText: "Enter your Password",
                  textEditingController: _passwordController,
                  textInputType: TextInputType.text,
                  isPass: true,
              ),
              const SizedBox(height: 24,),
              //  text: dont have an account ? Regsiter
              Flexible(child: Container(), flex: 2),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: navigateSignUp,
                    child: Container(
                      child: Text("Dont have an account?"),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8
                      ),
                    ),
                  ),
                  Container(
                    child: const Text("Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24,),

              //  Sign in Button
              InkWell(
                onTap: signInUser,
                child: Container(
                  child: _isLoading ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      :const Text('Login', style: TextStyle(color: Colors.black),),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                    color: Colors.white
                  ),
                ),
              ),
              const SizedBox(height: 24,),
            ],
          ),
        ),
      ),
    );
  }
}
