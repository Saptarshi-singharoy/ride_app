import 'package:flutter/material.dart';
import 'package:ride_app/src/screens/login_screen/login_screen.dart';
import 'package:ride_app/src/screens/profile_details/profile_expanded_screen.dart';
import 'package:ride_app/src/services/google_signin_service.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key, required this.userData});

  final dynamic userData;

  @override
  Widget build(BuildContext context) {
    String imgUrl = userData.photoUrl;
    String name = userData.displayName;
    String desig = "Reporter lvl 1";

    TextStyle textStyle = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Theme.of(context).colorScheme.secondary);

    void googleSignOut() async {
      await GoogleSigninService.logout();

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => LoginScreen()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.withOpacity(0.1),
        title: Text(
          'Your Profile',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return ProfileExpandedScreen(
                            imgUrl: imgUrl, name: name, desig: desig);
                      }));
                    },
                    child: ClipOval(
                        child: Hero(
                      tag: 'img-tag-$imgUrl',
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(imgUrl),
                      ),
                    ))),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: textStyle),
                    Text(
                      desig,
                      style: textStyle,
                    )
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: ElevatedButton(
                onPressed: googleSignOut,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Log Out",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
