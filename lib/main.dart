import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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


  

  @override
  Widget build(BuildContext context) {
    var cepController = TextEditingController();
    List listaConsultas = [1,2,3,4,5];
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
                
                controller: cepController,
                keyboardType: TextInputType.number,
                
              ),

              const SizedBox(height: 20),
              Text(
                'Rua Direita \n Crato - CE',
                style: Theme.of(context).textTheme.headlineMedium,
                
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
                              title: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Rua Direita', style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blueAccent),),
               
                                ],
                              ),
                              subtitle: const Text('Crato - CE', style: const TextStyle(color: Colors.grey),),
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
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.search),
      ), 
    );
  }
}
