import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:songtube/internal/models/backup_model.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/sheet_phill.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/sheets/snack_bar.dart';
import 'package:songtube/ui/text_styles.dart';

class BackupRestoreSheet extends StatelessWidget {
  const BackupRestoreSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSheet(
      useCustomScroll: false,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.all(12.0).copyWith(top: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const AppAnimatedIcon(Iconsax.arrow_left, size: 22)
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(Languages.of(context)!.labelBackupAndRestore, style: textStyle(context, bold: false))),
                ],
              ),
              const SizedBox(height: 12),
              // Backup
              _optionTile(context,
                title: Languages.of(context)!.labelBackup,
                subtitle: Languages.of(context)!.labelBackupDescription,
                icon: Iconsax.save_2,
                onTap: () async {
                  final result = await BackupModel.generateBackup(context);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  if (result != null) {
                    showSnackbar(customSnackBar: CustomSnackBar(icon: Iconsax.save_2, title: Languages.of(context)!.labelBackupCreated));
                  }
                }
              ),
              // Restore
              _optionTile(context,
                title: Languages.of(context)!.labelRestore,
                subtitle: Languages.of(context)!.labelRestoreDescription,
                icon: Iconsax.refresh_left_square,
                onTap: () async {
                  final result = await BackupModel.restoreBackup(context);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  if (result) {
                    showSnackbar(customSnackBar: CustomSnackBar(icon: Iconsax.refresh_left_square, title: Languages.of(context)!.labelBackupRestored));
                  }
                }
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _optionTile(BuildContext context, {required String title, required String subtitle, required IconData icon, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
        height: kToolbarHeight+4,
        child: Row(
          children: [
            AppAnimatedIcon(icon),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: subtitleTextStyle(context)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: tinyTextStyle(context, opacity: 0.6))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}