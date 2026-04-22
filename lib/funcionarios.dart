import 'dart:convert';
import 'package:flutter/services.dart';
import 'funcionario.dart';

class FuncionarioService {
  Future<List<Funcionario>> loadFuncionarios() async {
    final data = await rootBundle.loadString('mockup/funcionarios.json');

    final List decoded = json.decode(data);

    return decoded.map((e) => Funcionario.fromJson(e)).toList();
  }
}