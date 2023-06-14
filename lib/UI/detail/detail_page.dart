import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class DetailPage extends StatefulWidget {
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double widht = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.grey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Stack Foto dan container
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: height * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/kolam.jpeg"))),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        )),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      child: Icon(
                        Icons.assistant_direction,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Air Terjun",
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    height: height * .09,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "4.6 (32 riview)",
                          style: GoogleFonts.montserrat(fontSize: 12),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "07:00 - 17:00",
                          style: GoogleFonts.montserrat(fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
              ),

              // Card Promo
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.amber[100],
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Ada promo untuk kamu",
                              style: GoogleFonts.montserrat(fontSize: 12),
                            ),
                            Text(
                              "Booking Tiket Sekarang",
                              style: GoogleFonts.montserrat(fontSize: 11),
                            ),
                          ],
                        ),
                        ElevatedButton(onPressed: () {}, child: Text("Book!"))
                      ],
                    ),
                  ),
                ),
              ),

              //Deskripsi
              TitleDetail(
                  title: "Deskripsi :",
                  detail:
                      "Sekumpul waterfall masuk dalam kategori air terjun tersembunyi di Bali Utara. Selain itu, banyak wisatawan mengatakan, Sekumpul waterfall, air terjun paling indah di Bali. Pada halaman ini, saya akan menuliskan untuk anda panduan liburan ke tempat wisata air terjun Sekumpul Buleleng Bali. Salah satu tempat wisata menarik di Bali yang wajib anda kunjungi. Info liburan yang akan anda temukan seperti keunikan, cara menuju ke lokasi dan harga tiket masuk Sekumpul Waterfall."),
              // Title Ulasan
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Ulasan :",
                  style: GoogleFonts.montserrat(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),

              // Widget Ulasan
              Comment(
                  image:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsDk8zs7Ssxa3I--LGT223HBG8UICIIxjcVA&usqp=CAU',
                  username: 'Ayikkk',
                  coment: 'Tempat nya sangat bagus'),

              Comment(
                image:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsDk8zs7Ssxa3I--LGT223HBG8UICIIxjcVA&usqp=CAU',
                username: 'Natasya',
                coment: 'Cocok buat ber akhir pekan.',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String image;
  final String username;
  final String coment;
  const Comment(
      {Key? key,
      required this.image,
      required this.username,
      required this.coment})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                image,
                width: 40,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(username),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            coment,
            style: GoogleFonts.montserrat(fontSize: 12),
          )
        ],
      ),
    );
  }
}

class TitleDetail extends StatelessWidget {
  final String title;
  final String detail;
  const TitleDetail({Key? key, required this.title, required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
                fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            detail,
            style: GoogleFonts.montserrat(fontSize: 12),
          )
        ],
      ),
    );
  }
}
