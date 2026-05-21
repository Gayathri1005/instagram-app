import 'package:flutter/material.dart';
import 'package:instagram_app/screens/add_post_page.dart';
import 'package:instagram_app/screens/home_page.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;
  List<Widget> screens = [
    HomePage(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: selectedIndex == 0 ? Text("Instagram") : null,
        actions: [
          if (selectedIndex == 0)
            IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => AddPostPage()));
              },
              icon: Icon(Icons.add),
            ),
          if (selectedIndex == 0 || selectedIndex == 2)
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 500,
                      child: Center(child: Text("Favorites")),
                    );
                  },
                );
              },
              icon: Icon(Icons.favorite_border),
            ),
          if (selectedIndex == 1 || selectedIndex == 2 || selectedIndex == 3)
            IconButton(onPressed: () {}, icon: Icon(Icons.message)),
        ],
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_camera_back_outlined),
            label: "Reels",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Shop",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
