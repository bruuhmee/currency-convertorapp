import 'package:flutter/material.dart';
//C:\Users\Windows 11\AndroidStudioProjects\firstprojflu\lib
class CurrencyConvertorMaterialPage extends StatefulWidget {
  const CurrencyConvertorMaterialPage({super.key});

  @override
  State<CurrencyConvertorMaterialPage> createState()=> _CurrencyConvertorMaterialPageState();
  }
class _CurrencyConvertorMaterialPageState extends State<CurrencyConvertorMaterialPage>{
  double result=0;
  final TextEditingController textEditingController=TextEditingController();
  String selectedCurrency='INR';
  double conversionRate=81.00;
  final Map<String, double> currencyRates = {
    'INR': 81,
    'EUR': 0.93,
    'GBP': 0.79,
  };
  void _convertCurrency() {
    setState(() {
      try {
        double usdAmount = double.parse(textEditingController.text);
        result = usdAmount * conversionRate;
      } catch (e) {
        result = 0;
      }
    });
  }

  void _changeCurrency(String currency) {
    setState(() {
      selectedCurrency = currency;
      conversionRate = currencyRates[currency]!;
    });
  }

  void _resetInput(){
    textEditingController.clear();
    setState(() {
      result=0;
    });
  }
  @override
  Widget build(BuildContext context){

    final border =OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black, // Set  the border color when focused
        width: 2.0,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
      borderRadius: BorderRadius.circular(20),
    );
    double fontSize = (result == 0 ? 50 : 50 - result * 0.05);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text('Currency Convertor',),
          centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.currency_exchange),
              onSelected: _changeCurrency,
              itemBuilder: (BuildContext context) {
                return currencyRates.keys.map((String currency) {
                  return PopupMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: ColoredBox(color:Colors.grey,
          child: Center(child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('$selectedCurrency ${result != 0 ? result.toStringAsFixed(2) : result.toStringAsFixed(0)}',
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255 , 255, 255))),

              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: textEditingController ,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Please enter the amount in USD ',
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    prefixIcon: const Icon(Icons.monetization_on),
                    prefixIconColor: Colors.black,
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder:  border,
                    enabledBorder: border,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child:
                TextButton(onPressed: () {
                  setState((){
                    result=(double.parse(textEditingController.text)*81);
                  });
                },
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: (Colors.black),
                      minimumSize : const Size(double.infinity , 50),
                      shape: (RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), ))),

                  child: const Text('Click Here'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 05),
                child:
                ElevatedButton(
                onPressed: _resetInput,
                child: const Text('Reset'),
              ),)
            ], ),
          ), )
    );
  }
}
