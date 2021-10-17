import '../../../../core/api_services/api_services.dart';
import '../wallpaper_model/wallpaper_model.dart';

class WallpaperController {
  final String _pixabayApiKey = '15537053-aff0def72215bfb51cfbb3edb';
  final String pixabayBaseUrl = 'https://pixabay.com/api/';
  final ApiServices apiServices;

  WallpaperController({required this.apiServices});
  Future<Wallpapers> getPhotos({
    String color = '',
    String searshQuery = '',
    String category = '',
    String order = 'popular',
    String imagetype = 'all',
    int page = 1,
  }) async {
    try {
      final List<dynamic> response =
          await apiServices.getRequest(url: pixabayBaseUrl, queryParameters: {
        'key': _pixabayApiKey,
        'q': searshQuery,
        'category': category,
        'order': order,
        'page': page,
        'per_page': '10',
        'image_type': imagetype,
        'orientation': 'vertical',
        'colors': color,
      });
      return Wallpapers.productsFromJson(response);
    } catch (error) {
      throw Failure("no_internet");
    }
  }

  Future<bool> downloadPhoto({
    required String imageId,
    required String url,
  }) async {
    final bool response = await apiServices.downloadRequest(
      url: pixabayBaseUrl + 'photos/$imageId/download',
      fileName: '$imageId.jpg',
      savePath: "storage/emulated/0/DCIM/Flutter Wallpaper/",
      queryParameters: {
        'client_id': _pixabayApiKey,
      },
    );
    return response;
  }
}
