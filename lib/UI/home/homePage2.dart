import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_uts/UI/data_post/posts.dart';
import 'package:project_uts/UI/login/login.dart';
import 'package:project_uts/UI/profil/profilpage.dart';
import '../widget/category.dart';
import '../widget/coffee_shop.dart';
import 'package:project_uts/models/post.dart';
import 'package:project_uts/services/api.dart';
import 'package:project_uts/UI/detail/detailPost.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  List<Post> _posts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Post> posts = await ApiStatic.getPost();
      setState(() {
        _posts = posts;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error
      print('Failed to fetch posts: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshPosts() async {
    await fetchPosts();
  }

  void _showPostDetail(Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        // builder: (context) => PostDetailPage(post: post),
        builder: (context) => DetailPost(
          post: post,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Favorit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        titleTextStyle: const TextStyle(fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.white, size: 25),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _refreshPosts,
              child: ListView.builder(
                  itemCount: _posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == _posts.length) {
                      if (_isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                    Post post = _posts[index];

                    return SizedBox(
                      width: double.infinity,
                      height: 240,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 5, top: 5),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 10,
                              child: Column(
                                children: <Widget>[
                                  GestureDetector(
                                    child: Container(
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 150,
                                        child: Image.network(
                                          ApiStatic.host +
                                              "/storage/" +
                                              post.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      _showPostDetail(post);
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 10,
                            child: SizedBox(
                              height: 70,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(post.title,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.amber),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(post.rating + '(32 riview)',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12)),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(
                                          Icons.category,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          post.category,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(
                                          Icons.access_time,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          post.jam_buka,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  })),
    );
  }
}
