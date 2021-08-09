import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCheckboxButton extends StatelessWidget {
  const CustomCheckboxButton(
      {Key? key,
      required this.width,
      required this.buttonText,
      required this.isChecked})
      : super(key: key);
  final double width;
  final String buttonText;
  final bool isChecked;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(isChecked
                  ? 'assets/icons/bold-tick.svg'
                  : 'assets/icons/light-tick.svg'),
              const SizedBox(
                width: 10,
              ),
              Text(
                buttonText,
                style: TextStyle(
                  color: isChecked ? Colors.white : const Color(0xFFA6A6A6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
