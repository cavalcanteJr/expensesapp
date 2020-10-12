import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Teste para a aplicação de controle de finanças', () {
    //Aqui iniciamos nosso driver para conectar com o dispositivo
    FlutterDriver driver;

    //Então criamos uma função Assíncrona para fazer a conexão do driver
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    //Nesse função a gente verificar se há uma conexão, se tiver a gente fecha a conexão
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Verificar se o aplicativo inicia sem nenhuma conta cadastrada', () async {
      final noExpenses = find.byValueKey('noExpenses');

      expect(await driver.getText(noExpenses), 'Nenhuma transação cadastrada');
    });

    test('Cadastrando a primeira conta', () async {
      //Key's transaction form
      final addBtn = find.byValueKey('add_btn');
      final expTitle = find.byValueKey('title_exp');
      final expValue = find.byValueKey('value_exp');
      final saveBtn = find.byValueKey('save_btn');

      //Key's transaction list
      final transactionTitle = find.byValueKey('transaction_title');
      final transactionValue = find.byValueKey('transaction_value');

      //Execução dos passos para adicionar uma dispesa
      await driver.tap(addBtn);
      await driver.tap(expTitle);
      await driver.enterText('Minha primeira despesa');
      await driver.tap(expValue);
      await driver.enterText('123');
      await driver.tap(saveBtn);

      //Captura das propriedades dos Elementos e pegando exatamente o elemento Value, que representa os valores inseridos no Form
      final transactionTitleProps = (await driver.getWidgetDiagnostics(transactionTitle))['properties'] as List;
      var transactionTitleValue = transactionTitleProps[3]['value'];

      final transactionValueProps = (await driver.getWidgetDiagnostics(transactionValue))['properties'] as List;
      var transactionValueValue = transactionValueProps[3]['value'];

      //Comparando os valores
      expect(transactionTitleValue, 'Minha primeira despesa');
      expect(transactionValueValue, 'R\$123.0');
    });

    // test('Deletar uma despesa com swipe', () async {
    //   final noExpenses = find.byValueKey('noExpenses');

    //   //Key's transaction list
    //   final transactionValue = find.byValueKey('transaction_value');

    //   await driver.scroll(transactionValue, 300, 0, Duration(milliseconds: 500));
    //   expect(await driver.getText(noExpenses), 'Nenhuma transação cadastrada');
    // });

    test('Deletar uma despesa com swipe 2', () async {
      final noExpenses = find.byValueKey('noExpenses');

      //Key's transaction list
      final transactionValue = find.byValueKey('transaction_value');

      await driver.scrollUntilVisible(transactionValue, noExpenses, dxScroll: -300);

      expect(await driver.getText(noExpenses), 'Nenhuma transação cadastrada');
    });
  });
}
