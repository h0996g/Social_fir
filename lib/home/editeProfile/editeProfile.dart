import 'dart:io';

import 'package:firbase_app/home/cubit_home/home_cubit.dart';
import 'package:firbase_app/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component.dart';
import '../cubit_home/home_state.dart';

class EditeProfile extends StatelessWidget {
  EditeProfile({Key? key}) : super(key: key);
  var userController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        var model = HomeCubit.get(context).userModel;
        var im = HomeCubit.get(context).image;
        userController.text = model!.name!;
        bioController.text = model.bio!;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edite Profile', action: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Update',
                style: TextStyle(fontSize: 20),
              ),
            )
          ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 220,
                  // color: Colors.amber,
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    image: DecorationImage(
                                        image: NetworkImage('${model.cover}'),
                                        fit: BoxFit.cover)),
                                height: 170,
                              ),
                              IconButton(
                                splashRadius: double.minPositive,
                                // color: Colors.blue,
                                icon: const CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 25,
                                  ),
                                ),
                                onPressed: () {
                                  HomeCubit.get(context).galeryImage();
                                },
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              radius: 63,
                              child: CircleAvatar(
                                backgroundImage: HomeCubit.get(context).image ==
                                        null
                                    ? NetworkImage('${model.img}')
                                    : Image.file(File(
                                            HomeCubit.get(context).image!.path))
                                        .image,
                                radius: 60,
                              ),
                            ),
                            IconButton(
                              splashRadius: double.minPositive,
                              autofocus: false,
                              icon: const CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 25,
                                ),
                              ),
                              onPressed: () {
                                HomeCubit.get(context).galeryImage();
                              },
                            )
                          ],
                        )
                      ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                defaultForm(
                    controller: userController,
                    lable: const Text('userName'),
                    valid: () {},
                    type: TextInputType.name,
                    textInputAction: TextInputAction.next),
                const SizedBox(
                  height: 20,
                ),
                defaultForm(
                    controller: bioController,
                    lable: const Text('bio'),
                    valid: () {},
                    type: TextInputType.name,
                    textInputAction: TextInputAction.done)
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
