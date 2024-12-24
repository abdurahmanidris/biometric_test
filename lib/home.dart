import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final String text = '1234567823109021';
    final String spacedText = text
        .replaceAllMapped(RegExp(r'.{1,4}'), (match) => '${match.group(0)} ')
        .trim();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Container(
          height: 220,
          width: 350,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                spreadRadius: 1,
              )
            ],
            gradient: LinearGradient(
              colors: [Colors.purple.shade800, Colors.purple.shade300],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Credit Card',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Image.asset("assets/images/cbe_logo.png", width: 50)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset("assets/images/env.png"),
                  ),
                  Text(
                    // '1234 5678 2310 9021',
                    spacedText,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        letterSpacing: 2,
                        fontFamily: 'Roboto-Bold',
                        shadows: [
                          Shadow(
                            offset: Offset(4, 4),
                            blurRadius: 10.0,
                            color: Colors.black38,
                          )
                        ]),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    RichText(
                        text: TextSpan(
                            text: 'Valid Till     ',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                            children: [
                          const TextSpan(
                            text: '27/12/2027',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ])),
                  ]),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Abdurahman Idris',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                        ),
                      ),
                      Image.asset("assets/images/visa_logo.png", width: 60)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
