import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/book_entity.dart';

class BookCard extends StatelessWidget {
  final BookEntity book;
  final VoidCallback onTap;

  const BookCard({super.key, required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final imageUrl = book.coverId != null
        ? 'https://covers.openlibrary.org/b/id/${book.coverId}-M.jpg'
        : null;

    return Card(
      child: ListTile(
        onTap: onTap,
        leading: imageUrl != null
            ? Image.network(imageUrl, width: 50, fit: BoxFit.cover)
            : const Icon(Icons.book),
        title: Text(book.title, style: GoogleFonts.nunito()),
        subtitle: Text(
          book.authorName?.join(', ') ?? 'Unknown',
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }
}
