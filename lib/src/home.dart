import 'package:chat_bot/src/OpenAI/chat_with_ai.dart';
import 'package:chat_bot/src/OpenAI/talk_with_ai.dart';
import 'package:chat_bot/src/OpenAI/text_to_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Open AI',
          style: GoogleFonts.gabriela(),
        ),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TalkWithAI(),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  "Talk With AI",
                  style: GoogleFonts.gabriela(fontSize: 18),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatWithAI(),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.teal[200],
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  'Chat With AI',
                  style: GoogleFonts.gabriela(fontSize: 18),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TextToImageAI(),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.teal[400],
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  "Text To Image",
                  style: GoogleFonts.gabriela(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
