import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practice_home/services/auth_http_services.dart';
import 'package:practice_home/views/screens/home_screen.dart';
import 'package:practice_home/views/screens/pages/introduction/login_screens/register/widgets/my_text_filed_reg.dart';
import 'package:practice_home/views/screens/pages/introduction/login_screens/register/widgets/register_with_btn.dart';
import 'package:svg_flutter/svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpServices();

  late TapGestureRecognizer _pressGestureRecognizer;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPaswordController;
  late FocusNode usernameFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode confirmPaswordFocusNode;

  bool isValidate = false;

  @override
  void initState() {
    super.initState();
    _pressGestureRecognizer = TapGestureRecognizer();
    _pressGestureRecognizer.onTap = () {
      Navigator.pop(context);
    };

    usernameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPaswordController = TextEditingController();

    usernameController.addListener(_validateFields);
    passwordController.addListener(_validateFields);
    confirmPaswordController.addListener(_validateFields);

    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPaswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _pressGestureRecognizer.dispose();
    usernameController.dispose();
    passwordController.dispose();

    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPaswordFocusNode.dispose();
    super.dispose();
  }

  // void onTapLogin() {
  //   if ((formKey.currentState as FormState).validate()) {
  //     print(usernameController.text);
  //     print(passwordController.text);
  //     print(confirmPaswordController);
  //   }
  // }

  bool isLoading = false;

  void submit() async {
    if ((formKey.currentState as FormState).validate()) {
      (formKey.currentState as FormState).save();

      //? Register
      showDialog(
        context: context,
        builder: (ctx) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        await _authHttpServices.register(
            usernameController.text, passwordController.text);

        Navigator.pushReplacementNamed(context, 'home');
      } catch (e) {
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
      Navigator.pop(context);
    }
  }

  void _validateFields() {
    setState(() {
      isValidate = usernameController.text.trim().isNotEmpty &&
          passwordController.text.trim().isNotEmpty &&
          confirmPaswordController.text.trim().isNotEmpty;
    });
  }

  // static String? usernameError;
  // static String? passwordError;
  // static String? confirmPasswordError;

  // void usernameValidation(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     usernameError = 'Please enter username';
  //   } else if (!value.contains(
  //     RegExp(r'^(?!.*\.\.)[a-zA-Z0-9._]{3,20}$'),
  //   )) {
  //     usernameError = 'Please enter valid username';
  //   } else {
  //     usernameError = null;
  //   }
  // }

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
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/icons/back.svg'),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 27, right: 27, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Register',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  height: 3.5,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextFiledRegister(
                    label: 'Email',
                    hintText: 'Enter your Email',
                    keyboardType: TextInputType.emailAddress,
                    controller: usernameController,
                    focusNode: usernameFocusNode,
                  ),
                  const SizedBox(height: 20),
                  MyTextFiledRegister(
                    label: 'Password',
                    hintText: '••••••••••••',
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                  ),
                  const SizedBox(height: 20),
                  MyTextFiledRegister(
                    label: 'Confirm Password',
                    hintText: '••••••••••••',
                    keyboardType: TextInputType.visiblePassword,
                    controller: confirmPaswordController,
                    focusNode: confirmPaswordFocusNode,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                        'Register',
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
                padding: EdgeInsets.symmetric(vertical: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Divider(
                        thickness: 0.5,
                      ),
                    ),
                    Text(
                      "or",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Lato',
                        color: Color(0xff979797),
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
                  RegisterWithBtn(
                    imagePath: 'assets/icons/google.svg',
                    label: 'Register with Google',
                    onTap: () {},
                  ),
                  const SizedBox(height: 25),
                  RegisterWithBtn(
                    imagePath: "assets/icons/apple.svg",
                    label: 'Register with Appe',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.030),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Already have an account?   ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff535353),
                            fontFamily: 'Lato',
                          ),
                        ),
                        TextSpan(
                          text: 'Login',
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
