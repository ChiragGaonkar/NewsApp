class PassMultipleArgsToDetail {
  final String category;
  final int id;
  PassMultipleArgsToDetail({
    required this.id,
    required this.category,
  });
}

class PassMultipleArgsToCategory {
  final String category;
  final String query;
  PassMultipleArgsToCategory({
    required this.category,
    required this.query,
  });
}

class PassMultipleArgsToBookmark {
  final String index;
  PassMultipleArgsToBookmark({
    required this.index,
  });
}
