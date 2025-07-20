import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/book_entity.dart';
import '../bloc/favorites_bloc/favorites_bloc.dart';
import '../bloc/favorites_bloc/favorites_event.dart';
import '../bloc/favorites_bloc/favorites_state.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final book = ModalRoute.of(context)!.settings.arguments as BookEntity;
    final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);

    favoritesBloc.add(CheckFavorite(book.key));

    final imageUrl = book.coverId != null
        ? 'https://covers.openlibrary.org/b/id/${book.coverId}-L.jpg'
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title, style: GoogleFonts.nunito()),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          bool isFavorite;
          if (state is FavoriteStatus) {
            isFavorite = state.isFavorite;
          } else if (state is FavoritesLoaded) {
            isFavorite = state.favorites.any((fav) => fav.key == book.key);
          } else {
            isFavorite = false;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imageUrl != null)
                  Center(child: Image.network(imageUrl, height: 200)),
                const SizedBox(height: 16),
                Text(book.title,
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold, fontSize: 24)),
                const SizedBox(height: 8),
                Text(
                  "Author(s): ${book.authorName?.join(', ') ?? 'Unknown'}",
                  style: GoogleFonts.poppins(),
                ),
                if (book.firstPublishYear != null)
                  Text("First Published: ${book.firstPublishYear}",
                      style: GoogleFonts.poppins()),
                if (book.editionCount != null)
                  Text("Edition Count: ${book.editionCount}",
                      style: GoogleFonts.poppins()),
                if (book.languages != null)
                  Text("Languages: ${book.languages!.join(', ')}",
                      style: GoogleFonts.poppins()),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (isFavorite) {
                        favoritesBloc.add(RemoveFavorite(book.key));
                      } else {
                        favoritesBloc.add(AddFavorite(book));
                      }
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                    ),
                    label: Text(
                        isFavorite
                            ? 'Remove from Favorites'
                            : 'Add to Favorites',
                        style: GoogleFonts.nunito(color: Colors.white)),
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.indigo)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
