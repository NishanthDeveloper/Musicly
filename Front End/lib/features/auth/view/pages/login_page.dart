import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:musicly/core/theme/app_pallete.dart';
import 'package:musicly/core/utils.dart';
import 'package:musicly/core/widgets/loader.dart';
import 'package:musicly/features/auth/repositories/auth_remote_repository.dart';
import 'package:musicly/features/auth/view/pages/signup_page.dart';
import 'package:musicly/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:musicly/core/widgets/custom_field.dart';
import 'package:musicly/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:musicly/features/home/view/pages/home_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    // TODO: implement dispose
    super.dispose();
    //  formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(authViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(
      authViewModelProvider,
          (_, next) {
        next?.when(
          data: (data) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
                  (_) => false,
            );
          },
          error: (error, st) {
            showSnackBar(context, error.toString());
          },
          loading: () {},
        );
      },
    );
    return Scaffold(
      appBar: AppBar(),
      body: isLoading ? const Loader() : Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("Sign In",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 30,
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
                    if(formKey.currentState!.validate()){
                      ref.read(authViewModelProvider.notifier).loginUser(email: emailController.text, password: passwordController.text);
                    }else{
                      showSnackBar(context, 'Missing fields!');
                    }
                
                  },
                ),
            
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignupPage()));
                  },
                  child: RichText(
                    text: TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: const [
                          TextSpan(
                              text: "Sign Up",
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
