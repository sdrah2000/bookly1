import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entites/book_entity.dart';
import '../../managers/featured_book_cubit/fetch_feautred_book_cubit.dart';
import 'featured_list_view.dart';

class FeaturedBookListViewBlocBuilder extends StatefulWidget {
  const FeaturedBookListViewBlocBuilder({super.key});

  @override
  State<FeaturedBookListViewBlocBuilder> createState() =>
      _FeaturedBookListViewBlocBuilderState();
}

class _FeaturedBookListViewBlocBuilderState
    extends State<FeaturedBookListViewBlocBuilder> {
  List<BookEntity> books = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchFeautredBookCubit, FetchFeautredBookState>(
      listener: (context, state) {
        if (state is FetchFeautredBookSuccess) {
          books.addAll(state.books);
        }
      },
      builder: (context, state) {
        if (state is FetchFeautredBookSuccess ||
            state is FetchFeautredPagBookLoading) {
          return FeaturedBooksListView(
            books: books,
          );
        } else if (state is FetchFeautredBookFailure) {
          return Text(state.errorMessage);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
