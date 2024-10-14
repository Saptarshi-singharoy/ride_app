import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ride_app/data/services/google_signin_service.dart';
import 'package:ride_app/presentation/approve/screens/approve_request_screen.dart';
import 'package:ride_app/presentation/auth/screens/login_screen.dart';
import 'package:ride_app/presentation/booking/booking_list/screens/book_list_screen.dart';
import 'package:ride_app/presentation/booking/new_booking/screens/new_cab_screen.dart';
import 'package:ride_app/presentation/on_behalf/screens/on_behalf.dart';
import 'package:ride_app/utils/themes/themes.dart';
// import 'package:ride_app/src/screens/profile_details/profile_details_screen.dart';
// import 'package:ride_app/src/widgets/bottomsheet/new_ride.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key, required this.user});

  final GoogleSignInAccount user;

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _activePageIndex = 0;
  bool flag = true;
  bool behalfMode = false;

  final List<String> _pageIdentifiers = [];

  @override
  void initState() {
    super.initState();
    _updatePageIdentifiers();
  }

  void _updatePageIdentifiers() {
    _pageIdentifiers.clear();
    _pageIdentifiers.add('bookList');
    _pageIdentifiers.add('newBooking');
    if (flag) {
      _pageIdentifiers.add('requests');
      _pageIdentifiers.add('onBehalf');
    }
  }

  void _changePageIndex(int index) {
    setState(() {
      _activePageIndex = index;
      // Update behalfMode based on the selected page identifier
      final identifier = _pageIdentifiers[index];
      behalfMode = identifier == 'onBehalf';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage;
    String activePageName;

    final photoUrl = widget.user.photoUrl;

    switch (_pageIdentifiers[_activePageIndex]) {
      case 'requests':
        activePage = ApproveRequestScreen();
        activePageName = 'Ride Requests';
        break;
      case 'onBehalf':
        activePage = OnBehalf(behalfMode: behalfMode);
        activePageName = 'Book on Behalf';
        break;
      case 'newBooking':
        activePage = const NewCabScreen();
        activePageName = 'Request a car';
        break;
      case 'bookList':
      default:
        activePage = BookListScreen();
        activePageName = 'Your Booking List';
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    activePageName,
                    style: provideTextTheme(context).headlineMedium!.copyWith(
                        color: Colors.red[900], fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("LOGOUT"),
                                    ElevatedButton(
                                        onPressed: () async {
                                          await GoogleSigninService.logout();
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(builder: (ctx) {
                                            return LoginScreen();
                                          }));
                                        },
                                        child: Text("Log Out"))
                                  ],
                                ),
                              );
                            });
                      },
                      child: ClipOval(
                          child: Hero(
                        tag: photoUrl == null
                            ? Image.asset(
                                'images/profile.jpg',
                                width: 20,
                              )
                            : 'img-tag-${widget.user.photoUrl!}',
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: photoUrl == null
                              ? AssetImage('images/profile.jpg')
                              : NetworkImage(widget.user.photoUrl!),
                        ),
                      ))),
                ],
              ),
            ),
          ),
        ],
      ),
      body: activePage,
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 15,
        currentIndex: _activePageIndex,
        onTap: _changePageIndex,
        unselectedLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        selectedIconTheme: IconThemeData(size: 30),
        unselectedItemColor:
            Theme.of(context).colorScheme.onSecondary.withOpacity(0.7),
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Colors.red[900],
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.list), label: 'Bookings'),
          const BottomNavigationBarItem(icon: Icon(Icons.add), label: 'New'),
          if (flag)
            const BottomNavigationBarItem(
                icon: Icon(Icons.install_mobile), label: 'Requests'),
          if (flag)
            const BottomNavigationBarItem(
                icon: Icon(Icons.person_2_sharp),
                label: 'On behalf',
                backgroundColor: Colors.amber),
        ],
      ),
    );
  }
}
