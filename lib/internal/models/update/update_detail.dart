class UpdateDetails {
  String version;
  double versionDouble;
  String publishDate;
  String updateDetails;
  Uri armeabi;
  Uri arm64;
  Uri general;
  Uri x86;

  UpdateDetails(
      {required this.version,
      this.versionDouble = 0,
      required this.publishDate,
      required this.updateDetails,
      required this.arm64,
      required this.armeabi,
      required this.general,
      required this.x86});

  factory UpdateDetails.fromMap(dynamic map) {
    return UpdateDetails(
        version: _getRemoteVersion(map['name']),
        versionDouble: _remoteVersionDouble(_getRemoteVersion(map['name'])),
        publishDate: map["published_at"].split("T").first,
        updateDetails: map["body"],
        arm64: _getPlatformType(SupportedAbi.arm64, assets: map["assets"]),
        armeabi: _getPlatformType(SupportedAbi.armeabi, assets: map["assets"]),
        general: _getPlatformType(SupportedAbi.general, assets: map["assets"]),
        x86: _getPlatformType(SupportedAbi.x86, assets: map["assets"]));
  }
  @override
  String toString() {
    return "{Version: $version, publishDate: $publishDate,"
        "\narm: $armeabi,\narm64: $arm64,\n"
        "updateDetails: $updateDetails}";
  }
}

/// Common android abi
enum SupportedAbi {
  arm64, //arm64-v8a
  armeabi, //armeabi-v7a
  general,
  x86,
}

/// Parse apk url to various class fields
Uri _getPlatformType(SupportedAbi abi, {required List<dynamic> assets}) {
  var url = "";

  /// Special method to set general field since the url
  /// doesn't contain any method to identify it.
  if (SupportedAbi.general == abi) {
    for (var i = 0; i < assets.length; i++) {
      String? abiUrl = assets[i]["browser_download_url"];
      if (!(abiUrl!.contains(SupportedAbi.x86.name) |
          abiUrl.contains(SupportedAbi.arm64.name) |
          abiUrl.contains(SupportedAbi.armeabi.name))) {
        url = abiUrl;
        return Uri.parse(url);
      }
    }
  }
  for (var i = 0; i < assets.length; i++) {
    String? abiUrl = assets[i]["browser_download_url"];
    if (abiUrl!.contains(abi.name)) {
      url = abiUrl;
      break;
    }
  }
  return Uri.parse(url);
}

String _getRemoteVersion(String version) => version.split(" ").last;

double _remoteVersionDouble(String version) =>
    double.parse(version.split("+").first.replaceRange(3, 5, ""));
