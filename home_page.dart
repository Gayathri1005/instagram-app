import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/widgets/post_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: index == 0
                                ? null
                                : LinearGradient(
                                    colors: [
                                      Colors.pink,
                                      Colors.purple,
                                      Colors.blue,
                                      Colors.black,
                                      Colors.orange,
                                      Colors.pink,
                                      Colors.purple,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                          ),
                          child: Container(
                            height: 75,
                            width: 75,
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Container(
                              height: 70,
                              width: 70,
                              margin: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://www.shutterstock.com/image-photo/knitted-pink-heart-legs-baby-600nw-2166045081.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("Esakki"),
                      ],
                    ),
                    if (index == 0)
                      Positioned(
                        bottom: 35,
                        right: 17,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.blue,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Divider(),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("posts")
                  .orderBy("dateTime", descending: true)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) => PostWidget(
                    postData:
                        snapshot.data?.docs[index].data()
                            as Map<String, dynamic>,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
