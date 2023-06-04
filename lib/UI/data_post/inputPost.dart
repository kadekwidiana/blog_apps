import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_uts/UI/data_post/posts.dart';
import 'package:project_uts/models/errMsg.dart';
import 'package:project_uts/models/post.dart';
import 'package:project_uts/services/api.dart';

class InputPost extends StatefulWidget {
  final Post post;
  InputPost({required this.post});

  // const InputPost({super.key, required Post post});

  @override
  State<InputPost> createState() => _InputPostState();
}

class _InputPostState extends State<InputPost> {
  final _formkey = GlobalKey<FormState>();
  late TextEditingController title, category, image, rating, description;
  late int id = 0;
  bool _isupdate = false;
  bool _validate = false;
  bool _success = false;
  late ErrorMSG response;
  late String _imagePath = '';
  late String _imageURL = '';
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    title = TextEditingController();
    category = TextEditingController();
    // image = TextEditingController();
    rating = TextEditingController();
    description = TextEditingController();
    if (widget.post.id != 0) {
      id = widget.post.id;
      title = TextEditingController(text: widget.post.title);
      category = TextEditingController(text: widget.post.category);
      rating = TextEditingController(text: widget.post.rating);
      description = TextEditingController(text: widget.post.description);
      _isupdate = true;
      _imageURL = ApiStatic.host + '/storage/' + widget.post.image;
    }
    super.initState();
  }

  // func submit
  void submit() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      var params = {
        'title': title.text.toString(),
        'category': category.text.toString(),
        'rating': rating.text.toString(),
        'description': description.text.toString(),
      };
      response = await ApiStatic.savePost(id, params, _imagePath);
      _success = response.success;
      final snackBar = SnackBar(
        content: Text(response.message),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (_success) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => DataPosts()));
      }
    } else {
      _validate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isupdate
            ? Text('Update ' + widget.post.title)
            : Text('Input data'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: title,
                    validator: (u) => u == "" ? "Wajib isi" : null,
                    decoration: const InputDecoration(
                        // icon: Icon(Icons.title),
                        hintText: "Title",
                        labelText: "Title"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: category,
                    validator: (u) => u == "" ? "Wajib isi" : null,
                    decoration: const InputDecoration(
                        // icon: Icon(Icons.title),
                        hintText: "Category",
                        labelText: "Category"),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(5),
                //   child: TextFormField(
                //     controller: image,
                //     validator: (u) => u == "" ? "Wajib isi" : null,
                //     decoration: const InputDecoration(
                //         // icon: Icon(Icons.title),
                //         hintText: "Image",
                //         labelText: "Image"),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: rating,
                    validator: (u) => u == "" ? "Wajib isi" : null,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        // icon: Icon(Icons.title),
                        hintText: "Rating",
                        labelText: "Rating"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.image),
                      Flexible(
                          child: _imagePath != ''
                              ? GestureDetector(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(_imagePath),
                                      fit: BoxFit.fitWidth,
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                    ),
                                  ),
                                  onTap: () {
                                    getImage(ImageSource.gallery);
                                  })
                              : _imageURL != ''
                                  ? GestureDetector(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          _imageURL,
                                          fit: BoxFit.fitWidth,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                        ),
                                      ),
                                      onTap: () {
                                        getImage(ImageSource.gallery);
                                      })
                                  : GestureDetector(
                                      onTap: () {
                                        getImage(ImageSource.gallery);
                                      },
                                      child: Container(
                                        height: 100,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 25),
                                            ),
                                            Text("Ambil Gambar")
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.greenAccent,
                                                    width: 1))),
                                      ),
                                    ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: description,
                    validator: (u) => u == "" ? "Wajib isi" : null,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      // icon: Icon(Icons.title),
                      hintText: "Description",
                      labelText: "Description",
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                Divider(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          submit();
                        },
                        child: Text(
                          "Simpan",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage(ImageSource media) async {
    var img = await _picker.pickImage(source: media);
    //final pickedImageFile = File(img!.path);
    setState(() {
      _imagePath = img!.path;
      print(_imagePath);
    });
  }
}
