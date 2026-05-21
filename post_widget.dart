import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final Map<String, dynamic> postData;
  const PostWidget({super.key, required this.postData});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(backgroundColor: Colors.green),
          title: Text(widget.postData["userName"]),
          trailing: Icon(Icons.more_horiz),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(widget.postData["postUrl"]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
            IconButton(onPressed: () {}, icon: Icon(Icons.comment)),
            IconButton(onPressed: () {}, icon: Icon(Icons.send)),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_border)),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 25,
                child: Stack(
                  children: [
                    Positioned(
                      left: 30,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 12,
                      ),
                    ),
                    Positioned(
                      left: 15,
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 12,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(flex: 6, child: Text("Liked by Esakki and 100 others")),
          ],
        ),
        SizedBox(),
        Text(widget.postData["caption"]),
      ],
    );
  }
}
