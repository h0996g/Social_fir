import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firbase_app/home/addPost/addpost.dart';
import 'package:firbase_app/home/cubit_home/home_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/style/icon_broken.dart';
import 'cubit_home/home_state.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        var cubit = HomeCubit.get(context);
        print(FirebaseAuth.instance.currentUser!.emailVerified);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(
                  IconBroken.Notification,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  IconBroken.Search,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              '${cubit.title[cubit.indexNav]}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 27,
              ),
            ),
          ),
          body: ConditionalBuilder(
            builder: (BuildContext context) {
              return cubit.screen[cubit.indexNav];
              //  Column(children: [
              //   if (FirebaseAuth.instance.currentUser!.emailVerified == false)
              //     Container(
              //       color: Colors.amber.withOpacity(0.6),
              //       child: Row(
              //         children: [
              //           const Icon(
              //             Icons.info_outline,
              //             size: 30,
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           const Expanded(
              //             child: Text(
              //               'please verify your email',
              //               style: TextStyle(fontSize: 20),
              //             ),
              //           ),
              //           TextButton(
              //               onPressed: () {
              //                 FirebaseAuth.instance.currentUser!
              //                     .sendEmailVerification();
              //               },
              //               child: const Text(
              //                 'Send',
              //                 style: TextStyle(fontSize: 20),
              //               ))
              //         ],
              //       ),
              //     )
              // ]);
            },
            condition: HomeCubit.get(context).userModel != null,
            fallback: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                cubit.changeNav(value);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home), label: 'home'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat), label: 'chat'),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Plus,
                  ),
                  label: 'AddPost',
                ),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Location), label: 'user'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting), label: 'setting'),
              ],
              currentIndex: cubit.indexNav,
              type: BottomNavigationBarType.fixed),
          // floatingActionButton: FloatingActionButton(onPressed: () async {
          //   await CachHelper.remove(key: 'uid');
          // }),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is ChangeNaveToAddPostState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPost()));
        }
      },
    );
  }
}
