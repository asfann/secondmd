import 'package:flutter/material.dart';
import 'package:secondmd/screens/add_post_screen.dart';
import 'package:secondmd/screens/add_table_screen.dart';
import 'package:secondmd/screens/add_waiter_screen.dart';
import '../widget/rounded_elecated_button.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }


  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            child:  Column(
              children: [
                RoundedElevatedButton(title: 'Waiters', onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddWaiterScreen()));
                },   padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.4,
                  vertical: MediaQuery.of(context).size.height * 0.02,
                ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RoundedElevatedButton(title: 'Tables', onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTableScreen()));

                },    padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.4,
                  vertical: MediaQuery.of(context).size.height * 0.02,
                ),

                ),
               const SizedBox(
                  height: 10,
                ), RoundedElevatedButton(title: 'Dishes ', onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPostScreen()));
                },    padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.4,
                  vertical: MediaQuery.of(context).size.height * 0.02,
                ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
