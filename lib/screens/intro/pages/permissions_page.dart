import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/ui/animations/show_up.dart';

class PermissionIntroPage extends StatefulWidget {
  const PermissionIntroPage({
    required this.onStorageGranted,
    Key? key }) : super(key: key);
  final Function(bool) onStorageGranted;

  @override
  State<PermissionIntroPage> createState() => _PermissionIntroPageState();
}

class _PermissionIntroPageState extends State<PermissionIntroPage> {

  // Switching to next page, using this boolean to animated this page exit
  bool switchingToNextPage = false;

  // Permissions status
  bool hasPermission = false;

  // App already has granted storage permission
  bool alreadyGranted = false;

  @override
  void initState() {
    Permission.storage.status.then((status) {
      if (status != PermissionStatus.granted) {
        if (mounted) {
          setState(() {
            hasPermission = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            hasPermission = true;
            alreadyGranted = true;
          });
        }
      }
    });
    super.initState();
  }

  void requestPermissions() async {
    final status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      if (mounted) {
        setState(() {
          hasPermission = true;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          hasPermission = false;
        });
      }
    }
    setState(() {
      switchingToNextPage = true;
    });
    await Future.delayed(const Duration(milliseconds: 200));
    widget.onStorageGranted(alreadyGranted);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: switchingToNextPage ? 0 : 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // App Name
            const SizedBox(height: 90),
            ShowUpTransition(
              forward: hasPermission
                ? false : true,
              delay: const Duration(milliseconds: 300),
              child: Text(
                Languages.of(context)!.labelAllowUsToHave,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: hasPermission
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.bodyText1!.color
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ShowUpTransition(
              delay: const Duration(milliseconds: 400),
              child: Text(
                Languages.of(context)!.labelStorageRead,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w800,
                  fontSize: 56,
                  letterSpacing: 1,
                  color: hasPermission
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.bodyText1!.color
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            // Allow storage button
            ShowUpTransition(
              delay: const Duration(milliseconds: 500),
              child: Text(
                Languages.of(context)!.labelStorageReadDescription,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            ShowUpTransition(
              delay: const Duration(milliseconds: 500),
              child: InkWell(
                onTap: requestPermissions,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  padding: const EdgeInsets.only(
                    top: 16, bottom: 16, left: 32, right: 32
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 100),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: hasPermission
                            ? Icon(Icons.lock_open_outlined, color: hasPermission
                              ? Theme.of(context).primaryColor
                              : Colors.white)
                            : Icon(Icons.lock_outline, color: hasPermission
                              ? Theme.of(context).primaryColor
                              : Colors.white),
                        ),
                        const SizedBox(width: 8),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          key: UniqueKey(),
                          child: Text(
                            hasPermission
                              ? Languages.of(context)!.labelContinue
                              : Languages.of(context)!.labelAllowStorageRead,
                            style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}