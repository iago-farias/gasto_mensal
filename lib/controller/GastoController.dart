import '../model/GastoMensal.dart';
import '../persistence/GastoMensalDAO.dart';


class GastoController {
  Future<String> salvar(GastoMensal gastoMensal) async {
    int res = 0;

    if(gastoMensal.id == null){
      res = await GastoMensalDAO.inserir(gastoMensal);
    }else{
      res = await GastoMensalDAO.alterar(gastoMensal);
    }

    if (res == 0) {
     return "Erro ao salvar registro";
    } else {
      return "Salvo com sucesso.";
    }
  }

  Future<List<GastoMensal>> findAll() async {
    List<GastoMensal> gastos = await GastoMensalDAO.findAll();

    return gastos;
  }

  Future<String> excluir(int id) async {
    int res = 0;

    res = await GastoMensalDAO.excluir(id);

    if (res == 0) {
      return "Erro ao excluir registro";
    } else {
      return "Excluído com sucesso.";
    }
  }
}