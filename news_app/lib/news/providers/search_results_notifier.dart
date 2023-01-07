import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/news/news.dart';

// TODO (Joshua): Create Notifier to use for search results
final searchResultsProvider = FutureProvider.autoDispose<List<Article>>((ref) async {
  return [];
});