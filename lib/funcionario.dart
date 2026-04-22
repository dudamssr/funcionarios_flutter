class Funcionario {
  final String nome;
  final String cargo;
  final String avatar;

  Funcionario({
    required this.nome,
    required this.cargo,
    required this.avatar,
  });

  factory Funcionario.fromJson(Map<String, dynamic> json) {
    return Funcionario(
      nome: json['nome'],
      cargo: json['cargo'],
      avatar: json['avatar'],
    );
  }
}