import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseblog/models/post.dart';
class PostService{
  String nodeName = "posts";
  FirebaseDatabase database = FirebaseDatabase.instance;
   DatabaseReference _databaseReference;
   Map post;

  PostService(this.post);
  addPost(){
// this is going to give a reference to the post node
    _databaseReference =database.reference().child(nodeName);
    _databaseReference.push().set(post);
  }
  deletePost( ){
    database.reference().child('$nodeName/${post['key']}').remove();
  }

  updatePost(){
    database.reference().child('$nodeName/${post['key']}').update(
      {"title":post['title'],"body":post['body'],"date":post['date']}
    );

  }
}