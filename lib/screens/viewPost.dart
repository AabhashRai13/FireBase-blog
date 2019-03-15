import 'package:firebaseblog/screens/editPost.dart';
import 'package:firebaseblog/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebaseblog/models/post.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:firebaseblog/db/PostService.dart';

class PostView extends StatefulWidget {
  final Post post;

  PostView(this.post);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[

                 Expanded(
                  child: Text(timeago.format(
                      DateTime.fromMillisecondsSinceEpoch(widget.post.date))),
                ),

              Padding(
                padding: const EdgeInsets.all(0.0),
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    PostService postService = PostService(widget.post.toMap());
                    postService.deletePost();
                    Navigator.pop(context);
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));

                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> editPost(widget.post)));

                  },
                ),
              ),

            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.post.body),
          ),
        ],
      ),
    );
  }
}
