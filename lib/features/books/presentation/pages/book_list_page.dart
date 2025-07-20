import 'package:book_app/features/books/presentation/bloc/books_bloc/books_bloc.dart';
import 'package:book_app/features/books/presentation/bloc/books_bloc/books_event.dart';
import 'package:book_app/features/books/presentation/bloc/books_bloc/books_state.dart';
import 'package:book_app/features/books/presentation/widgets/loading_build_shimmer.dart';
import 'package:book_app/features/books/presentation/widgets/loading_more_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../injection_container.dart';

import '../widgets/book_card.dart';
import '../../domain/entities/book_entity.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final int _limit = 10;
  String _query = "nature";
  int _page = 1;

  @override
  void initState() {
    super.initState();

    context
        .read<BooksBloc>()
        .add(SearchBooks(query: _query, page: _page, limit: _limit));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page++;
        context
            .read<BooksBloc>()
            .add(LoadMoreBooks(query: _query, nextPage: _page, limit: _limit));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    _query = _searchController.text.trim();
    _page = 1;
    context
        .read<BooksBloc>()
        .add(SearchBooks(query: _query, page: _page, limit: _limit));
  }

  void _onBookTap(BookEntity book) {
    Navigator.pushNamed(context, '/book_detail', arguments: book);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Books For You",
          style: GoogleFonts.nunito(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      fillColor: Colors.indigo,
                      hintText: 'Search books...',
                      hintStyle: GoogleFonts.poppins(),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.indigo)),
                    onPressed: _onSearch,
                    child: Text(
                      "Search",
                      style: GoogleFonts.nunito(color: Colors.white),
                    ))
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<BooksBloc, BooksState>(
              builder: (context, state) {
                if (state is BooksLoading && _page == 1) {
                  return buildShimmerLoading();
                } else if (state is BooksLoaded) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.books.length + 1,
                    itemBuilder: (context, index) {
                      if (index < state.books.length) {
                        return BookCard(
                          book: state.books[index],
                          onTap: () => _onBookTap(state.books[index]),
                        );
                      } else if (state.hasMore) {
                        return buildLoadingMoreIndicator();
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  );
                } else if (state is BooksError) {
                  return Center(child: Text(state.message));
                }

                return const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
}
