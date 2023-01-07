import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/news/models/article_category.dart';

final currentCategoryProvider = StateProvider<ArticleCategory?>(
  (ref) => null,
);
