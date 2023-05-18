class Source {
  String id;
  String name;

  Source({required this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] ??
          '', // id alanının null olması durumunda boş bir dize kullanılıyor
      name: json['name'] ??
          '', // name alanının null olması durumunda boş bir dize kullanılıyor
    );
  }
}
