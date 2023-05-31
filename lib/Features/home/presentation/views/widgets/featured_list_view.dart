import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:bookly/Features/home/presentation/managers/featured_book_cubit/fetch_feautred_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_book_item.dart';

class FeaturedBooksListView extends StatefulWidget {
  const FeaturedBooksListView({Key? key, required this.books})
      : super(key: key);
  final List<BookEntity> books;

  @override
  State<FeaturedBooksListView> createState() => _FeaturedBooksListViewState();
}

class _FeaturedBooksListViewState extends State<FeaturedBooksListView> {
  late final ScrollController _scrollController;
  var nextPage = 1;
  var isLoading = false;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() async {
    var currentPossitions = _scrollController.position.pixels;
    var maxScroolLength = _scrollController.position.maxScrollExtent;
    if (currentPossitions >= 0.7 * maxScroolLength) {
      if (!isLoading) {
        isLoading = true;
        await BlocProvider.of<FetchFeautredBookCubit>(context)
            .fetchFeaturedBook(pageNumber: nextPage++);
        isLoading = false;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: widget.books.length,
          itemBuilder: (context, index) {
            var book = widget.books[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: CustomBookImage(
                image: widget.books[index].image ?? '',
              ),
            );
          }),
    );
  }
}
