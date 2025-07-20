import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/book_entity.dart';
import '../bloc/favorites_bloc/favorites_bloc.dart';
import '../bloc/favorites_bloc/favorites_event.dart';
import '../bloc/favorites_bloc/favorites_state.dart';
import '../widgets/book_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  void _openBookDetail(BuildContext context, BookEntity book) {
    Navigator.pushNamed(context, '/book_detail', arguments: book).then((_) {
      context.read<FavoritesBloc>().add(LoadFavorites());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<FavoritesBloc>(context)..add(LoadFavorites()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Favorite Books",
            style: GoogleFonts.nunito(color: Colors.white),
          ),
          backgroundColor: Colors.indigo,
          centerTitle: true,
        ),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoritesLoaded) {
              final favorites = state.favorites;

              if (favorites.isEmpty) {
                return const Center(child: Text("No favorite books found."));
              }

              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final book = favorites[index];
                  return BookCard(
                    book: book,
                    onTap: () => _openBookDetail(context, book),
                  );
                },
              );
            } else if (state is FavoritesError) {
              return Center(child: Text("Error: ${state.message}"));
            } else if (state is FavoriteStatus) {
              context.read<FavoritesBloc>().add(LoadFavorites());
              return const Center(child: CircularProgressIndicator());
            }

            return const Center(child: Text("Something went wrong."));
          },
        ),
      ),
    );
  }
}
