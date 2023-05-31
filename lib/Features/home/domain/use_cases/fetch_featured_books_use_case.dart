import 'package:bookly/Features/home/domain/repos/home_rep.dart';
import 'package:bookly/Features/home/domain/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entites/book_entity.dart';

class FetchFeaturedBooksUseCase extends UseCase<List<BookEntity>, int> {
  final HomeRepo homeRepo;

  FetchFeaturedBooksUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<BookEntity>>> call([int param=0]) async {
    // TODO: implement call
    return await homeRepo.fetchFeaturedBooks(
      pageNumber: param,
    );
  }
}
