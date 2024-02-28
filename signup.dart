import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  String capsLockStatus = '';

  @override
  void initState() {
    super.initState();
    _emailFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Focus(
        onFocusChange: (value) {
          setState(() {
            if (HardwareKeyboard.instance.lockModesEnabled
                .contains(KeyboardLockMode.capsLock)) {
              setState(() {
                capsLockStatus = 'Caps Lock is ON';
              });
            } else {
              setState(() {
                capsLockStatus = '';
              });
            }
          });
        },
        onKeyEvent: (node, event) {
          if (event.logicalKey == LogicalKeyboardKey.capsLock) {
            setState(() {
              if (HardwareKeyboard.instance.lockModesEnabled
                  .contains(KeyboardLockMode.capsLock)) {
                capsLockStatus = 'Caps Lock is ON';
              } else {
                capsLockStatus = '';
              }
            });
          }
          return KeyEventResult.ignored;
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    focusNode: _emailFocusNode,
                    autofocus: true,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'E-mail',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your e-mail address.';
                      } else if (!value.contains('@')) {
                        return 'The e-mail address must contain the @ symbol.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Password',
                      suffixText: capsLockStatus,
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
                            : Icons.visibility_off),
                      ),
                    ),
                    obscureText: !_passwordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 10) {
                        return 'Password should be at least 10 characters.';
                      } else if (value.length > 20) {
                        return 'Password should not be greater than 20 characters.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5.0),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'The password must be between 10 and 20 characters long.',
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('SIGN UP'),
                    ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.facebook), onPressed: () {}),
                      IconButton(
                          icon: const Icon(Icons.apple), onPressed: () {}),
                      IconButton(
                          icon: const Icon(Icons.window), onPressed: () {})
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  const Divider(),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Log In'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
