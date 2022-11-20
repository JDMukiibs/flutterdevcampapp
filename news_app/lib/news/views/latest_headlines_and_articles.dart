import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app_constants/app_constants.dart';
import 'package:news_app/news/news.dart';
import 'package:news_app/news_api/news_api.dart';

class LatestHeadlinesAndArticles extends ConsumerWidget {
  const LatestHeadlinesAndArticles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestHeadlines = ref.watch(defaultHeadlinesProvider);
    final latestArticles = ref.watch(allArticlesProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.refresh(defaultHeadlinesProvider.future);
          await ref.refresh(allArticlesProvider.future);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CategoryPicker(),
              const SizedBox(height: 10),
              Text(
                OldAppStrings.headlinesTitle,
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
              const SizedBox(height: 10),
              latestHeadlines.when(
                data: (data) => data.isEmpty
                    ? Text(
                        OldAppStrings.headlinesListIsEmptyText,
                        style: Theme.of(context).primaryTextTheme.headline1,
                      )
                    : HeadlineSection(fetchedHeadlines: data),
                error: (error, __) => Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: Text(
                      error is HttpException
                          ? OldAppStrings.httpExceptionTryAgainTitle
                          : OldAppStrings.headlinesListIsEmptyText,
                      style: Theme.of(context).primaryTextTheme.headline3,
                      textAlign: TextAlign.center,
                    ),
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
              const SizedBox(height: 20),
              Text(
                OldAppStrings.articlesTitle,
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
              const SizedBox(height: 10),
              latestArticles.when(
                data: (data) => data.isEmpty
                    ? Center(
                        child: Text(
                          '❌ No articles found ❌',
                          style: Theme.of(context).primaryTextTheme.headline1,
                        ),
                      )
                    : ArticleListTileListView(articles: data),
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
          ),
        ),
      ),
    );
  }
}
