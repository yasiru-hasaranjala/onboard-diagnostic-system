import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bike/shared/components/components.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final name = TextEditingController();

  final email = TextEditingController();

  final pass = TextEditingController();
  String password = '';
  bool isPasswordVisible = true;

  var formKey = GlobalKey<FormState>();
  String errorText = 'Can\'ot be empty';

  @override
  void initState() {
    super.initState();

    name.addListener(() => setState(() {}));
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
          top: 50,
          bottom: 10,
          right: 20,
          left: 20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              /*name*/ textField(
                controller: name,
                hinttext: 'Name',
                keyboardType: TextInputType.name,
                suffixIcon: name.text.isEmpty
                    ? Container(width: 0)
                    : IconButton(
                        icon: const Icon(Icons.close, size: 20.0, color: Colors.black),
                        onPressed: () => name.clear(),
                      ),
              ),
              const SizedBox(height: 15),
              /*email*/ textField(
                controller: email,
                hinttext: 'Email',
                keyboardType: TextInputType.emailAddress,
                suffixIcon: email.text.isEmpty
                    ? Container(width: 0)
                    : IconButton(
                        icon: const Icon(Icons.close, size: 20.0, color: Colors.black),
                        onPressed: () => email.clear(),
                      ),
              ),
              const SizedBox(height: 15),
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
              const SizedBox(height: 25),
              /*sign up*/ commonButton(
                text: 'Create',
                function: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email.text, password: password);
                      if (newUser != null) {
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
                  Text('If you can\'t SignUp, Something is Incorrect'),
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
