import 'package:uuid/uuid.dart';

class CategoriesList {
  final String id;
  List<String>? categories;
  bool selected;

  CategoriesList({
    this.categories,
    this.selected = false,
  }) : id = const Uuid().v4();
  factory CategoriesList.fromJson(List<String> json) {
    List<String> categoriesList = List.from(json);
    return CategoriesList(categories: categoriesList);
  }

  CategoriesList copyWith({
    List<String>? categories,
    bool? selected,
  }) {
    return CategoriesList(
      categories: categories ?? this.categories,
      selected: selected ?? this.selected,
    );
  }
}

class Cats {
  List<Cat>? categories;
  Cats({
    this.categories,
  });
  factory Cats.fromJson(List<String> json) {
    List<Cat> c = json.map((e) => Cat.fromJson(e)).toList();
    return Cats(categories: c);
  }
  Cats copyWith({
    List<Cat>? categories,
  }) {
    return Cats(
      categories: categories ?? this.categories,
    );
  }
}

class Cat {
  final String id;
  final String? category;
  bool selected;
  Cat({
    this.category,
    this.selected = false,
  }) : id = const Uuid().v4();
  factory Cat.fromJson(String data) {
    return Cat(category: data);
  }
  Cat copyWith({
    String? id,
    String? category,
    bool? selected,
  }) {
    return Cat(
      category: category ?? this.category,
      selected: selected ?? this.selected,
    );
  }
}
