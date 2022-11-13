import 'package:firbase_app/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';

Widget defaultForm({
  required controller,
  required TextInputType type,
  required Function valid,
  required Text lable,
  Icon? prefixIcon,
  IconButton? sufixIcon,
  required TextInputAction textInputAction,
  bool obscureText = false,
  Function? onFieldSubmitted,
  Function? onchange,
}) =>
    TextFormField(
      // onChanged: (value) {
      //   return onchange!(value);
      // },
      textInputAction: textInputAction,
      onFieldSubmitted: (k) {
        onFieldSubmitted!(k);
      },
      validator: (String? value) {
        return valid(value);
      },
      decoration: InputDecoration(
          label: lable,
          border: const OutlineInputBorder(),
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon),
      controller: controller,
      keyboardType: type,
      obscureText: obscureText,
    );

PreferredSizeWidget defaultAppBar(
        {@required context,
        String? title,
        List<Widget>? action,
        IconButton? leading}) =>
    AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        title!,
        style: TextStyle(color: Colors.black, fontSize: 27),
      ),
      leading: leading,
      actions: action,
      titleSpacing: 0.0,
    );
