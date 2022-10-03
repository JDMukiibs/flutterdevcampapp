import 'package:equatable/equatable.dart';
import 'package:news_app/app_constants/app_constants.dart';
import 'package:news_app/models/models.dart';

class Article extends Equatable with Comparable<Article> {
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: json['source'] != null ? Source.fromJson(json['source']) : null,
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'] ?? AppStrings.missingDate,
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (source != null) {
      data.addAll({'source': source!.toJson()});
    }
    data.addAll({'author': author});
    data.addAll({'title': title});
    data.addAll({'description': description});
    data.addAll({'url': url});
    data.addAll({'urlToImage': urlToImage});
    data.addAll({'publishedAt': publishedAt});
    data.addAll({'content': content});

    return data;
  }

  @override
  List<Object?> get props => [
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];

  @override
  int compareTo(other) {
    return other.publishedAt!.compareTo(publishedAt!);
  }
}
