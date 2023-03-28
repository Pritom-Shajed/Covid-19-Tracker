import 'package:flutter/material.dart';

Widget ReusableButton(
    {required BuildContext context,
    required VoidCallback onTap,
    required String text}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
          color: const Color(0xff1aa260),
          borderRadius: BorderRadius.circular(10)),
      child: Center(child: Text(text)),
    ),
  );
}
