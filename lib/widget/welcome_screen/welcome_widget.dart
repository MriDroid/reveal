import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../../provider/tts.dart';

class WelcomeWidget extends StatefulWidget {
  late final String sMsg;
  late final String image;
  late final String header;
  late final String body;
  late final Function doubleClick;

  WelcomeWidget(
      this.sMsg, this.image, this.header, this.body, this.doubleClick);

  @override
  State<StatefulWidget> createState() {
    return _WelcomeWidget();
  }
}

class _WelcomeWidget extends State<WelcomeWidget>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Provider.of<TextToSpeech>(context, listen: false).initTts();
  }

  @override
  void dispose() {
    Provider.of<TextToSpeech>(context, listen: false).distroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _tts = Provider.of<TextToSpeech>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            _tts.onChange(widget.sMsg);
            _tts.stop(() {});
            _tts.speak();
          },
          onDoubleTap: () {
            _tts.stop(() {});
            widget.doubleClick();
          },
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 100, horizontal: 10),
                width: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(widget.image),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 80),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.header,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    height: 3,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.indigo,
                                    fontFamily: 'RobotoSlab',
                                  ),
                            ),
                            TextSpan(
                              text: widget.body,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    height: 1.5,
                                    fontFamily: 'RobotoSlab',
                                    wordSpacing: 1,
                                    fontSize: 16,
                                    color: Colors.indigo,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
