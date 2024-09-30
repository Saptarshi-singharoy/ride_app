import 'package:flutter/material.dart';
import 'package:ride_app/src/navigators/bottom_tab.dart';
import 'package:ride_app/src/services/google_signin_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    void googleSignIn() async {
      final user = await GoogleSigninService.login();
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign in Failed')));
      } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>  BottomTab(user: user)));
      }
      
    }


    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'images/ABP_logo.svg.png',
                width: MediaQuery.of(context).size.width - 100,
              ),
              Container(
                width: 350,
                child: ElevatedButton(
                    onPressed: googleSignIn,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/Google.png',
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Login with Google",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color: Theme.of(context).colorScheme.primary),
                          )
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
