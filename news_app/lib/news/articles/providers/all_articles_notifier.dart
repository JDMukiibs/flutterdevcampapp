import 'dart:async';
import 'dart:math' show Random;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/news/news.dart';
import 'package:news_app/news_api/news_api.dart';
import 'package:news_app/storage/storage.dart';

// class ArticlesNotifier extends StateNotifier<List<Article>> {
//   final _userArticleStorage = UserArticleStorage();
//
//   ArticlesNotifier({required List<Article> fetchedArticles}) : super(fetchedArticles);
//
//   void addToSavedArticles(Article article, bool isSaved) {
//     // TODO (Joshua): utilize function from UserArticleStorage
//   }
//
//   List<Article> fetchAllArticles() {
//     return [];
//   }
// }

class AllArticlesController extends AsyncNotifier<List<Article>> {
  late final UserArticleStorage userArticleStorage;

  @override
  FutureOr<List<Article>> build() {
    userArticleStorage = ref.watch(userArticleStorageProvider);
    // Get the category selected by the user
    final currentCategory = ref.watch(currentCategoryProvider);

    final newsRepo = ref.watch(newsRepositoryProvider);

    final randomInt = Random().nextInt(ArticleCategory.values.length);

    return newsRepo.getAllArticles(category: currentCategory?.name ?? ArticleCategory.values[randomInt].name);
  }

  Future<void> saveArticle(Article article, String userId) async {

  }
}
