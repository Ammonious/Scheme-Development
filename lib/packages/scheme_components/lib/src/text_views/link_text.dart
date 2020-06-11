import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'auto_size_text.dart';

class LinkText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final TextStyle linkStyle;
  final TextAlign textAlign;
  final int maxLines;
  const LinkText(this.text,{
    this.style,
    this.linkStyle,
    this.maxLines,
    this.textAlign = TextAlign.start,
  })  : assert(text != null);

  @override
  _LinkTextState createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  List<TapGestureRecognizer> _gestureRecognizers;
  final RegExp _regex = RegExp(
      r"https?:\/\/(www\.)?[-a-zA-Z0-9@:%.,_\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\,+.~#?&//=]*)");

  @override
  void initState() {
    super.initState();
    _gestureRecognizers = <TapGestureRecognizer>[];
  }

  @override
  void dispose() {
    _gestureRecognizers.forEach((recognizer) => recognizer.dispose());
    super.dispose();
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textStyle = this.widget.style ?? themeData.textTheme.body1;
    final linkStyle = this.widget.linkStyle ??
        themeData.textTheme.body1.copyWith(
          color: themeData.accentColor,
          decoration: TextDecoration.underline,
        );

    final links = _regex.allMatches(widget.text);

    if (links.isEmpty) {
      return AutoSizeText(
        widget.text,
        style: textStyle,
        maxLines: widget.maxLines,
      );
    }

    final textParts = widget.text.split(_regex);
    final textSpans = <TextSpan>[];

    int i = 0;
    textParts.forEach((part) {
      textSpans.add(TextSpan(text: part, style: textStyle));

      if (i < links.length) {
        final link = links.elementAt(i).group(0);
        final recognizer = TapGestureRecognizer()..onTap = () => _launchUrl(link);

        _gestureRecognizers.add(recognizer);
        textSpans.add(
          TextSpan(
            text: link,
            style: linkStyle,
            recognizer: recognizer,
          ),
        );

        i++;
      }
    });

    return AutoSizeText.rich(
      TextSpan(children: textSpans),
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
    );
  }
}
