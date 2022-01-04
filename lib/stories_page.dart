import 'package:flutter/material.dart';
import 'package:json_provider/news_data.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import 'news_card.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NewsData>().getData;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                context.read<NewsData>().initialValues();
                context.read<NewsData>().getData;
              },
              icon: const Icon(Icons.refresh),),
        ],
        title: const Text("Top Stories"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<NewsData>().getData;
        },
        child: Center(
          child: Consumer<NewsData>(
            builder: (context, value, child) {
              return value.newsMap.isEmpty && !value.newsError
                  ? const CircularProgressIndicator()
                  : value.newsError
                      ? Text(
                          'Ops, fatal error: ${value.newsErrorMessage}',
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          itemCount: value.newsMap['articles'].length,
                          itemBuilder: (context, index) {
                            return NewsCard(
                              map: value.newsMap['articles'][index],
                            );
                          },
                        );
            },
          ),
        ),
      ),
    );
  }
}

