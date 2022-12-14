import 'package:firbase_app/shared/style/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(children: [
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
                      print(FirebaseAuth.instance.currentUser);
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification()
                          .then((value) => {
                                Fluttertoast.showToast(
                                    msg: 'Check Your Email',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0)
                              })
                          .catchError((e) {
                        Fluttertoast.showToast(
                            msg: 'Please try later',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
          ),
        Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5.0,
            margin: const EdgeInsets.all(
              8.0,
            ),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                const Image(
                  image: NetworkImage(
                    'https://img.freepik.com/premium-photo/people-holding-speech-bubbles_34048-1043.jpg?w=1060',
                  ),
                  fit: BoxFit.cover,
                  height: 200.0,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('communicate with friends',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Colors.white)),
                )
              ],
            )),
        const SizedBox(
          height: 10,
        ),
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => ItemBuilder(),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemCount: 10),
        const SizedBox(
          height: 10,
        )
      ]),
    );
  }

  Widget ItemBuilder() => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNwtWSfqKqZGtJ-Aa3w8ZJTrvRPSkkIZwZQg&usqp=CAU'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text('HoussemEddine'),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 18,
                            )
                          ],
                        ),
                        const Text('January 21,2022 at 11:00 pm')
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_horiz))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "After a limited release in Hawaii timed with the Honolulu Marathon on November 30, 1978, Nike introduces the Tailwind in early 1979. This is the first running shoe with Nike Air, the technologically advanced, patented Air-Sole cushioning system. Nike's Exeter research and design lab creates the first outsole mold using computer-aided design on March 1, 1979",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 0,
                          onPressed: () {},
                          child: const Text(
                            "#softwar",
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                          minWidth: 0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text(
                            "#softwar",
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                          minWidth: 0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text(
                            "#softwar",
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                          minWidth: 0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text(
                            "#softwar",
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ],
                  // crossAxisAlignment: WrapCrossAlignment.start,
                  // alignment: WrapAlignment.start,
                ),
              ),
              Container(
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                height: 180,
                child: const Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 0,
                  child: Image(
                      image: NetworkImage(
                          'https://www.oprah.com/g/image-resizer?width=670&link=https://static.oprah.com/images/tows/201104/20110422-tows-nike-shoe-1982-600x411.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        IconBroken.Heart,
                        color: Colors.amber,
                      )),
                  const Text('200'),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        IconBroken.Chat,
                        color: Colors.amber,
                      )),
                  const Text('50 comment')
                ],
              ),
              const Divider(
                color: Colors.black,
                height: 10,
              ),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNwtWSfqKqZGtJ-Aa3w8ZJTrvRPSkkIZwZQg&usqp=CAU'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text('Write a comment ...'),
                  const Spacer(),
                  IconButton(
                      icon: const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                      ),
                      onPressed: () {}),
                  const Text('Like')
                ],
              )
            ],
          ),
        ),
      );
}
