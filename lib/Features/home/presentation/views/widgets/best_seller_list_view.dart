import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../managers/newest_book_cubit/featch_newest_book_cubit_cubit.dart';
import 'best_seller_list_view_item.dart';
import 'custom_book_item.dart';

class BestSellerListView extends StatefulWidget {
  const BestSellerListView({super.key, required this.books});

  final List<BookEntity> books;

  @override
  State<BestSellerListView> createState() => _BestSellerListViewState();
}

class _BestSellerListViewState extends State<BestSellerListView> {
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
        await BlocProvider.of<FeatchNewestBookCubitCubit>(context)
            .fetchNewestBook(pageNumber: nextPage++);
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
    return ListView.builder(
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
        });
  }
}
