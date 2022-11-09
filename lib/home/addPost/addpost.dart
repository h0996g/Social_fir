import 'package:flutter/material.dart';

import '../../shared/component.dart';

class AddPost extends StatelessWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context, title: 'AddPost'),
      body: const Center(
        child: Icon(
          Icons.add,
          size: 100,
        ),
      ),
    );
  }
}
