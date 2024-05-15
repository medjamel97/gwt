import 'package:flutter/material.dart';
import 'package:gwt/controller/user_controller.dart';
import 'package:gwt/view/home_view.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final UserController _userController = UserController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _userController,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registration'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              TextField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                ),
              ),
              Consumer<UserController>(
                builder: (context, controller, _) {
                  return ElevatedButton(
                    onPressed: controller.loading
                        ? null
                        : () async {
                            await controller
                                .register(
                              email: _emailController.text,
                              password: _passwordController.text,
                              name: _fullNameController.text,
                            )
                                .then(
                              (value) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const HomeView(),
                                  ),
                                  (route) => false,
                                );
                              },
                            );
                          },
                    child: controller.loading
                        ? const CircularProgressIndicator()
                        : const Text('Register'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
