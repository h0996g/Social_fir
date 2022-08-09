import 'package:firbase_app/Login&Register/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../shared/component.dart';
import 'cubit/register_state.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKeyy = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return RegisterCubit();
      },
      child: BlocProvider(
        create: (BuildContext context) {
          return RegisterCubit();
        },
        child: BlocConsumer<RegisterCubit, RegisterState>(
          builder: (BuildContext context, state) {
            return Scaffold(
              appBar: AppBar(
                  title: Text(
                'Register',
                style: Theme.of(context).textTheme.headline4,
              )),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKeyy,
                  child: Column(children: [
                    defaultForm(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        valid: (String value) {
                          if (value.isEmpty) {
                            return 'Email Must Not Be Empty';
                          }
                        },
                        lable: const Text('Email'),
                        textInputAction: TextInputAction.next,
                        prefixIcon: const Icon(Icons.email)),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultForm(
                        controller: nameController,
                        type: TextInputType.text,
                        valid: (String value) {
                          if (value.isEmpty) {
                            return 'Name Must Not Be Empty';
                          }
                        },
                        lable: const Text('Name'),
                        textInputAction: TextInputAction.next,
                        prefixIcon: const Icon(Icons.person)),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultForm(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      obscureText: RegisterCubit.get(context).ishidden,
                      valid: (value) {
                        if (value.isEmpty) {
                          return 'Password Must Be Not Empty';
                        }
                      },
                      lable: const Text('Password'),
                      textInputAction: TextInputAction.next,
                      prefixIcon: Icon(
                        Icons.password,
                      ),
                      sufixIcon: IconButton(
                        onPressed: () {
                          RegisterCubit.get(context).showpass();
                        },
                        icon: RegisterCubit.get(context).iconhidden,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultForm(
                        controller: phoneController,
                        type: TextInputType.phone,
                        valid: (String value) {
                          if (value.isEmpty) {
                            return 'Email Must Not Be Empty';
                          }
                        },
                        lable: const Text('Phone'),
                        textInputAction: TextInputAction.done,
                        prefixIcon: const Icon(Icons.phone)),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          if (formKeyy.currentState!.validate()) {}
                        },
                        child: const Text('Register'))
                  ]),
                ),
              ),
            );
          },
          listener: (BuildContext context, Object? state) {},
        ),
      ),
    );
  }
}
