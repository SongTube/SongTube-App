import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/models/timestamp.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:validators/validators.dart';

class LinkifyText extends StatelessWidget {
  const LinkifyText({
    required this.text,
    this.style,
    this.onLinkTap,
    this.onTimestampTap,
    super.key});
  final String text;
  final TextStyle? style;
  final Function(Duration)? onTimestampTap;
  final Function(String)? onLinkTap;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final strings = Timestamp.parseStringForTimestamps(text);
        Paint timestampPaint = Paint()
          ..color = Theme.of(context).primaryColor.withOpacity(0.2)
          ..style = PaintingStyle.fill
          ..strokeCap = StrokeCap.butt;
        return RichText(
          text: TextSpan(
            style: style ?? smallTextStyle(context, opacity: 0.8),
            children: List.generate(strings.length, (index) {
              final string = strings[index];
              if (string is Timestamp) {
                return TextSpan(
                  style: (style ?? smallTextStyle(context, bold: true, opacity: 0.8)).copyWith(color: Theme.of(context).primaryColor, background: timestampPaint),
                  text: string.text.contains('\n') ? string.text : ' ${string.text} ',
                  recognizer: onTimestampTap != null ? (TapGestureRecognizer()
                  ..onTap = () {
                      onTimestampTap!(string.duration);
                    }) : null
                );
              } else if (isURL((string as String).replaceAll('\n', ''))){
                return TextSpan(
                  style: (style ?? smallTextStyle(context, bold: true, opacity: 0.8)).copyWith(color: Theme.of(context).primaryColor, background: timestampPaint),
                  text: string.contains('\n') ? string : ' $string ',
                  recognizer: onLinkTap != null ? (TapGestureRecognizer()
                  ..onTap = () {
                      onLinkTap!(string);
                    }) : null
                );
              } else {
                return TextSpan(
                  text: string.endsWith('\n') ? string : '$string '
                );
              }
            })
          )
        );
      }
    );
  }
}