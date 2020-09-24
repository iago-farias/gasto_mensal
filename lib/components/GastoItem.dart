import 'package:flutter/material.dart';
import '../model/GastoMensal.dart';
import '../view/cadastroGastoMensal.dart';

class GastoItem extends StatelessWidget {
  final GastoMensal _gastoMensal;
  final Function _excluir;

  GastoItem(this._gastoMensal, this._excluir);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _gastoMensal.finalidade,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, ),
                ),
                Text(
                  _gastoMensal.valor.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 45.0,
                  height: 45.0,
                  child: FlatButton(
                    child: Icon(Icons.edit, color: Colors.blue[500],),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => Cadastro(_gastoMensal)),
                      );
                    },
                  ),
                ),
                ButtonTheme(
                  minWidth: 45.0,
                  height: 45.0,
                  child: FlatButton(
                    child: Icon(Icons.delete,color: Colors.red),
                    onPressed: () {
                      _excluir(context, _gastoMensal.id);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
