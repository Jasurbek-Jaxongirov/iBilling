import 'package:flutter/material.dart';
import '/models/user.dart';
import '/ui/android/components/profile_container.dart';
import '/ui/theme/app_constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Constants.darkestColor,
      ),
      child: Column(
        children: [
          ProfileContainer(
            user: User(
                userId: DateTime.now().toString(),
                firstName: 'Otabek',
                lastName: 'Abdusamatov',
                dateOfBirth: DateTime(2001, 09, 16),
                phoneNumber: '+998 97 721 06 88',
                email: 'predatorhunter041@gmail.com'),
          ),
        ],
      ),
    );
  }
}
