import 'package:flutter/material.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/ui/animations/animated_text.dart';
import 'package:songtube/ui/components/common_sheet_widget.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/text_styles.dart';

class DisclaimerSheet extends StatelessWidget {
  const DisclaimerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSheet(
      useCustomScroll: false,
      builder: (context, scrollController) {
        return CommonSheetWidget(
          title: 'Disclaimer',
          body: Text(
            // ignore: prefer_interpolation_to_compose_strings
            "This Software is released \"as-is\", without any warranty, responsibility or liability. " +
            "In no event shall the Author of this Software be liable for any special, consequential, " +
            "incidental or indirect damages whatsoever (including, without limitation, damages for "   +
            "loss of business profits, business interruption, loss of business information, or any "   +
            "other pecuniary loss) arising out of the use of inability to use this product, even if "  +
            "Author of this Sotware is aware of the possibility of such damages and known defect.",
            textAlign: TextAlign.justify,
            style: subtitleTextStyle(context, opacity: 0.6).copyWith(fontSize: 14),
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(15)
              ),
              child: TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: AnimatedText(Languages.of(context)!.labelContinue, style: subtitleTextStyle(context).copyWith(fontSize: 14)),
                )
              ),
            )
          ],
        );
      },
    );
  }
}