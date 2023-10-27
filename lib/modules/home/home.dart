import 'package:flutter/material.dart';
import 'package:bike/modules/login/login.dart';
import 'package:bike/modules/signup/Signup.dart';
import 'package:bike/shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 100,
              ),
              Image.asset('assets/bike.png', scale: 2.5),
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Onboard',
                    style: TextStyle(
                      fontSize: 33.0,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                  Text(
                    ' D',
                    style: TextStyle(
                      fontSize: 37.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                  Text(
                    'iagnostic',
                    style: TextStyle(
                      fontSize: 33.0,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'System',
                    style: TextStyle(
                      fontSize: 33.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'It\'s a smart Ride for You!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              commonButton(
                text: 'Log In',
                function: () {
                  Navigator.pushNamed(context, 'login_screen');
                },
                color: Colors.teal,
                textcolor: Colors.black,
                fontsize: 40.0,
                border: 3.0,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 20,
              ),
              commonButton(
                text: 'Register',
                function: () {
                  Navigator.pushNamed(context, 'registration_screen');
                },
                color: Colors.teal,
                textcolor: Colors.black,
                fontsize: 40.0,
                border: 3.0,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
