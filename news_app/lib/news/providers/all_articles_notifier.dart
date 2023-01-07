import 'dart:async';
import 'dart:math' show Random;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/news/news.dart';
import 'package:news_app/news_api/news_api.dart';
import 'package:news_app/storage/storage.dart';

final allArticlesControllerProvider = AsyncNotifierProvider.autoDispose<AllArticlesController, List<Article>>(
  AllArticlesController.new,
);

class AllArticlesController extends AutoDisposeAsyncNotifier<List<Article>> {
  @override
  FutureOr<List<Article>> build() {
    // Get the category selected by the user
    final currentCategory = ref.watch(currentCategoryProvider);

    final newsRepo = ref.watch(newsRepositoryProvider);

    final randomInt = Random().nextInt(ArticleCategory.values.length);

    return newsRepo.getAllArticles(
      category: currentCategory?.name ?? ArticleCategory.values[randomInt].name,
    );
  }

  Future<void> saveArticle(Article article, String userId) async {
    // read the user article storage provider
    final userArticleStorage = ref.read(userArticleStorageProvider);
    // update the state in this case the article that is to be saved
    // should have the isSaved bool turned to true
    update((state) async {
      final result = await userArticleStorage.saveArticle(
        userId: userId,
        article: article,
      );

      if (result) {
        state.removeWhere((element) => element == article);
      }

      return state;
    });
  }
}
