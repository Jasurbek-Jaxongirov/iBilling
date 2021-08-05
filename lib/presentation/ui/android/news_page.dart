import 'package:flutter/material.dart';
import '/presentation/ui/theme/app_constants.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final List<String> _listItems = ['Физическое', 'Юридическое'];
  String valueChosen = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      // color: Colors.black,
      child: Column(
        children: [],
      ),
    );
  }
}
