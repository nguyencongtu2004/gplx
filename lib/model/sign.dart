enum SignCategory {
  prohibitory, // biển báo cấm
  warning, // biển báo nguy hiểm
  mandatory, // biển báo hiệu lệnh
  indication, // biển báo chỉ dẫn
  indicationOnHighway, // biển báo chỉ dẫn trên cao tốc
  additional, // biển báo phụ
  roadMarking, // vạch kẻ đường
  other, // các loại biển báo khác
}

class Sign {
  Sign({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
  });

  final String id;
  final String name;
  final String description;
  final SignCategory category;

  factory Sign.fromMap(Map<String, dynamic> map) {
    final SignCategory category;
    switch (map['category']) {
      case 1:
        category = SignCategory.prohibitory;
        break;
      case 2:
        category = SignCategory.warning;
        break;
      case 3:
        category = SignCategory.mandatory;
        break;
      case 4:
        category = SignCategory.indication;
        break;
      case 5:
        category = SignCategory.indicationOnHighway;
        break;
      case 6:
        category = SignCategory.additional;
        break;
      case 7:
        category = SignCategory.roadMarking;
        break;
      default:
        category = SignCategory.other;
    }

    return Sign(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      category: category,
    );
  }

  Sign copyWith({
    String? id,
    String? name,
    String? description,
    SignCategory? category,
  }) {
    return Sign(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }
}