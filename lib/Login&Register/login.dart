import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firbase_app/Login&Register/cubit/login_cubit.dart';
import 'package:firbase_app/Login&Register/register.dart';
import 'package:firbase_app/cache/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../home/homeScreen.dart';
import '../shared/component.dart';
import 'cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return LoginCubit();
      },
      child: BlocConsumer<LoginCubit, LoginState>(
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defaultForm(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            lable: const Text(
                              'Email',
                            ),
                            valid: (String value) {
                              if (value.isEmpty) {
                                return 'Email Must Not Be Empty';
                              }
                            },
                            onFieldSubmitted: () {},
                            prefixIcon: const Icon(
                              Icons.email,
                            ),
                            textInputAction: TextInputAction.next),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultForm(
                          textInputAction: TextInputAction.done,
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          onFieldSubmitted: () {},
                          obscureText: LoginCubit.get(context).ishidden,
                          valid: (value) {
                            if (value.isEmpty) {
                              return 'Password Must Be Not Empty';
                            }
                          },
                          lable: const Text(
                            'Password',
                            style: TextStyle(),
                          ),
                          prefixIcon: const Icon(
                            Icons.password,
                          ),
                          sufixIcon: IconButton(
                            onPressed: () {
                              LoginCubit.get(context).showpass();
                            },
                            icon: LoginCubit.get(context).iconhidden,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text('forget password ?'),
                            const Spacer(),
                            ConditionalBuilder(
                              builder: (BuildContext context) {
                                return ConditionalBuilder(
                                  builder: (BuildContext context) {
                                    return FloatingActionButton(
                                      onPressed: () {
                                        LoginCubit.get(context).loginUser(
                                            emailController.text,
                                            passController.text);
                                      },
                                      child:
                                          const Icon(Icons.arrow_forward_ios),
                                    );
                                  },
                                  condition: state is! LodinLoginState,
                                  fallback: (BuildContext context) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                );
                              },
                              condition: state is! ConditionalLodinState,
                              fallback: (BuildContext context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            )
                          ],
                        ),
                        Center(
                          child: TextButton(
                            child: const Text('Register Now '),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {
          if (state is GoodLoginState) {
            CachHelper.putcache(key: 'uid', value: state.uid);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
                (route) => false);
          }
          if (state is BadLoginState) {
            Fluttertoast.showToast(
                msg: state.e,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
      ),
    );
  }
}
