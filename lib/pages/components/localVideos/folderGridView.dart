// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/internal/models/folder.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class FolderGridView extends StatelessWidget {
  final List<FolderItem>? list;
  final Function(FolderItem) onFolderTap;
  FolderGridView({
    required this.list,
    required this.onFolderTap
  });
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: list!.length,
      itemBuilder: (context, index) {
        FolderItem folder = list![index];
        return Padding(
          padding: EdgeInsets.only(
            top: index == 0 || index == 1 ? 16 : 8,
            bottom: 8,
            left: 8,
            right: 8
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            splashColor: Theme.of(context).accentColor.withOpacity(0.1),
            onTap: () => onFolderTap(folder),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(color: Colors.grey[600]!.withOpacity(0.1))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Icon(
                      EvaIcons.folderOutline,
                      size: 70,
                      color: Theme.of(context).iconTheme.color!.withOpacity(0.5)
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      folder.name == "0" ? "Internal Storage" : folder.name!,
                      maxLines: 1,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                        fontSize: 14,
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w600
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}