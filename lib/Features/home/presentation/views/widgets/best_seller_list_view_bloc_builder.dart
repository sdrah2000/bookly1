import 'package:bookly/Features/home/presentation/views/widgets/best_seller_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entites/book_entity.dart';
import '../../managers/featured_book_cubit/fetch_feautred_book_cubit.dart';
import '../../managers/newest_book_cubit/featch_newest_book_cubit_cubit.dart';
import 'featured_list_view.dart';

class BestSellerListViewBlocBuilder extends StatefulWidget {
  const BestSellerListViewBlocBuilder({super.key});

  @override
  State<BestSellerListViewBlocBuilder> createState() =>
      _BestSellerListViewBlocBuilderState();
}

class _BestSellerListViewBlocBuilderState
    extends State<BestSellerListViewBlocBuilder> {
  List<BookEntity> books = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeatchNewestBookCubitCubit, FeatchNewestBookCubitState>(
      listener: (context, state) {
        if (state is FetchNewestBookSuccess) {
          books.addAll(state.books);
        }
      },
      builder: (context, state) {
        if (state is FetchNewestBookSuccess ||
            state is FetchNewestBookLoading) {
          return BestSellerListView(
            books: books,
          );
        } else if (state is FetchNewestBookFailure) {
          return Text(state.errorMessage);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
