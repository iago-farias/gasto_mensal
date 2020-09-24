import 'package:flutter/material.dart';
import 'package:gasto_mensal/model/GastoMensal.dart';
import '../controller/GastoController.dart';
import '../components/GastoItem.dart';
import './cadastroGastoMensal.dart';

class ListaGastoMensal extends StatefulWidget {
  @override
  _ListaGastoMensalState createState() => _ListaGastoMensalState();
}

class _ListaGastoMensalState extends State<ListaGastoMensal> {
  GastoController _gastoController = GastoController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _displaySnackBar(BuildContext context, String mensagem) {
    final snackBar = SnackBar(
      content: Text(mensagem),
      backgroundColor: Colors.green[900],
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _excluir(BuildContext context, int id) {

    setState(() {
          _gastoController.excluir(id).then((res) {
          setState(() {
            _displaySnackBar(context, res);
          });
        });
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("\$ Gasto mensal \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Cadastro(null)),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<List<GastoMensal>>(
          initialData: List(),
          future: _gastoController.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text("Carregando..."),
                    ],
                  ),
                );
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<GastoMensal> gastos = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final GastoMensal gastoMensal = gastos[index];
                    return GastoItem(gastoMensal,_excluir);
                  },
                  itemCount: gastos.length,
                );
                break;
            }

            return Text("Erro");
          }),
    );
  }
}
