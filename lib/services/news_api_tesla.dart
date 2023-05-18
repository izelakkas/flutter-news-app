import 'dart:convert';
import 'package:izelakkas/model/article_model.dart';
import 'package:http/http.dart';

class ApiService {
  final endPointUrl = Uri.parse(
      "https://newsapi.org/v2/everything?q=tesla&from=2023-04-18&sortBy=publishedAt&apiKey=90cf76a29a9447898b12aacf778e1001");

  Future<List<Article>> getArticle() async {
    Response res = await get(endPointUrl as Uri);

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
