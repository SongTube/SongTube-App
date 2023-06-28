
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:image_fade/image_fade.dart';
import 'package:line_icons/line_icons.dart';
import 'package:songtube/internal/models/media_item_models.dart';
import 'package:songtube/internal/music_brainz.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:transparent_image/transparent_image.dart';

class ArtistCardTile extends StatefulWidget {
  const ArtistCardTile({
    required this.artist,
    required this.onTap,
    this.height = 100,
    this.width = 100,
    this.showDetails = false,
    Key? key }) : super(key: key);
  final MediaItemArtist artist;
  final double height;
  final double width;
  final bool showDetails;
  final Function(MediaItemArtist) onTap;

  @override
  State<ArtistCardTile> createState() => _ArtistCardTileState();
}

class _ArtistCardTileState extends State<ArtistCardTile> {

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: const Duration(milliseconds: 80),
      onPressed: () {
        widget.onTap(widget.artist);
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Album Artwork
            Container(
              height: widget.height,
              width: widget.width,
              margin: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,
                    offset: const Offset(0,0),
                    color: Theme.of(context).shadowColor.withOpacity(0.1)
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FutureBuilder<String?>(
                  future: MusicBrainzAPI.getArtistImage(widget.artist.artistName.trim()),
                  builder: (context, snapshot) {
                    return ImageFade(
                      placeholder: Image.asset('assets/images/artworkPlaceholder_big.png', fit: BoxFit.cover),
                      image: snapshot.hasData && snapshot.data != null
                        ? NetworkImage(snapshot.data!)
                        : MemoryImage(kTransparentImage) as ImageProvider,
                      fit: BoxFit.cover,
                      errorBuilder: (context, child, exception) {
                        return Image.asset('assets/images/artworkPlaceholder_big.png', fit: BoxFit.cover);
                      },
                    );
                  }
                ),
              )
            ),
            // Album Details
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                  width: double.infinity,
                  height: kToolbarHeight,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Artist Name
                                Text(
                                  widget.artist.artistName,
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: tinyTextStyle(context).copyWith(
                                    fontWeight: FontWeight.bold)
                                ),
                                Text(
                                  '${widget.artist.mediaItems.length} ${Languages.of(context)!.labelSongs}',
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: tinyTextStyle(context)
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(LineIcons.user, size: 16)
                        ],
                      ),
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