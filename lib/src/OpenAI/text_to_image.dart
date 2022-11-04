import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bot/src/api/api_call_ai.dart';
import 'package:chat_bot/src/utils/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stts;

class TextToImageAI extends StatefulWidget {
  const TextToImageAI({Key? key}) : super(key: key);

  @override
  State<TextToImageAI> createState() => _TextToImageAIState();
}

class _TextToImageAIState extends State<TextToImageAI> {
  stts.SpeechToText _speechText = stts.SpeechToText();
  bool selected = true;
  bool _isGlow = true;
  bool _isListening = false;
  String recordedText = '';
  String _textImage = '';

  @override
  void initState() {
    _speechText = stts.SpeechToText();
    super.initState();
  }

  _callAI({required String message}) async {
    _textImage = await ApiCallAI.getRoboResponseImage(message: message);
    setState(() {});
  }

  _speechToText() async {
    if (!_isListening) {
      bool isListen = await _speechText.initialize(
          onStatus: (status) {
            log('onStatus: ' + status);
            if (status == 'done') {
              _callAI(message: recordedText);
              setState(() {
                _isListening = false;
                selected = true;
                _isGlow = true;
              });
            }
          },
          onError: (err) => log(err.toString()));
      if (isListen) {
        setState(() {
          _isListening = true;
        });
        await _speechText.listen(
            onResult: (result) => setState(() {
                  recordedText = result.recognizedWords;
                }));
      }
    } else {
      setState(() {
        _isListening = false;
      });
      _speechText.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            margin: EdgeInsets.only(
              left: screenSizeConfig(context, 16.0),
              right: screenSizeConfig(context, 16.0),
              top: screenSizeConfig(context, 46.0),
              bottom: screenSizeConfig(context, 16.0),
            ),
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 16,
                  spreadRadius: 16,
                )
              ],
              color: Colors.white.withOpacity(0.2),
              border: Border.all(
                  color: Colors.blueAccent.withOpacity(0.2), width: 1.2),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: _textImage.isNotEmpty
                      ? Padding(
                          padding:
                              EdgeInsets.all(screenSizeConfig(context, 8.0)),
                          child: SizedBox(
                            height: screenSizeConfig(context, 180),
                            width: screenSizeConfig(context, 180),
                            child: CachedNetworkImage(
                              imageUrl: _textImage,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        )
                      : DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 22,
                            letterSpacing: 5.0,
                          ),
                          child: AnimatedTextKit(
                            totalRepeatCount: 100,
                            animatedTexts: [
                              WavyAnimatedText('• • • '),
                            ],
                            isRepeatingAnimation: true,
                          ),
                        ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 1.4,
                  child: LottieBuilder.asset(
                    "assets/lotties/ai_robot.json",
                  ),
                ),
                AnimatedPadding(
                  curve: Curves.bounceInOut,
                  duration: const Duration(seconds: 2),
                  padding: EdgeInsets.symmetric(
                      vertical: screenSizeConfig(context, 8.0)),
                  child: Text(
                    recordedText.isEmpty ? 'Tap To Listen ...' : recordedText,
                    style: GoogleFonts.gabriela(
                      color: Colors.white,
                      letterSpacing: 2.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                AvatarGlow(
                  duration: const Duration(seconds: 1),
                  endRadius: screenSizeConfig(context, 80),
                  animate: _isGlow,
                  repeat: _isGlow,
                  child: InkWell(
                    onTap: () async {
                      await _speechToText();
                      setState(() {
                        _textImage = '';
                        selected = !selected;
                        _isGlow = !_isGlow;
                        recordedText = '';
                      });
                    },
                    child: AnimatedContainer(
                      width: selected
                          ? screenSizeConfig(context, 100.0)
                          : screenSizeConfig(context, 120.0),
                      height: selected
                          ? screenSizeConfig(context, 100.0)
                          : screenSizeConfig(context, 120.0),
                      alignment: selected
                          ? Alignment.center
                          : AlignmentDirectional.bottomCenter,
                      duration: const Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: selected ? Colors.red : Colors.blue,
                            width: screenSizeConfig(context, 5.0)),
                      ),
                      child: Icon(
                        Icons.keyboard_voice,
                        size: screenSizeConfig(context, 50),
                        color: selected ? Colors.red : Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
