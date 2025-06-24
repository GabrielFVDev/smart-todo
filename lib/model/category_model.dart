class CategoryModel {
  final int id;
  final String name;
  final bool isDefault;

  const CategoryModel({
    required this.id,
    required this.name,
    this.isDefault = false,
  });
}
