import 'dart:io';
import 'package:firbase_app/home/cubit_home/home_cubit.dart';
import 'package:firbase_app/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/component.dart';
import '../cubit_home/home_state.dart';

class EditeProfile extends StatelessWidget {
  EditeProfile({Key? key}) : super(key: key);
  var userController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        var usermodel = HomeCubit.get(context).userModel;
        HomeCubit model = BlocProvider.of(context);
        // var im = HomeCubit.get(context).profileimage;
        userController.text = usermodel!.name!;
        bioController.text = usermodel.bio!;
        phoneController.text = usermodel.phone!;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: defaultAppBar(
            leading: IconButton(
              onPressed: () {
                model.resetEditeProfile();
                Navigator.pop(context);
              },
              icon: const Icon(IconBroken.Arrow___Left_2),
              color: Colors.black,
            ),
            context: context,
            title: 'Edite Profile',
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is LodingUpdateUser)
                    const LinearProgressIndicator(),
                  if (state is LodingUpdateUser)
                    const SizedBox(
                      height: 10,
                    ),
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
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      image: DecorationImage(
                                          image: HomeCubit.get(context)
                                                      .coverimage ==
                                                  null
                                              ? NetworkImage(
                                                  '${usermodel.cover}')
                                              : Image.file(File(
                                                      HomeCubit.get(context)
                                                          .coverimage!
                                                          .path))
                                                  .image,
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
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              title: const Text(
                                                  'choose the source :'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      HomeCubit.get(context)
                                                          .coverImg(ImageSource
                                                              .gallery)
                                                          .then((value) =>
                                                              Navigator.pop(
                                                                  context));
                                                    },
                                                    child:
                                                        const Text('galery')),
                                                TextButton(
                                                    onPressed: () {
                                                      HomeCubit.get(context)
                                                          .coverImg(ImageSource
                                                              .camera)
                                                          .then((value) =>
                                                              Navigator.pop(
                                                                  context));
                                                    },
                                                    child: const Text('camera'))
                                              ],
                                            ));
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
                                  backgroundImage: HomeCubit.get(context)
                                              .profileimage ==
                                          null
                                      ? NetworkImage('${usermodel.img}')
                                      : Image.file(File(HomeCubit.get(context)
                                              .profileimage!
                                              .path))
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
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: const Center(
                                                child: Text(
                                                    'choose the source :')),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    HomeCubit.get(context)
                                                        .profileImg(
                                                            ImageSource.gallery)
                                                        .then((value) =>
                                                            Navigator.pop(
                                                                context));
                                                  },
                                                  child: const Text('galery')),
                                              TextButton(
                                                  onPressed: () {
                                                    HomeCubit.get(context)
                                                        .profileImg(
                                                            ImageSource.camera)
                                                        .then((value) =>
                                                            Navigator.pop(
                                                                context));
                                                  },
                                                  child: const Text('camera'))
                                            ],
                                          ));
                                },
                              )
                            ],
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (model.profileimage != null || model.coverimage != null)
                    Row(
                      children: [
                        if (model.profileimage != null)
                          Expanded(
                            child: Column(
                              children: [
                                OutlineButton(
                                  onPressed: () {
                                    model.uploadProfileImg();
                                  },
                                  child: Text(
                                    'Upload Profile',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.blue),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                if (state is LoginUploadProfileImg)
                                  const LinearProgressIndicator()
                              ],
                            ),
                          ),
                        if (model.profileimage != null ||
                            model.coverimage != null)
                          const SizedBox(
                            width: 10,
                          ),
                        if (model.coverimage != null)
                          Expanded(
                              child: Column(
                            children: [
                              OutlineButton(
                                  onPressed: () {
                                    model.uploadCoverImg();
                                  },
                                  child: Text(
                                    'Upload Cover',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.blue),
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              if (state is LodinUploadCoverImg)
                                const LinearProgressIndicator()
                            ],
                          )),
                      ],
                    ),
                  const SizedBox(
                    height: 10,
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
                      textInputAction: TextInputAction.next),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultForm(
                      controller: phoneController,
                      lable: const Text('Phone'),
                      valid: () {},
                      type: TextInputType.phone,
                      textInputAction: TextInputAction.done),
                  const SizedBox(
                    height: 50,
                  ),
                  // if (model.profileimage == null || model.coverimage == null)
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: OutlineButton(
                        onPressed: () {
                          model.updateUser(
                              name: userController.text,
                              bio: bioController.text,
                              phone: phoneController.text);
                        },
                        child: Text(
                          'Update Info',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.blue),
                        )),
                  ),
                  if (state is LodinUpdateUser) const LinearProgressIndicator()
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
