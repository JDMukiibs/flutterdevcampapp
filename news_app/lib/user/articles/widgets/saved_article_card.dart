import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_app/app_constants/app_constants.dart';
import 'package:news_app/storage/storage.dart';
import 'package:url_launcher/url_launcher.dart';

class SavedArticleCard extends ConsumerWidget {
  final SavedArticle article;

  const SavedArticleCard({
    Key? key,
    required this.article,
  }) : super(key: key);

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('To Be Implemented'),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                height: 120,
                width: 60,
                fit: BoxFit.cover,
                imageUrl: article.urlToImage,
              ),
            ),
            title: Text(
              article.title,
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
            subtitle: RichText(
              text: TextSpan(
                style: Theme.of(context).primaryTextTheme.subtitle2,
                children: [
                  TextSpan(
                    text: article.author,
                  ),
                  const WidgetSpan(child: SizedBox(width: 10)),
                  TextSpan(
                    text: article.publishedAt == OldAppStrings.missingDate
                        ? article.publishedAt
                        : DateFormat.yMEd().add_jm().format(DateTime.parse(article.publishedAt)),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () async {
                  final url = Uri.parse(article.url);
                  if (!await launchUrl(url)) {
                    throw 'Could not launch $url';
                  }
                },
                child: const Text('READ'),
              ),
              TextButton(
                onPressed: () {
                  _showSnackBar(context);
                },
                child: const Text('DELETE'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
