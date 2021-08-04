import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/data/models/user.dart';
import '/presentation/ui/theme/app_constants.dart';
import 'package:jiffy/jiffy.dart';

class ProfileContainer extends StatelessWidget {
  final User user;
  const ProfileContainer({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 188.11,
      decoration: const BoxDecoration(color: Constants.darkColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListTile(
            leading: SvgPicture.asset('assets/icons/account-circle.svg'),
            title: Text(
              '${user.firstName} ${user.lastName}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Constants.lightGreenColor),
            ),
            subtitle: Text(
              'Graphic designer • IQ Education',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomRichText(
                    titleText: 'Date of birth',
                    infoText: '${Jiffy(user.dateOfBirth).format("dd.MM.yyyy")}',
                  ),
                  CustomRichText(
                    titleText: 'Phone number',
                    infoText: '${user.phoneNumber}',
                  ),
                  CustomRichText(
                    titleText: 'Email',
                    infoText: '${user.email}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    Key? key,
    required this.titleText,
    required this.infoText,
  }) : super(key: key);

  final String titleText;
  final String infoText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$titleText :',
        style: Theme.of(context).textTheme.bodyText1,
        children: [
          TextSpan(
              text: ' $infoText',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: const Color(0xFF999999),
                  )),
        ],
      ),
    );
  }
}
