import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firbase_app/cache/cache_helper.dart';
import 'package:firbase_app/home/cubit_home/home_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit_home/home_state.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        print(FirebaseAuth.instance.currentUser!.emailVerified);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text('Home'),
          ),
          body: ConditionalBuilder(
            builder: (BuildContext context) {
              return Column(children: [
                if (FirebaseAuth.instance.currentUser!.emailVerified == false)
                  Container(
                    color: Colors.amber.withOpacity(0.6),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: Text(
                            'please verify your email',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.currentUser!
                                  .sendEmailVerification();
                            },
                            child: const Text(
                              'Send',
                              style: TextStyle(fontSize: 20),
                            ))
                      ],
                    ),
                  )
              ]);
            },
            condition: HomeCubit.get(context).model != null,
            fallback: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(onPressed: () async {
            await CachHelper.remove(key: 'uid');
          }),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
