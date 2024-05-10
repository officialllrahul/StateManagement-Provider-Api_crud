import 'package:flutter/material.dart';

class MovieDetails extends StatefulWidget {
  final String poster;

  const MovieDetails({super.key, required this.poster});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${widget.poster}',
              width: 200,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.green,
            margin: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                // Add your button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.play_arrow,
                    size: 40,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Watch Now",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            // Set the background color here
                            border: Border.all(
                              color: Colors.green,
                              width: 4.0,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            color: Colors.black,
                            icon: Icon(Icons.play_arrow, color: Colors.green),
                            iconSize: 40,
                            onPressed: () {
                              // Add your onPressed logic here
                              print('Button Pressed!');
                            },
                          ),
                        ),
                      ),
                      Text(
                        "Trailer",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            // Set the background color here
                            border: Border.all(
                              color: Colors.green,
                              width: 4.0,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            color: Colors.black,
                            icon: Icon(Icons.add, color: Colors.green),
                            iconSize: 40,
                            onPressed: () {
                              // Add your onPressed logic here
                              print('Button Pressed!');
                            },
                          ),
                        ),
                      ),
                      Text(
                        "Watch list",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            // Set the background color here
                            border: Border.all(
                              color: Colors.green,
                              width: 4.0,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            color: Colors.black,
                            icon: Icon(Icons.more_vert, color: Colors.green),
                            iconSize: 40,
                            onPressed: () {
                              // Add your onPressed logic here
                              print('Button Pressed!');
                            },
                          ),
                        ),
                      ),
                      Text(
                        "More",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  )
                ]),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                  "Presenting the official trailor of RRR in cinemas near you on April 7th 2020")),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Text("IMBD")),
                Text("9.5/10.0")
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text("Categories :"),
                Text("Action, Drama")
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text("Languages :"),
                Text("Hindi, Tamil")
              ],
            ),
          )
        ],
      )),
    );
  }
}
