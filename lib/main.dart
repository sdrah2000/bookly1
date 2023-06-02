import 'package:bookly/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:bookly/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:bookly/Features/home/domain/use_cases/fetch_featured_books_use_case.dart';
import 'package:bookly/Features/home/presentation/managers/featured_book_cubit/fetch_feautred_book_cubit.dart';
import 'package:bookly/constants.dart';
import 'package:bookly/core/utils/api_service.dart';
import 'package:bookly/core/utils/app_router.dart';
import 'package:bookly/core/utils/simple_bloc_observer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'Features/Splash/presentation/views/splash_view.dart';
import 'Features/home/data/repos/home_repo_impl.dart';
import 'Features/home/domain/entites/book_entity.dart';
import 'Features/home/domain/use_cases/fetch_newest_books_use_case.dart';
import 'Features/home/presentation/managers/newest_book_cubit/featch_newest_book_cubit_cubit.dart';
import 'core/utils/functions/setup.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BookEntityAdapter());
  setup();
  await Hive.openBox<BookEntity>(KFeautredBox);
  await Hive.openBox<BookEntity>(KNewestBox);
  Bloc.observer = SimpleBlocObserver();
  runApp(const Bookly());
}

final getIt = GetIt.instance;

class Bookly extends StatelessWidget {
  const Bookly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return FetchFeautredBookCubit(
                FetchFeaturedBooksUseCase(
                  getIt.get<HomeRepoImple>(),
                ),
              )..fetchFeaturedBook();
            },
          ),
          BlocProvider(
            create: (context) {
              return FeatchNewestBookCubitCubit(
                FetchNewestBooksUseCase(
                  getIt.get<HomeRepoImple>(),
                ),
              )..fetchNewestBook();
            },
          ),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: kPrimaryColor,
            textTheme:
                GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
          ),
        ));
  }
}
