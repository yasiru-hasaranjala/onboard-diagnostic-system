import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bike/shared/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = TextEditingController();

  var test = TextEditingController();

  String password = '';
  var pass = TextEditingController();
  bool isPasswordVisible = true;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    email.addListener(() => setState(() {}));
  }

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Onboard ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 23.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'D',
              style: TextStyle(
                fontSize: 27.0,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
                color: Colors.black
              ),
            ),
            Text(
              'iagnostic System',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Column(
                children: [
                  Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 55.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    ' ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              /*email*/ textField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                hinttext: 'Email or Phone number',
                suffixIcon: email.text.isEmpty
                    ? Container(width: 0)
                    : IconButton(
                        icon: const Icon(Icons.close, size: 20.0, color: Colors.black),
                        onPressed: () => email.clear(),
                      ),
              ),
              const SizedBox(height: 10),
              /*password*/ textField(
                keyboardType: TextInputType.emailAddress,
                controller: pass,
                hinttext: 'Password',
                isPassword: true,
                suffixIcon: pass.text.isEmpty
                    ? Container(width: 0)
                    : IconButton(
                        icon: isPasswordVisible
                            ? const Icon(Icons.visibility_off, size: 20.0, color: Colors.black)
                            : const Icon(Icons.visibility, size: 20.0, color: Colors.black),
                        onPressed: () => setState(
                          () => isPasswordVisible = !isPasswordVisible,
                        ),
                      ),
                onChange: (value) => setState(() => password = value),
                isPasswordVisible: isPasswordVisible,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     TextButton(
              //       child: const Text(
              //         'Forgot password?',
              //         style: TextStyle(color: Colors.white),
              //       ),
              //       onPressed: () {},
              //     ),
              //   ],
              // ),
              const SizedBox(height: 20),
              /*login*/ commonButton(
                text: 'Log In',
                function: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email.text, password: password);
                      if (user != null) {
                        Navigator.pushNamed(context, 'home_screen');
                      }
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  }
                },
                fontsize: 25.0,
              ),
              const SizedBox(height: 20),
              const Column(
                children: [
                  Text('If you can\'t LogIn, Something is Incorrect'),
                  SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
