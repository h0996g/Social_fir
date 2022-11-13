import 'package:firbase_app/home/cubit_home/home_cubit.dart';
import 'package:firbase_app/home/editeProfile/editeProfile.dart';
import 'package:firbase_app/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cache/cache_helper.dart';
import '../cubit_home/home_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        var model = HomeCubit.get(context).userModel;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              SizedBox(
                height: 220,
                // color: Colors.amber,
                child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: const Radius.circular(10),
                                  topRight: const Radius.circular(10)),
                              image: DecorationImage(
                                  image: NetworkImage('${model!.cover}'),
                                  fit: BoxFit.cover)),
                          height: 170,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        radius: 63,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage('${model.img}'),
                          radius: 60,
                        ),
                      )
                    ]),
              ),
              Text('${model.name}',
                  style: Theme.of(context).textTheme.bodyText1),
              const SizedBox(
                height: 10,
              ),
              Text('${model.bio}'),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Column(children: [
                        Text(
                          '100',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Posts')
                      ]),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(children: [
                        Text(
                          '230',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Photos')
                      ]),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(children: [
                        Text(
                          '11K',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('followers')
                      ]),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(children: [
                        Text(
                          '246',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Followings')
                      ]),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'Add Photos',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.blue),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 45,
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditeProfile()));
                        },
                        child: const Icon(IconBroken.Edit)),
                  )
                ],
              )
            ]),
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
