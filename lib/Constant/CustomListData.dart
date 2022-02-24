import 'package:flutter/material.dart';

class CustomListData extends StatelessWidget {
  final String? title;
  final String? value;

  const CustomListData({Key? key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title!,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            value!,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
