import 'package:book_app/features/books/presentation/pages/bottom_nav_bar.dart';
import 'package:book_app/features/books/presentation/pages/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:book_app/features/books/presentation/bloc/books_bloc/books_bloc.dart';
import 'package:book_app/features/books/presentation/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:book_app/features/books/presentation/pages/book_list_page.dart';
import 'package:book_app/features/books/presentation/pages/book_detail_page.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<BooksBloc>()),
        BlocProvider(create: (_) => di.sl<FavoritesBloc>()),
      ],
      child: MaterialApp(
        title: 'Book App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const BottomNavBar(),
        routes: {
          '/book_detail': (context) => const BookDetailPage(),
          '/favorites': (context) => const FavoritesPage(),
        },
      ),
    );
  }
}
