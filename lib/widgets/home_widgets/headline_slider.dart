import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:newsapp/bloc/get_top_headlines_bloc.dart';
// import 'package:newsapp/elements/error_element.dart';
// import 'package:newsapp/elements/loader.dart';
// import 'package:newsapp/model/article.dart';
// import 'package:newsapp/model/article_response.dart';
// import 'package:newsapp/screens/news_detail.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../bloc/get_top_headlines_bloc.dart';
import '../../elements/error_element.dart';
import '../../elements/loader.dart';
import '../../model/article_response.dart';
import '../../screens/news_detail.dart';
import '../../model/articles.dart' as articlemodel;

class HeadlingSliderWidget extends StatefulWidget {
  @override
  _HeadlingSliderWidgetState createState() => _HeadlingSliderWidgetState();
}

class _HeadlingSliderWidgetState extends State<HeadlingSliderWidget> {
  @override
  void initState() {
    super.initState();
    getTopHeadlinesBloc..getHeadlines();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponse>(
      stream: getTopHeadlinesBloc.subject.stream,
      builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.error != null &&
              snapshot.data!.error.length > 0) {
            return buildErrorWidget(snapshot.data!.error);
          }
          return _buildHeadlineSliderWidget(snapshot.requireData);
        } else if (snapshot.hasError) {
          return buildErrorWidget((snapshot.error).toString());
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }
  Widget _buildHeadlineSliderWidget(ArticleResponse data) {
    List<articlemodel.ArticleModels> articles = data.articles;
    return Container(
        child: CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: false,
              height: 200.0,
              viewportFraction: 0.9,
            ),
            items: getExpenseSliders(articles)
        )
    );
  }
  getExpenseSliders(List<articlemodel.ArticleModels> articles) {
    return articles
        .map((article) =>
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailNews(
                      article: article, key: Key(Key as String),
                    )));
          },
          child: Container(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
            child: Stack(
              children: <Widget>[
                Container(

                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0)),
                      shape: BoxShape.rectangle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: article.img == null ? AssetImage("assets/img/placeholder.jpg") : NetworkImage(
                              article.img)),
                    )),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(8.0)),
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [
                          0.1,
                          0.9
                        ],
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.white.withOpacity(0.0)
                        ]),
                  ),
                ),
                Positioned(
                    bottom: 30.0,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      width: 250.0,
                      child: Column(
                        children: <Widget>[
                          Text(
                            article.title,

                            style: TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                        ],
                      ),
                    )


                ),
                Positioned(
                    bottom: 10.0,
                    left: 10.0,
                    child: Text(
                      article.source.name,
                      // article.source.name,
                      style: TextStyle(
                          color: Colors.white54,
                          fontSize: 9.0),
                    )),
                Positioned(
                    bottom: 10.0,
                    right: 10.0,
                    child: Text(
                      timeUntil(DateTime.parse(article.date)),
                      style: TextStyle(
                          color: Colors.white54,
                          fontSize: 9.0),
                    )),
              ],
            ),
          ),
        ),
    )
        .toList();
  }
  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}