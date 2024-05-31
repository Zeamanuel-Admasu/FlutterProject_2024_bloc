import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/booking/booking_bloc.dart';
import 'package:flutter_application_1/application/branch/branch_bloc.dart';
import 'package:flutter_application_1/application/table/bloc/table_bloc.dart';
import 'package:flutter_application_1/application/token_bloc.dart';
import 'package:flutter_application_1/application/type/type_bloc.dart';
import 'package:flutter_application_1/infrastructure/Repository/booking_repository.dart';
import 'package:flutter_application_1/infrastructure/Repository/table_respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import '../../application/signup/bloc/login_bloc.dart';
import '../../application/signup/bloc/login_event.dart';
import '../../application/signup/bloc/login_state.dart';
import '../widgets/email.dart';
import './HomePage.dart';
import './AdminPageTransfer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _userType = 'User';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.black, Colors.black12],
            begin: Alignment.bottomCenter,
            end: Alignment(0, 0.5),
          ).createShader(bounds),
          blendMode: BlendMode.darken,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/one.JPG"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _header(context),
                  _inputField(context),
                  _signup(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Padding(
      padding: EdgeInsets.only(top: 60), // Added padding to avoid overlap
      child: Column(
        children: [
          Text(
            "Welcome Back",
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          Text(
            "Enter your credential to login",
            style: TextStyle(color: Color.fromARGB(184, 231, 190, 190)),
          ),
        ],
      ),
    );
  }

  _inputField(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20), // Added padding to avoid overlap
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  key: const Key("adminChoice"),
                  value: 'Admin',
                  groupValue: _userType,
                  onChanged: (value) {
                    setState(() {
                      _userType = value!;
                    });
                    BlocProvider.of<LoginBloc>(context)
                        .add(UserTypeChanged(_userType));
                  },
                ),
                const Text(
                  'Admin',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white), // Change text color to white
                ),
                Radio(
                  value: 'User',
                  groupValue: _userType,
                  onChanged: (value) {
                    setState(() {
                      _userType = value!;
                    });
                    BlocProvider.of<LoginBloc>(context)
                        .add(UserTypeChanged(_userType));
                  },
                ),
                const Text(
                  'User',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white), // Change text color to white
                ),
              ],
            ),
          ),
          TextField(
            key: const Key("loginEmail"),
            controller: _usernameController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.blue.withOpacity(0.6)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor:
                  const Color.fromARGB(255, 212, 197, 214).withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(
                Icons.alternate_email_outlined,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            key: const Key("loginPassword"),
            controller: _passwordController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Password",
              hintStyle: TextStyle(color: Colors.blue.withOpacity(0.6)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(
                Icons.password,
                color: Color.fromARGB(134, 218, 213, 213),
              ),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 10),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                _handleLoginSuccess(context);
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  key: const Key("loginButton"),
                  onPressed: () {
                    print(_usernameController.text);
                    BlocProvider.of<LoginBloc>(context).add(
                      LoginButtonPressed(
                          email: _usernameController.text,
                          password: _passwordController.text,
                          userType: _userType,
                          context: context),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.purple,
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              GoRouter.of(context).go('/forgotPassword');
            },
            child: Text(
              "Forgot password?",
              style: TextStyle(
                  color: Colors.purple,
                  backgroundColor: Colors.black12.withOpacity(0.1)),
            ),
          ),
        ],
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Dont have an account? ",
          style: TextStyle(color: Color.fromARGB(185, 238, 238, 238)),
        ),
        TextButton(
            key: const Key("SignUp"),
            onPressed: () {
              GoRouter.of(context).go("/signup");
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Color.fromARGB(255, 217, 0, 255)),
            ))
      ],
    );
  }

  _handleLoginSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Login Successful',
          style: TextStyle(
            color: Colors.green, // Set the text color to green
            fontSize: 18, // Set the font size to 18 (adjust as needed)
          ),
        ),
      ),
    );

    print(_userType);

    if (_userType == 'Admin') {
      GoRouter.of(context).go("/adminPageTransfer");
    } else {
      GoRouter.of(context).go("/home?index=0");
    }
  }
}
