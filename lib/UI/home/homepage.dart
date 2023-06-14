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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          'Welcome home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        titleTextStyle: const TextStyle(fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.white, size: 25),
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.brown),
              accountName: Text('Widi'),
              accountEmail: Text('widi@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/widi.png'),
              ),
            ),
            ListTile(
              title: const Text('Detail Profil'),
              leading: const Icon(Icons.person),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilPage()));
              },
            ),
            ListTile(
              title: const Text('Data Post'),
              leading: const Icon(Icons.post_add),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const DataPosts()));
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Log-Out'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 70,
                  width: double.infinity,
                  color: Colors.brown,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFF5F5F7),
                            borderRadius: BorderRadius.circular(30)),
                        child: TextField(
                          cursorHeight: 20,
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: "Cari Tempat Favoritmu !",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Category(
                        imagePath: "assets/coffee-cup.png", title: "Tubruk"),
                    Category(imagePath: "assets/coffee.png", title: "Latte"),
                    Category(imagePath: "assets/mesin.png", title: "Espresso"),
                    Category(imagePath: "assets/biji.png", title: "Biji"),
                    Category(imagePath: "assets/biji.png", title: "Good"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Tempat Favorit ☕️",
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
                width: double.infinity,
                height: 360,
                child: _isLoading
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
                                          left: 15,
                                          right: 15,
                                          bottom: 5,
                                          top: 5),
                                      child: Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(post.title,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.star,
                                                      color: Colors.amber),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(post.rating,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 12)),
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
                                                    style:
                                                        GoogleFonts.montserrat(
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
                            }))),
          ],
        )),
      ),
    );
  }
}
