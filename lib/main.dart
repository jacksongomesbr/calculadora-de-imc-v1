import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controllerAltura = TextEditingController();
  final TextEditingController _controllerPeso = TextEditingController();
  String altura = '';
  String peso = '';

  double _calcularIMC(int altura, double peso) {
    double alturaCorrigida = altura / 100.0;
    return peso / (alturaCorrigida * alturaCorrigida);
  }

  _buildResultado(BuildContext context) {
    if (altura != '' && peso != '') {
      double imc = _calcularIMC(int.parse(altura), double.parse(peso));
      String classificacao = '';
      if (imc < 18.5) {
        classificacao = 'Magreza';
      } else if (imc >= 18.5 && imc < 24.9) {
        classificacao = 'Normal';
      } else if (imc >= 25 && imc < 29.9) {
        classificacao = 'Sobrepeso';
      } else if (imc >= 30 && imc < 34.9) {
        classificacao = 'Obesidade Grau I';
      } else if (imc >= 35 && imc < 39.9) {
        classificacao = 'Obesidade Grau II';
      } else if (imc >= 40) {
        classificacao = 'Obesidade Grau III';
      }
      return Column(
        children: [
          Text('Seu IMC é', style: Theme.of(context).textTheme.displaySmall),
          Text(
            imc.toStringAsFixed(1),
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(classificacao, style: Theme.of(context).textTheme.headline4)
        ],
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Para calcular o seu IMC é necessário que '
            'você forneça seu peso e altura',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Calculadora de IMC'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child:
                      Text('Forneça sua altura e seu peso para calcular o IMC'),
                ),
              ),
              TextField(
                controller: _controllerAltura,
                decoration: const InputDecoration(
                  icon: Icon(Icons.swap_vertical_circle),
                  hintText: 'Altura',
                  helperText: 'Sua altura em centímetros',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: _controllerPeso,
                decoration: const InputDecoration(
                  icon: Icon(Icons.balance),
                  hintText: 'Peso',
                  helperText: 'Seu peso em kg',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    altura = _controllerAltura.text;
                    peso = _controllerPeso.text;
                  });
                },
                child: const Text('CALCULAR'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              _buildResultado(context),
            ],
          ),
        ),
      ),
    );
  }
}
