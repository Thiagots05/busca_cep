import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Buscador de CEP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    var cepController = TextEditingController();
    List listaConsultas = [];
    var rua = '';
    var cidade = '';
    var uf = '';

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
     
        title: Text(widget.title),
      ),
      body: Center(
      
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
          
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding:  EdgeInsets.all(20.0),
                child:  Text(
                  'Buscar CEP',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                maxLength: 8,
                controller: cepController,
                keyboardType: TextInputType.number,
                
              ),

              const SizedBox(height: 20),
              Wrap(
                children: [
                  Text(
                    '$rua \n $cidade - $uf',
                    style: Theme.of(context).textTheme.headlineMedium,
                    
                  ),
                ],
              ),
              const Padding(
                              padding: EdgeInsets.fromLTRB(8,20,0,10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Últimas buscas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),)),
                            ),
               Expanded(
                 child: ListView(
                      
                      children :
                          
                          [
                            
                            
                            ...listaConsultas.map((e) {
                            return Card(
                              
                              elevation: 2,
                              child: ListTile(
                              title:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(e['rua'], style:  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blueAccent),),
               
                                ],
                              ),
                              subtitle: Text('${e['cidade']} - ${e['uf']}', style: const TextStyle(color: Colors.grey),),
                              onTap: () {
                                Navigator.pop(context);
                              },
                                                    ),
                            );
                          }).toList(),]
                          ),
               ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          var result = await  http.get(Uri.parse("https://viacep.com.br/ws/${cepController.text}/json/"));
          var resultMap = jsonDecode(result.body);
          setState(() {
          rua = resultMap['logradouro'].toString();
          cidade = resultMap['localidade'].toString();
          uf = resultMap['uf'].toString();
          
          
          Map dadosCep = {
            'cep':cepController.text,
            'rua':rua,
            'cidade': cidade,
            'uf':uf,
          };
          listaConsultas.add(dadosCep);
          });
          print(listaConsultas);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.search),
      ), 
    );
  }
}
