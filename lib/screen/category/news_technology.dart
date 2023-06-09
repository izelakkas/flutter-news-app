import 'package:flutter/material.dart';
import 'package:izelakkas/components/customListTile.dart';
import 'package:izelakkas/model/article_model.dart';
import 'package:izelakkas/services/news_api_technology.dart';

class Technology extends StatefulWidget {
  @override
  _TechnologyState createState() => _TechnologyState();
}

class _TechnologyState extends State<Technology> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Technology", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: client.getArticle(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            List<Article>? articles = snapshot.data;
            return ListView.builder(
              itemCount: articles?.length,
              itemBuilder: (context, index) =>
                  customListTile(articles![index], context),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("An error occurred"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
