import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/news/news.dart';
import 'package:news_app/user/articles/providers/user_saved_articles_provider.dart';
import 'package:news_app/user/articles/widgets/saved_article_card.dart';

class SavedArticlesSection extends ConsumerWidget {
  const SavedArticlesSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(userSavedArticlesProvider);

    return Column(
      children: [
        articles.when(
          data: (data) => data.isEmpty
              ? Center(
                  child: Text(
                    '❌ No articles found ❌',
                    style: Theme.of(context).primaryTextTheme.headline1,
                  ),
                )
              : ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final article = data.elementAt(index);

                    return SavedArticleCard(article: article);
                  },
                ),
          error: (error, __) => Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Center(
                  child: ErrorCard(),
                ),
              ],
            ),
          ),
          loading: () => Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
