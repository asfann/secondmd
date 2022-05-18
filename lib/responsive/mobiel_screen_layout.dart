import 'package:flutter/material.dart';
import 'package:secondmd/screens/add_post_screen.dart';
import '../widget/rounded_elecated_button.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
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

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:  Column(
          children: [
            RoundedElevatedButton(title: 'Waiters', onPressed: () {
              
            },   padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.4,
              vertical: MediaQuery.of(context).size.height * 0.02,
            ),
            ),
            SizedBox(
              height: 10,
            ),
            RoundedElevatedButton(title: 'Tables', onPressed: () {
           
            },    padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.4,
              vertical: MediaQuery.of(context).size.height * 0.02,
            ),

            ),
            SizedBox(
              height: 10,
            ), RoundedElevatedButton(title: 'Dishes ', onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPostScreen()));
            },    padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.4,
              vertical: MediaQuery.of(context).size.height * 0.02,
            ),
            )
          ],
        ),
      ),

    );
  }
}
