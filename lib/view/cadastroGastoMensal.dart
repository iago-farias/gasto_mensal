import 'package:flutter/material.dart';
import 'package:gasto_mensal/controller/GastoController.dart';
import 'package:gasto_mensal/view/listaGastoMensal.dart';
import '../components/Dropdown.dart';
import '../components/TextField.dart';
import '../model/GastoMensal.dart';

class Cadastro extends StatefulWidget {
  final GastoMensal gastoMensal;

  Cadastro(this.gastoMensal);

  @override
  _CadastroState createState() => _CadastroState(gastoMensal);
}

class _CadastroState extends State<Cadastro> {
  final GastoMensal gastoMensal;

  _CadastroState(this.gastoMensal);

  TextEditingController _anoController = TextEditingController();
  TextEditingController _mesController = TextEditingController();
  TextEditingController _finalidadeController = TextEditingController();
  TextEditingController _valorController = TextEditingController();  
  TextEditingController _tipoGastoController = TextEditingController();  

  GastoController _gastoController = GastoController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _tipoGasto = ["Fixo", "Variável", "Eventual", "Emergencial"];
  var _tipoGastoSelecionado = 'Fixo';

  var _mes = [
  "Janeiro",
  "Fevereiro",
  "Março",
  "Abril",
  "Maio",
  "Junho",
  "Julho",  
  "Agosto",
  "Setembro",
  "Outubro",
  "Novembro",
  "Dezembro"
  ];

  var _mesSelecionado = "Janeiro";

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => {
          if(gastoMensal != null){
            setState(() {
              _anoController.text = gastoMensal.ano.toString();
              _mesSelecionado = gastoMensal.mes;
              _finalidadeController.text = gastoMensal.finalidade;
              _valorController.text = gastoMensal.valor.toString();
              _tipoGastoSelecionado = gastoMensal.tipoGasto;
            })
          }
        });
  }

  void clearInputs(){
    setState(() {
      _anoController.text = "";
      _mesSelecionado = "Janeiro";
      _finalidadeController.text = "";
      _valorController.text = "";
      _tipoGastoSelecionado = "Fixo";
    });
  }

  _alterarTipoGasto(String novoTipoGastoSelecionado) {
    _dropDownTipoGastoSelected(novoTipoGastoSelecionado);
    setState(() {
      this._tipoGastoSelecionado = novoTipoGastoSelecionado;
      _tipoGastoController.text = this._tipoGastoSelecionado;
    });
  }

  _dropDownTipoGastoSelected(String novoTipoGasto) {
    setState(() {
      this._tipoGastoSelecionado = novoTipoGasto;
    });
  }

  _alterarMes(String novoMesSelecionado) {
    _dropDownMesSelected(novoMesSelecionado);
    setState(() {
      this._mesSelecionado = novoMesSelecionado;
      _mesController.text = this._mesSelecionado;
    });
  }

  _dropDownMesSelected(String novoMes) {
    setState(() {
      this._mesSelecionado = novoMes;
    });
  }

  _displaySnackBar(BuildContext context, String mensagem) {
    final snackBar = SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.green[900],
      );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _inserir(BuildContext context) {
    GastoMensal gasto;

    if(gastoMensal == null){
      gasto = GastoMensal(null,
      int.parse(_anoController.text),
      _mesSelecionado,
      _finalidadeController.text,
      double.parse(_valorController.text),
      _tipoGastoSelecionado);
    }
    else{
     gasto = GastoMensal(gastoMensal.id,
      int.parse(_anoController.text),
      _mesSelecionado,
      _finalidadeController.text,
      double.parse(_valorController.text),
      _tipoGastoSelecionado);
    }
    
    setState(() {
          _gastoController.salvar(gasto).then((res) {
          setState(() {
            _displaySnackBar(context, res);
            clearInputs();
          });
        });
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back), 
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListaGastoMensal())
            );
          }
        ),
        title: Text("\$ Gasto Mensal \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: buildTextField("Ano", _anoController , TextInputType.number),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Text("Mês:", style: TextStyle(color: Colors.amber)),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: buildDropDownButton(_mes, _alterarMes, _mesSelecionado),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: buildTextField("Finalidade", _finalidadeController, TextInputType.text),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: buildTextField("Valor", _valorController, TextInputType.numberWithOptions(decimal: true)),
            ),
            Container(
             padding: EdgeInsets.all(10.0),
             child: Row(
               children: <Widget>[
                 Text("Tipo da despesa:", style: TextStyle(color: Colors.amber)),
                 Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: buildDropDownButton(_tipoGasto, _alterarTipoGasto, _tipoGastoSelecionado),
                  ),
               ],
             ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton.icon(
                  onPressed: () {
                    _inserir(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ), 
                  icon: Icon(Icons.save, color: Colors.white), 
                  label: Text("Salvar", style: TextStyle(color: Colors.white)),
                  textColor: Colors.white,
                  splashColor: Colors.green,
                  color: Colors.amber,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}