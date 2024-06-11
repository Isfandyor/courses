import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practice_home/services/auth_http_services.dart';
import 'package:practice_home/views/screens/pages/introduction/login_screens/login/widgets/login_with_btn.dart';
import 'package:practice_home/views/screens/pages/introduction/login_screens/login/widgets/my_text_filed.dart';
import 'package:practice_home/views/screens/pages/introduction/login_screens/register/screens/register_page.dart';
import 'package:svg_flutter/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpServices();
  bool isLoading = false;

  late TapGestureRecognizer _pressGestureRecognizer;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late FocusNode usernameFocusNode;
  late FocusNode passwordFocusNode;

  bool isValidate = false;

  @override
  void initState() {
    super.initState();

    _pressGestureRecognizer = TapGestureRecognizer();
    _pressGestureRecognizer.onTap = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => const RegisterPage(),
        ),
      );
    };

    usernameController = TextEditingController();
    passwordController = TextEditingController();

    usernameController.addListener(_validateFields);
    passwordController.addListener(_validateFields);

    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _pressGestureRecognizer.dispose();
    usernameController.dispose();
    passwordController.dispose();

    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _validateFields() {
    setState(() {
      isValidate = usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    });
  }

  // void onTapLogin() {
  //   if (formKey.currentState!.validate()) {
  //     print(usernameController.text);
  //     print(passwordController.text);
  //   }
  // }

  void submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      showDialog(
        context: context,
        builder: (ctx) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      try {
        await _authHttpServices.login(
            usernameController.text, passwordController.text);
        // Navigator.pop(context);
        Navigator.pushReplacementNamed(
          context,
          'home',
        );
      } catch (e) {
        Navigator.pop(context);
        String message = e.toString();
        if (e.toString().contains("EMAIL_EXISTS")) {
          message = "Email mavjud";
        }
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Xatolik"),
              content: Text(message),
            );
          },
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
      // Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        leadingWidth: 50,
        leading: Padding(
          padding: const EdgeInsets.only(top: 57, left: 26),
          child: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'start_screen');
            },
            icon: SvgPicture.asset('assets/icons/back.svg'),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 27, right: 27, bottom: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  height: 4.5,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextFiled(
                    label: 'Email',
                    hintText: 'Enter your Email',
                    keyboardType: TextInputType.name,
                    controller: usernameController,
                    focusNode: usernameFocusNode,
                  ),
                  const SizedBox(height: 20),
                  MyTextFiled(
                    label: 'Password',
                    hintText: '••••••••••••',
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.075),
              InkWell(
                onTap: isValidate ? submit : null,
                child: Ink(
                  height: 48,
                  decoration: BoxDecoration(
                    color: isValidate
                        ? const Color(0xff8687E7)
                        : const Color(0xff8687E7).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: isValidate
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          fontSize: 16,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Divider(
                        thickness: 0.5,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "or",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Lato',
                          color: Color(0xff979797),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Divider(
                        thickness: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  LoginWithButton(
                    imagePath: 'assets/icons/google.svg',
                    label: 'Login with Google',
                    onTap: () {},
                  ),
                  const SizedBox(height: 25),
                  LoginWithButton(
                    imagePath: "assets/icons/apple.svg",
                    label: 'Login with Appe',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.080),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Don't have an account?   ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff535353),
                            fontFamily: 'Lato',
                          ),
                        ),
                        TextSpan(
                          text: 'Register',
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Lato',
                            color: Color.fromARGB(222, 255, 255, 255),
                          ),
                          recognizer: _pressGestureRecognizer,
                          mouseCursor: SystemMouseCursors.click,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
