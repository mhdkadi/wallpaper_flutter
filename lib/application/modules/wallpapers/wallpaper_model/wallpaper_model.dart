class Wallpapers {
  List wallpapersList = [];

  Wallpapers.productsFromJson(jsonString) {
    jsonString
        .map(
          (wallpaper) => wallpapersList.add(
            Wallpaper.fromRawJson(wallpaper),
          ),
        )
        .toList();
  }

  List get wallpapers => wallpapersList;
}

class Wallpaper {
  Wallpaper({
    required this.wallpaperId,
    required this.createdAt,
    required this.width,
    required this.height,
    required this.likes,
    required this.description,
    required this.photographer,
    required this.urls,
    required this.downloadLink,
  });

  final String wallpaperId;
  final String createdAt;
  final int width;
  final int height;
  final int likes;
  final String description;
  final String photographer;
  final Map urls;
  final String downloadLink;

  factory Wallpaper.fromRawJson(Map<String, dynamic> map) =>
      Wallpaper.fromJson(map);

  factory Wallpaper.fromJson(Map<String, dynamic> map) => Wallpaper(
        wallpaperId: map["id"],
        createdAt: map["created_at"],
        width: map["width"],
        height: map["height"],
        likes: map["likes"],
        description: map["alt_description"].toString().contains('null')
            ? 'No Description'
            : map["alt_description"],
        photographer: map["user"]["name"].toString().contains('null')
            ? 'Unknown Photographer'
            : map["user"]["name"],
        urls: map["urls"],
        downloadLink: map["links"]["download"],
      );
}
