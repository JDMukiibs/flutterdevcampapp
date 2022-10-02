import 'dart:developer' as devtools;

import 'package:news_app/models/models.dart';
import 'package:news_app/repositories/repositories.dart';
import 'package:news_app/services/services.dart';

class NewsRepository implements BaseRepository {
  final DioHttpService _dioHttpServiceClient;

  NewsRepository({
    DioHttpService? dioHttpServiceOverride,
  }) : _dioHttpServiceClient = dioHttpServiceOverride ?? DioHttpService();

  // TODO (Joshua): Add Storage Service client
  static const String allArticlesEndpoint = '/everything';
  static const String headlinesEndpoint = '/top-headlines';

  @override
  Future<List<Article>> getAllArticles({String? category}) async {
    final NewsApiResponse? newsApiResponse;
    final queryParameters = <String, dynamic>{};
    // Get all articles in English from yesterday that include a randomized keyword from our category list
    queryParameters.addAll({'q': '"$category"'});
    queryParameters.addAll({'from': DateTime.now().subtract(const Duration(days: 1)).toIso8601String()});
    queryParameters.addAll({'language': 'fr'});

    try {
      final responseJson = await _dioHttpServiceClient.get(
        allArticlesEndpoint,
        queryParameters: queryParameters,
      );

      newsApiResponse = NewsApiResponse.fromJson(responseJson);
    } catch (e) {
      devtools.log('Exception: $e');

      rethrow;
    }

    return newsApiResponse.articles ?? [];
  }

  @override
  Future<List<Article>> getArticlesMatchingKeyword(String keyword) async {
    final NewsApiResponse? newsApiResponse;
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll({'q': '"$keyword"'});
    devtools.log(queryParameters.toString());

    try {
      final responseJson = await _dioHttpServiceClient.get(allArticlesEndpoint, queryParameters: queryParameters);

      newsApiResponse = NewsApiResponse.fromJson(responseJson);
    } catch (e) {
      devtools.log('Exception: $e');

      rethrow;
    }

    return newsApiResponse.articles ?? [];
  }

  @override
  Future<List<Article>> getHeadlines() async {
    final NewsApiResponse? newsApiResponse;
    final queryParameters = <String, dynamic>{};
    // Get all headlines from the US
    queryParameters.addAll({'country': 'us'});

    try {
      final responseJson = await _dioHttpServiceClient.get(
        headlinesEndpoint,
        queryParameters: queryParameters,
      );

      newsApiResponse = NewsApiResponse.fromJson(responseJson);
    } catch (e) {
      devtools.log('Exception: $e');

      rethrow;
    }

    return newsApiResponse.articles ?? [];
  }

  @override
  Future<List<Article>> getHeadlinesFromCountry(String languageCode) async {
    final NewsApiResponse? newsApiResponse;
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll({'country': languageCode});

    try {
      final responseJson = await _dioHttpServiceClient.get(
        headlinesEndpoint,
        queryParameters: queryParameters,
      );

      newsApiResponse = NewsApiResponse.fromJson(responseJson);
    } catch (e) {
      devtools.log('Exception: $e');

      rethrow;
    }

    return newsApiResponse.articles ?? [];
  }
}
