import 'package:flutter/material.dart';
import 'package:money_cases/constants/controllers.dart';

class SignUpScreen extends StatefulWidget {
  static String route = "/signupscreen";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _nameEditingController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        const Text("Enter Name"),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _nameEditingController,
                          focusNode: _nameFocusNode,
                          decoration: InputDecoration(
                              hintText: "Usama Ilyas",
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10))),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter name";
                            } else {
                              return null;
                            }
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_emailFocusNode);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Enter Email"),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailEditingController,
                          decoration: InputDecoration(
                              hintText: "usama@gmail.com",
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10))),
                          focusNode: _emailFocusNode,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_phoneFocusNode);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a valid email";
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return "Please enter a valid email";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Enter Phone Number"),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _phoneEditingController,
                          focusNode: _phoneFocusNode,
                          decoration: InputDecoration(
                              hintText: "03124239875",
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10))),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter phone number";
                            } else if (value.length != 11) {
                              return "Please enter a valid phone number";
                            } else if (value[0] != "0" && value[1] != "3") {
                              return "Please enter a valid phone number";
                            } else {
                              return null;
                            }
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Enter Password"),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: _passwordEditingController,
                          focusNode: _passwordFocusNode,
                          decoration: InputDecoration(
                              hintText: "Your Password",
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10))),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter password";
                            } else if (value.length < 8) {
                              return "Password must not less than 8 characters";
                            } else {
                              return null;
                            }
                          },
                          onFieldSubmitted: (value) {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            child: const Text("Sign Up"),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                authController.signup(
                                    email: _emailEditingController.text,
                                    password: _passwordEditingController.text,
                                    phoneNumber: _phoneEditingController.text,
                                    name: _nameEditingController.text);
                              } else {}
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?"),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/", (route) => false);
                              },
                            )
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
