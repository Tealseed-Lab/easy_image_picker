class AssetImageInfo {
  String? id;
  final String path;
  final String? mimeType;
  final String? name;

  AssetImageInfo({
    this.id,
    required this.path,
    this.mimeType,
    this.name,
  });

  bool get isNetworkImage {
    Uri uri = Uri.parse(path);
    return uri.isScheme('HTTP') || uri.isScheme('HTTPS');
  }
}
