import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:songtube/internal/models/backup_model.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/ui/sheet_phill.dart';
import 'package:songtube/ui/sheets/snack_bar.dart';
import 'package:songtube/ui/text_styles.dart';

class BackupRestoreSheet extends StatelessWidget {
  const BackupRestoreSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.center,
            child: BottomSheetPhill()),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(Ionicons.arrow_back_outline, color: Theme.of(context).primaryColor),
                  )
                ),
                Expanded(child: Text('Backup or Restore', style: textStyle(context))),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Divider(indent: 12, endIndent: 12, color: Theme.of(context).dividerColor),
          const SizedBox(height: 8),
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
  }
  
  Widget _optionTile(BuildContext context, {required String title, required String subtitle, required IconData icon, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 6),
        height: kToolbarHeight,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Icon(icon, color: Theme.of(context).primaryColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: smallTextStyle(context).copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
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