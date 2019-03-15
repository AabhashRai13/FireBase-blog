import 'package:firebaseblog/db/PostService.dart';
import 'package:firebaseblog/models/post.dart';
import 'package:flutter/material.dart';

class editPost extends StatefulWidget {
  final Post post;

  editPost(this.post);

  @override
  _editPostState createState() => _editPostState();
}

class _editPostState extends State<editPost> {
  final GlobalKey<FormState> formkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit your post"),
      ),
      body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: widget.post.title,
                  decoration: InputDecoration(
                    labelText: "Post title",
                  ),
                  onSaved: (val) => widget.post.title = val,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Title field can't be empty";
                    } else if (val.length > 16) {
                      return "title cannot have more than 16 characters";
                    }
                  },
                ),
                TextFormField(
                  initialValue: widget.post.body,
                  decoration: InputDecoration(labelText: "Post Body"),
                  onSaved: (val) => widget.post.body = val,
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
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.black87,
        tooltip: "edit post",
      ),
    );
  }

  void insertPost() {
    final FormState form = formkey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      widget.post.date = DateTime.now().millisecondsSinceEpoch;
      PostService postService = PostService(widget.post.toMap());

      postService.updatePost();
    }
  }
}
