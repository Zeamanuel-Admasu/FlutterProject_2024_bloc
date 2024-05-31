import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/signup/bloc/signup_bloc.dart';
import '../../application/signup/bloc/signup_event.dart';
import '../../application/signup/bloc/signup_state.dart';
import '../widgets/username.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController =
        TextEditingController();

    return BlocProvider(
      create: (context) => SignupBloc(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.black, Colors.black12],
              begin: Alignment.bottomCenter,
              end: Alignment(0, 0.7),
            ).createShader(bounds),
            blendMode: BlendMode.darken,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/two.JPG"),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black26, BlendMode.darken),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Column(
                      children: [
                        SizedBox(height: 40),
                        Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          "Create your account",
                          style: TextStyle(
                            color: Color.fromARGB(232, 241, 216, 216),
                          ),
                        ),
                      ],
                    ),
                    BlocListener<SignupBloc, SignupState>(
                      listener: (context, state) {
                        if (state is SignupSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                          Navigator.pushNamed(context, '/login');
                        } else if (state is SignupFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        }
                      },
                      child: BlocBuilder<SignupBloc, SignupState>(
                        builder: (context, state) {
                          if (state is SignupLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              UsernameTextField(
                                  controller: _usernameController),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _emailController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: Colors.blue.withOpacity(0.6)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none,
                                  ),
                                  fillColor:
                                      const Color.fromARGB(255, 170, 95, 184)
                                          .withOpacity(0.1),
                                  filled: true,
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Color.fromARGB(134, 218, 213, 213),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _passwordController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Colors.blue.withOpacity(0.6)),
                                  helperText:
                                      '*Password must contain special character',
                                  helperStyle: const TextStyle(
                                      color: Color.fromARGB(158, 76, 175, 79)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none,
                                  ),
                                  fillColor:
                                      const Color.fromARGB(255, 170, 95, 184)
                                          .withOpacity(0.1),
                                  filled: true,
                                  prefixIcon: const Icon(
                                    Icons.password,
                                    color: Color.fromARGB(134, 218, 213, 213),
                                  ),
                                ),
                                obscureText: true,
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _confirmPasswordController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  hintStyle: TextStyle(
                                      color: Colors.blue.withOpacity(0.6)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none,
                                  ),
                                  fillColor:
                                      const Color.fromARGB(255, 170, 95, 184)
                                          .withOpacity(0.1),
                                  filled: true,
                                  prefixIcon: const Icon(
                                    Icons.password,
                                    color: Color.fromARGB(134, 218, 213, 213),
                                  ),
                                ),
                                obscureText: true,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  final username = _usernameController.text;
                                  final email = _emailController.text;
                                  final password = _passwordController.text;
                                  final confirmPassword =
                                      _confirmPasswordController.text;
                                  if (password == confirmPassword) {
                                    if (username.isNotEmpty &&
                                        email.isNotEmpty &&
                                        password.isNotEmpty) {
                                      context.read<SignupBloc>().add(
                                            SignupButtonPressed(
                                              username: username,
                                              email: email,
                                              password: password,
                                            ),
                                          );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            duration: Duration(seconds: 5),
                                            content: Text(
                                                'All fields are required')),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Passwords do not match')),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  backgroundColor: Colors.purple,
                                ),
                                child: const Text(
                                  "Sign up",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Center(
                                child: Text(
                                  'Or',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(92, 255, 255, 255)
                                            .withOpacity(0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                              255, 255, 255, 255)
                                          .withOpacity(0.7),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 30.0,
                                        width: 30.0,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/google.png'),
                                            fit: BoxFit.cover,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 18),
                                      const Text(
                                        "Sign In with Google",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            'Log in',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
