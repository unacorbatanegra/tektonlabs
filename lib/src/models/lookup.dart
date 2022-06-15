class Lookup {
  final String id;
  final String name;

  Lookup({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static Lookup fromJson(Map<String, dynamic> json) {
    return Lookup(
      id: json['Id'],
      name: json['Name'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Lookup && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

extension ToLookup<T> on List<T> {
  List<Lookup> toListLookup(Lookup Function(T element) toLookup) {
    final list = <Lookup>[];
    final dirty = map(toLookup).toList();
    dirty.removeWhere((e) => e.name.isEmpty);
    for (final u in dirty) {
      if (!list.contains(u)) list.add(u);
    }
    return list;
  }
}

extension Filter on List<Lookup> {
  bool filter(bool Function(String id) test) {
    if (isEmpty) return true;
    return any(
      (a) => test(a.id),
    );
  }

 
}
