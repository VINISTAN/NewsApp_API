import 'package:news_today/model/articles.dart';

class ArticleResponse {
  final List<ArticleModels> articles;
  final String error;

  ArticleResponse(this.articles,this.error);

  ArticleResponse.fromJson(Map<String,dynamic>json) :
      articles = (json["articles"] as List).map((i) => new ArticleModels.fromJson(i)).toList(),
      error = "";

  ArticleResponse.withError(String errorValue) :
      articles = [],
      error = errorValue;
}