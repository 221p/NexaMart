import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/Const/my_validators.dart';
import 'package:flutter_application_1/Screens/auth/forgot_password.dart';
import 'package:flutter_application_1/Screens/auth/register.dart';
import 'package:flutter_application_1/Screens/loading_manager.dart';
import 'package:flutter_application_1/Widgets/app_name_text.dart';
import 'package:flutter_application_1/Widgets/auth/google_button.dart';
import 'package:flutter_application_1/root_screen.dart';
import 'package:flutter_application_1/services/my_app_methods.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loginFct() async {
    FocusScope.of(context).unfocus();
    try {
      setState(() => isLoading = true);
      await auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text.trim(),
      );
      Fluttertoast.showToast(
          msg: "Login Successful", backgroundColor: Colors.green);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, RootScreen.routeName);
    } catch (error) {
      if (!mounted) return;
      await MyAppMethods.showErrorWarningDialog(
          context: context, subtitle: "Error: $error", fct: () {});
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: LoadingManager(
            isLoading: isLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppNameTextWidget(fontsize: 35),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          "Welcome Back!",
                          style: GoogleFonts.lato(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                              ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildTextField(_emailController, _emailFocusNode,
                                "Email Address", IconlyLight.message, false),
                            const SizedBox(height: 16),
                            _buildTextField(
                                _passwordController,
                                _passwordFocusNode,
                                "Password",
                                IconlyLight.lock,
                                true),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, ForgotPasswordScreen.routeName),
                                child: const Text("Forgot Password?",
                                    style: TextStyle(
                                        color: Colors.black,
                                        decoration: TextDecoration.underline)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildLoginButton(),
                            const SizedBox(height: 16),
                            _buildSocialButtons(),
                            const SizedBox(height: 16),
                            _buildSignUpOption(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, FocusNode focusNode,
      String hintText, IconData icon, bool isPassword) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: isPassword ? obscureText : false,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => obscureText = !obscureText))
              : null,
          border: InputBorder.none,
        ),
        validator: (value) => isPassword
            ? MyValidators.passwordValidator(value)
            : MyValidators.emailValidator(value),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: _loginFct,
        child: const Text("Login",
            style: TextStyle(fontSize: 20, color: Colors.blue)),
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const GoogleButton(),
      ],
    );
  }

  Widget _buildSignUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ",
            style: TextStyle(color: Colors.black)),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, RegisterScreen.routeName),
          child: const Text("Sign Up",
              style: TextStyle(
                  color: Colors.black, decoration: TextDecoration.underline)),
        ),
      ],
    );
  }
}
