
class ConstructorRegistro {
  final String email;
  final String nombre;
  final String telefono;
  final String cp;
  final String edad;
  

  const ConstructorRegistro({required this.email, required this.nombre, required this.telefono, required this.cp, required this.edad});

  factory ConstructorRegistro.fromJson(Map<String, dynamic> json){
    return ConstructorRegistro(
      email: json['email'] as String,
      nombre: json['nombre'] as String,
      telefono: json['telefono'] as String, 
      cp: json['cp'] as String, 
      edad: json['edad'] as String);
  }
}