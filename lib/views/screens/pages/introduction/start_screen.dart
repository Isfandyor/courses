import 'package:flutter/material.dart';
import 'package:practice_home/views/screens/pages/introduction/login_screens/login/screens/login_page.dart';
import 'package:practice_home/views/screens/pages/introduction/login_screens/register/screens/register_page.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 90,
      //   leadingWidth: 50,
      // leading: Padding(
      //   padding: const EdgeInsets.only(top: 57, left: 24),
      //   child: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: SvgPicture.asset('assets/icons/back.svg'),
      //   ),
      // ),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              SizedBox(height: 90),
              Text(
                'Welcome to UpTodo',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  height: 3,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Text(
                  'Please login to your account or create new account to continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(170, 255, 255, 255),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 100),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => const LoginPage()));
                  },
                  child: Ink(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xff8875FF),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const RegisterPage(),
                      ),
                    );
                  },
                  child: Ink(
                    height: 48,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xff8875FF), width: 2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
