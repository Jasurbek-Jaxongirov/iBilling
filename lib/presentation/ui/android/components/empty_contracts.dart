import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyContracts extends StatelessWidget {
  const EmptyContracts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/empty-contracts.svg',
          color: const Color(0xFFDADADA),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'No contracts are made',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
