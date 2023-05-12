import 'package:flutter/material.dart';

class OrderDate extends StatelessWidget {
  const OrderDate({super.key, required this.date});
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Text(convertToDate(date.toLocal()),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: size.width < 600 ? 20 : 25, color: Colors.grey)),
    );
  }

  String convertToDate(DateTime date) {
    final minutes =
        date.minute.toString().length == 1 ? '0${date.minute}' : date.minute;
    return '${date.day}-${date.month}-${date.year}  ${date.hour}:$minutes';
  }
}
