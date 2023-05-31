import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../managers/featured_book_cubit/fetch_feautred_book_cubit.dart';
import 'featured_list_view.dart';

class FeaturedBookListViewBlocBuilder extends StatelessWidget {
  const FeaturedBookListViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchFeautredBookCubit, FetchFeautredBookState>(
      builder: (context, state) {
        if (state is FetchFeautredBookSuccess || state is FetchFeautredPagBookLoading) {
          return  FeaturedBooksListView(
            books: state is FetchFeautredBookSuccess ? state.books :[],
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
