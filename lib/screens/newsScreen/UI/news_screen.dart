import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api_app_bloc/screens/newsScreen/categories/bloc/category_bloc.dart';
import 'package:news_api_app_bloc/screens/newsScreen/categories/bloc/category_event.dart';
import 'package:news_api_app_bloc/screens/newsScreen/categories/bloc/category_state.dart';
import 'package:news_api_app_bloc/helper/utils/url_launcher_helper.dart';
import 'package:shimmer/shimmer.dart';
import '../../../bloc/news_bloc.dart';
import '../../../bloc/news_event.dart';
import '../../../bloc/news_state.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({super.key});

  final List<String> categories = [
    'general',
    'sports',
    'technology',
    'business',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        title: const Text('Todays News'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                final selectedCategory =
                    (state as CategoryInitial).selectedCategory;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 8,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedCategory == category
                              ? Colors.red
                              : Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          context.read<CategoryBloc>().add(
                            SelectCategoryEvent(category),
                          );
                          context.read<NewsBloc>().add(
                            FetchNewsByCategoryEvent(category),
                          );
                        },
                        child: Text(
                          category.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Expanded(
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoadingState) {
                  return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.black87,
                        highlightColor: Colors.redAccent,
                        child: Card(
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            leading: Container(
                              width: 80,
                              color: Colors.white,
                              height: 60,
                            ),
                            title: Container(
                              height: 15,
                              color: Colors.white,
                              margin: const EdgeInsets.symmetric(vertical: 4),
                            ),
                            subtitle: Container(
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is NewsLoadedState) {
                  final articles = state.articles;

                  return RefreshIndicator(
                    onRefresh: () async {
                      final selectedCategory =
                          (context.read<CategoryBloc>().state
                                  as CategoryInitial)
                              .selectedCategory;
                      context.read<NewsBloc>().add(
                        FetchNewsByCategoryEvent(selectedCategory),
                      );
                    },
                    child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return Card(
                          margin: const EdgeInsets.all(8),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                article.image,
                                width: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, _, __) =>
                                    const Icon(Icons.image_not_supported),
                              ),
                            ),
                            title: Text(
                              article.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              article.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              URLLauncherHelper.launchURL(context, article.url);
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is NewsErrorState) {
                  return Center(
                    child: Text(
                      'Error: ${state.errorMsg}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text('Press button to load news'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
