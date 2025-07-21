import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:musicly/core/theme/app_pallete.dart';
import 'package:musicly/core/utils.dart';
import 'package:musicly/core/widgets/loader.dart';
import 'package:musicly/features/auth/repositories/auth_remote_repository.dart';
import 'package:musicly/features/auth/view/pages/login_page.dart';
import 'package:musicly/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:musicly/core/widgets/custom_field.dart';
import 'package:musicly/features/auth/viewmodel/auth_viewmodel.dart';

class SignupPage extends ConsumerStatefulWidget {
  SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    // TODO: implement dispose
    super.dispose();
    //  formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider.select((val) => val?.isLoading ==  true));
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
          data: (data) {
            showSnackBar(
                context, 'Account created successfully! Please login.');

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          error: (error, st) {
            showSnackBar(context, error.toString());
          },
          loading: () {});
    });
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sign Up",
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 30,
                      ),
                      CustomField(
                        hintText: "Name",
                        controller: nameController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomField(
                        hintText: "Email",
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomField(
                        hintText: "Password",
                        controller: passwordController,
                        isObscureText: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AuthGradientButton(
                          buttonText: 'Sign In',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await ref
                                  .read(authViewModelProvider.notifier)
                                  .signUpUser(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: RichText(
                          text: TextSpan(
                              text: "Already have an account? ",
                              style: Theme.of(context).textTheme.titleMedium,
                              children: const [
                                TextSpan(
                                    text: "Sign In",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Pallete.gradient2))
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
