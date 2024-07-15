class ArticleModels {
  final String author;
  final String title;
  final String description;
  final String url;
  final String img;
  final String date;
  final String content;

  ArticleModels(this.author, this.title, this.description, this.url, this.img,
      this.date, this.content);

  ArticleModels.fromJson(Map<String, dynamic> json)
      : author = json["author"],
        title = json["title"],
        description = json["description"],
        url = json["url"],
        img = json["img"],
        date = json["date"],
        content = json["content"];

  get source => null;
}
