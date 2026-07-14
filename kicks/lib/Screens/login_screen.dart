import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidepassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset("assets/images/logo.png", width: 160, height: 160),

                SizedBox(height: 16),
                Text(
                  'Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 16),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your Email';
                    }
                    if (!value.contains('@')) {
                      return 'Enter a valid Email';
                    }

                    return null;
                  },

                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 24),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password_outlined),
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _hidepassword = !_hidepassword;
                        });
                      },
                      icon: Icon(
                        _hidepassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },

                  obscureText: _hidepassword,
                ),
                SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    if (_loginFormKey.currentState!.validate()){
                      //perform login  & navigate to home screen
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  child: Text('Login', style: TextStyle(color: Colors.white)),
                ),

                SizedBox(height: 2),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not yet registered?"),

                    TextButton(onPressed: () {}, child: Text("Sign Up")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
