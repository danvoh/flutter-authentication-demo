import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(title: 'My Login Page'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _continueText = 'Continue without logging in';
  bool _clickAgain = true;
  bool _passwordVisible = false;
  bool _check = false;
  String _capsLockStatus = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Focus(
            onFocusChange: (value) {
              setState(() {
                if (HardwareKeyboard.instance.lockModesEnabled
                    .contains(KeyboardLockMode.capsLock)) {
                  setState(() {
                    _capsLockStatus = 'Caps Lock is ON';
                  });
                } else {
                  setState(() {
                    _capsLockStatus = '';
                  });
                }
              });
            },
            onKeyEvent: (node, event) {
              if (event.logicalKey == LogicalKeyboardKey.capsLock) {
                setState(() {
                  if (HardwareKeyboard.instance.lockModesEnabled
                      .contains(KeyboardLockMode.capsLock)) {
                    _capsLockStatus = 'Caps Lock is ON';
                  } else {
                    _capsLockStatus = '';
                  }
                });
              }
              return KeyEventResult.ignored;
            },
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                children: <Widget>[
                  const SizedBox(height: 80.0),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        filled: true, labelText: 'E-mail'),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        filled: true,
                        labelText: 'Password',
                        // ignore: prefer_const_constructors
                        suffixText: _capsLockStatus,
                        suffixStyle: const TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: Icon(_passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off))),
                    obscureText: !_passwordVisible,
                  ),
                  const SizedBox(height: 12.0),
                  CheckboxListTile(
                    title: const Text('Remember username?'),
                    value: _check,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (bool? value) {
                      setState(() {
                        _check = !_check;
                      });
                    },
                  ),
                  const SizedBox(height: 12.0),
                  OverflowBar(
                    alignment: MainAxisAlignment.end,
                    spacing: 25.0,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password?')),
                      TextButton(
                        onPressed: () {
                          if (_usernameController.text != '' &&
                              _passwordController.text != '') {
                            setState(() {
                              if (_clickAgain) {
                                _continueText =
                                    'Please click again to continue without logging in';
                              } else {
                                _continueText = 'Continue without logging in';
                                _usernameController.clear();
                                _passwordController.clear();
                              }
                              _clickAgain = !_clickAgain;
                            });
                          }
                        },
                        child: Text(_continueText),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _usernameController.clear();
                            _passwordController.clear();
                          },
                          child: const Text('LOG IN'))
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    children: const [
                      Expanded(
                        child: Divider(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Or login with:"),
                      ),
                      Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    IconButton(
                        icon: const Icon(Icons.facebook), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.apple), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.window), onPressed: () {})
                  ]),
                  const SizedBox(height: 12.0),
                  const Divider(),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Need an account?',
                        style: TextStyle(
                            fontSize: 16.0), // Adjust font size as needed
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()),
                            );
                          },
                          child: const Text('Sign Up')),
                    ],
                  ),
                ])));
  }
}
