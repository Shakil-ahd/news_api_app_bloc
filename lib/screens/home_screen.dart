import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/news_bloc.dart';
import '../bloc/news_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📰 News App')),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoadedState) {
            final articles = state.articles;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.network(
                      article.image,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, _, __) =>
                          const Icon(Icons.image_not_supported),
                    ),
                    title: Text(article.title),
                    subtitle: Text(article.description),
                    onTap: () {},
                  ),
                );
              },
            );
          } else if (state is NewsErrorState) {
            return Center(child: Text('Error: ${state.errorMsg}'));
          } else {
            return const Center(child: Text('Press button to load news'));
          }
        },
      ),
    );
  }
}
