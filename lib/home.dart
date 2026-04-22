import 'package:flutter/material.dart';
import 'funcionario.dart';
import 'funcionarios.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final service = FuncionarioService();

  List<Funcionario> lista = [];
  int index = 0;

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    final data = await service.loadFuncionarios();
    setState(() => lista = data);
  }

  @override
  Widget build(BuildContext context) {
    if (lista.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final f = lista[index];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Funcionários"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [


            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
              ),
              child: DropdownButton<Funcionario>(
                isExpanded: true,
                underline: const SizedBox(),
                value: f,
                items: lista.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e.nome),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    index = lista.indexOf(value!);
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            Text(
              f.nome,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

        
            Container(
              width: 260,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                  )
                ],
              ),
              child: Column(
                children: [

                
                  ClipOval(
                    child: Image.network(
                      f.avatar,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,

                     
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 90,
                          height: 90,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.person,
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    f.nome,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(f.cargo),
                ],
              ),
            ),

            const Spacer(),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: index > 0
                      ? () => setState(() => index--)
                      : null,
                  child: const Text("Anterior"),
                ),
                ElevatedButton(
                  onPressed: index < lista.length - 1
                      ? () => setState(() => index++)
                      : null,
                  child: const Text("Próximo"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}