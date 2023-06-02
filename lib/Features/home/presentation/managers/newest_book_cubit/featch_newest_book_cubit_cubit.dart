import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entites/book_entity.dart';
import '../../../domain/use_cases/fetch_newest_books_use_case.dart';

part 'featch_newest_book_cubit_state.dart';

class FeatchNewestBookCubitCubit extends Cubit<FeatchNewestBookCubitState> {
  FeatchNewestBookCubitCubit(this.featuredBooksUseCase) : super(FeatchNewestBookCubitInitial());
   final FetchNewestBooksUseCase featuredBooksUseCase;
  Future<void> fetchNewestBook({int pageNumber=0}) async {
    if (pageNumber==0){
      emit(FetchNewestBookLoading());
    }else{
      emit(FetchNewestBookLoading());
    }
    emit(FetchNewestBookLoading());
    var result = await featuredBooksUseCase.call();
    result.fold((failure) {
      emit(FetchNewestBookFailure(failure.message));
    }, (r) {
      emit(FetchNewestBookSuccess(r));
    });
  }
}
