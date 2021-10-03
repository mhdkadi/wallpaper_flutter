import '../wallpaper_model/wallpaper_api_services.dart';
import '../wallpaper_model/wallpaper_model.dart';

class WallpaperController {
  final String _apiKey = 'WRhWAYcJZOy-xruGBn__fvVjaPEV171Tikrcgmsn3lM';
  final ApiServices apiServices;

  WallpaperController({required this.apiServices});
  Future<Wallpapers> getPhotos({required int page}) async {
    final List<dynamic> response = await apiServices.getHttpClient(
        url: 'photos/',
        queryParameters: {
          'client_id': _apiKey,
          'per_page': '30',
          'page': page
        });
    return Wallpapers.productsFromJson(response);
  }

  Future<Wallpapers> searshPhotos(
      {required int page, required String searshQuery}) async {
    final List<dynamic> response = await apiServices.getHttpClient(
        url: 'search/photos/',
        queryParameters: {
          'client_id': _apiKey,
          'per_page': '30',
          'page': page,
          'query': searshQuery
        });
    return Wallpapers.productsFromJson(response);
  }
}
