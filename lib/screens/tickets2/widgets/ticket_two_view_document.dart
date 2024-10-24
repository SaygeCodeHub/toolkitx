import 'package:flutter/material.dart';

Icon viewDocument(String document) {
  if (document.contains('.pdf')) {
    return const Icon(Icons.picture_as_pdf);
  } else if (document.contains('.doc')) {
    return const Icon(Icons.file_copy);
  } else {
    return const Icon(Icons.image);
  }
}
