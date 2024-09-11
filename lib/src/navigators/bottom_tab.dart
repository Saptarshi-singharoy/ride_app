import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ride_app/src/screens/approve_request_screen.dart';
import 'package:ride_app/src/screens/book_list_screen.dart';
import 'package:ride_app/src/screens/new_cab_screen.dart';
import 'package:ride_app/src/screens/on_behalf.dart';
import 'package:ride_app/src/widgets/bottomsheet/new_ride.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key, required this.user});

  final GoogleSignInAccount user;

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _activePageIndex = 0;
  bool flag = true;
  bool behalfMode = true;

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

  void _addBookingBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) => NewRide(
        behalfMode: flag && behalfMode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage;
    String activePageName;

    switch (_pageIdentifiers[_activePageIndex]) {
      case 'requests':
        activePage = ApproveRequestScreen();
        activePageName = 'Ride Requests';
        break;
      case 'onBehalf':
        activePage = OnBehalf();
        activePageName = 'On Behalf';
        break;
      case 'newBooking':
        activePage = NewCabScreen(
          behalfMode: behalfMode,
        );
        activePageName = 'Book a new Cab';
        break;
      case 'bookList':
      default:
        activePage = BookListScreen();
        activePageName = 'Your Booking List';
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    activePageName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  InkWell(
                      onTap: () {},
                      child: ClipOval(
                          child: Hero(
                        tag: 'img-tag-${widget.user.photoUrl!}',
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(widget.user.photoUrl!),
                        ),
                      ))),
                ],
              ),
            ),
          ),
        ],
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 15,
        currentIndex: _activePageIndex,
        onTap: _changePageIndex,
        // unselectedItemColor: Colors.white60,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.directions_car), label: 'Bookings'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.directions_car), label: 'New'),
          if (flag)
            const BottomNavigationBarItem(
                icon: Icon(Icons.car_rental), label: 'Requests'),
          if (flag)
            const BottomNavigationBarItem(
                icon: Icon(Icons.drive_eta), label: 'On behalf'),
        ],
      ),
    );
  }
}
