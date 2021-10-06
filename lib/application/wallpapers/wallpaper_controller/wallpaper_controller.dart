import '../../../core/api_services/api_services.dart';
import '../wallpaper_model/wallpaper_model.dart';

class WallpaperController {
  final String _unsplashApiKey = 'WRhWAYcJZOy-xruGBn__fvVjaPEV171Tikrcgmsn3lM';
  final unsplashBaseUrl = 'https://api.unsplash.com/';
  final ApiServices apiServices;

  WallpaperController({required this.apiServices});
  Future<Wallpapers> getPhotos({required int page}) async {
    try {
      final List<dynamic> response = await apiServices.getRequest(
          url: unsplashBaseUrl + 'photos/',
          queryParameters: {
            'client_id': _unsplashApiKey,
            'per_page': '30',
            'page': page
          });
      return Wallpapers.productsFromJson(response);
    } catch (error) {
      throw Failure("no_internet");
    }
  }

  Future<Wallpapers> searshPhotos(
      {required int page, required String searshQuery}) async {
    final List<dynamic> response = await apiServices
        .getRequest(url: unsplashBaseUrl + 'search/photos/', queryParameters: {
      'client_id': _unsplashApiKey,
      'per_page': '30',
      'page': page,
      'query': searshQuery
    });
    return Wallpapers.productsFromJson(response);
  }

  Future<bool> downloadPhoto({
    required String imageId,
    required String url,
  }) async {
    final bool response = await apiServices.downloadRequest(
      url: unsplashBaseUrl + 'photos/$imageId/download',
      fileName: '$imageId.jpg',
      savePath: "storage/emulated/0/DCIM/Flutter Wallpaper/",
      queryParameters: {
        'client_id': _unsplashApiKey,
      },
    );
    return response;
  }
}
