import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: MaterialApp(
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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/one.JPG"),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black12, BlendMode.darken),
                ),
              ),
              child: Padding(
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
      ),
    );
  }

  _header(context) {
    return const Column(
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
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: 'Admin',
                groupValue: _userType,
                onChanged: (value) {
                  setState(() {
                    _userType = value!;
                  });
                  context.read<LoginBloc>().add(UserTypeChanged(_userType));
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
                  context.read<LoginBloc>().add(UserTypeChanged(_userType));
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
        emailTextField(controller: _usernameController),
        const SizedBox(height: 10),
        TextField(
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
                onPressed: () {
                  print(_usernameController.text);
                  context.read<LoginBloc>().add(
                        LoginButtonPressed(
                          email: _usernameController.text,
                          password: _passwordController.text,
                          userType: _userType,
                        ),
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
                      fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
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
            Navigator.pushNamed(context, '/forgot_password');
          },
          child: Text(
            "Forgot password?",
            style: TextStyle(
                color: Colors.purple,
                backgroundColor: Colors.black12.withOpacity(0.1)),
          ),
        ),
      ],
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
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
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

    if (_userType == 'Admin') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminPageTransfer()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }
}
