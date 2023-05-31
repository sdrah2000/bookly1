import 'package:bloc/bloc.dart';
import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:bookly/Features/home/domain/use_cases/fetch_featured_books_use_case.dart';
import 'package:meta/meta.dart';

part 'fetch_feautred_book_state.dart';

class FetchFeautredBookCubit extends Cubit<FetchFeautredBookState> {
  FetchFeautredBookCubit(this.featuredBooksUseCase)
      : super(FetchFeautredBookInitial());
  final FetchFeaturedBooksUseCase featuredBooksUseCase;
  Future<void> fetchFeaturedBook({int pageNumber =0 }) async {
    if (pageNumber==0){
       emit(FetchFeautredBookLoading());
    }else{
      emit(FetchFeautredPagBookLoading());
    }
   
    var result = await featuredBooksUseCase.call(pageNumber);
    result.fold((failure) {
      emit(FetchFeautredBookFailure(failure.message));
    }, (books) {
      emit(FetchFeautredBookSuccess(books));
    });
  }
}
