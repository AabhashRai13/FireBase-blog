import 'package:firebaseblog/db/PostService.dart';
import 'package:firebaseblog/models/post.dart';
import 'package:firebaseblog/screens/home.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final GlobalKey<FormState> formkey = new GlobalKey();
  Post post=Post(0, " ", " ");



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add your post"),
      ),
      body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Post title",
                  ),
                  onSaved: (val) => post.title = val,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Title field can't be empty";
                    }else if(val.length >16){
                      return "title cannot have more than 16 characters";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Post Body"),
                  onSaved: (val) => post.body = val,

                  validator: (val) {
                    if (val.isEmpty) {
                      return "Body field can't be empty";
                    }
                  },
                ),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          insertPost();
          Navigator.pop(context);
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.black87,
        tooltip: "add a post",
      ),
    );
  }

  void insertPost() {
    final FormState form = formkey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      post.date = DateTime.now().millisecondsSinceEpoch;
      PostService postService = PostService(post.toMap());

      postService.addPost();
    }
  }
}
