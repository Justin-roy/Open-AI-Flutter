import 'package:chat_bot/src/api/api_call_ai.dart';
import 'package:chat_bot/src/model/open_ai_model.dart';
import 'package:chat_bot/src/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatWithAI extends StatefulWidget {
  const ChatWithAI({Key? key}) : super(key: key);

  @override
  State<ChatWithAI> createState() => _ChatWithAIState();
}

class _ChatWithAIState extends State<ChatWithAI> {
  List<String> _userText = [];
  List<String> _roboText = [];
  List<Choice> aiAnswer = [];

  final _text = TextEditingController();
  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _userText.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: index % 2 == 0
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: index % 2 == 0 ? Colors.green : Colors.amber,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            index % 2 == 0
                                ? (_roboText.isEmpty)
                                    ? '...'
                                    : _roboText[index]
                                : _userText[index],
                            style: GoogleFonts.gabriela(
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            TextFieldInput(
              onpress: () async {
                setState(() {
                  _userText.add(_text.text);
                });
                aiAnswer = await ApiCallAI.getRoboResponse(message: _text.text);
                setState(() {
                  _roboText.add(aiAnswer[0].text);
                  _text.clear();
                });
              },
              textEditingController: _text,
              hintText: 'Type something here ..',
              textInputType: TextInputType.name,
            ),
          ],
        ),
      ),
      // bottomNavigationBar:
    );
  }
}
