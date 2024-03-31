import 'dart:convert';

class Kontak {
  final String nama;
  final String email;
  final String alamat;
  final String telepon;
  final String foto;

  Kontak(
      {required this.nama,
      required this.email,
      required this.alamat,
      required this.telepon,
      required this.foto});

  Kontak copyWith(
      {String? nama,
      String? email,
      String? alamat,
      String? telepon,
      String? foto}) {
    return Kontak(
        nama: nama ?? this.nama,
        email: email ?? this.email,
        alamat: alamat ?? this.alamat,
        telepon: telepon ?? this.telepon,
        foto: foto ?? this.foto);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nama': nama,
      'email': email,
      'alamat': alamat,
      'telepon': telepon,
      'foto': foto
    };
  }

  String toJson() => json.encode(toMap());

  factory Kontak.fromJson(String source) =>
      Kontak.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Kontak(nama: $nama, email: $email, alamat: $alamat, telepon: $telepon, foto: $foto)';
  }

  @override
  bool operator ==(covariant Kontak other) {
    if (identical(this, other)) return true;

    return other.nama == nama &&
        other.email == email &&
        other.alamat == alamat &&
        other.telepon == telepon &&
        other.foto == foto;
  }

  @override
  int get hashCode {
    return nama.hashCode ^
        email.hashCode ^
        alamat.hashCode ^
        telepon.hashCode ^
        foto.hashCode;
  }
}
