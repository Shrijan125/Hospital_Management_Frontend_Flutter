import 'dart:convert';

class MedicineCategory {
  final String categoryName;
  final String categoryID;

  MedicineCategory({required this.categoryName, required this.categoryID});

  Map<String, dynamic> toMap() {
    return {
      'categoryName': categoryName,
      'categoryID': categoryID,
    };
  }

  factory MedicineCategory.fromMap(Map<String, dynamic> map) {
    return MedicineCategory(
      categoryName: map['categoryName'] ?? '',
      categoryID: map['categoryID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicineCategory.fromJson(String source) =>
      MedicineCategory.fromMap(json.decode(source));
}
