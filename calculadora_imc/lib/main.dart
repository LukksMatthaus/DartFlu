import 'package:flutter/material.dart';
void main(){
   runApp(MaterialApp(
     home: Home() ,
   ));

}
class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String _infoText = "Informe seus dados";
  
  void _resetFileds(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
    _infoText = "Informe seus dados!";
    _formKey = GlobalKey<FormState>();
  
    });
    
  }

  void calculate(){
    setState(() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100; 
    double imc = weight / (height * height);
    if(imc < 18.6){
      _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      // usa como teste o 73 e 300 eh isto
    }  
    });
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true, 
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
          onPressed: _resetFileds,)
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),
        child: Form(
          key: _formKey,
          child:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(Icons.person_outline, size:120, color: Colors.green,),
          TextFormField(keyboardType: TextInputType.number,
              decoration: InputDecoration( labelText: "Peso (kg)",
              labelStyle: TextStyle(color: Colors.green),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25,),
              controller: weightController,
              validator: (value){
                if(value.isEmpty){
                  return "Insira seu Peso!";
                }
              },
          ),
          TextFormField(keyboardType: TextInputType.number,
              decoration: InputDecoration( labelText: "Altura (cm)",
              labelStyle: TextStyle(color: Colors.green),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25,),
              controller: heightController,
              validator: (value){
                if(value.isEmpty){
                  return "Insira sua Altura";
                } else if (value == "0"){
                  return "A sua altura não pode ser 0";
                }
              },
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom:10),
            child: Container(
            height: 50,
            child: RaisedButton(
            child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25.0),),
            color: Colors.green,
            onPressed: (){
              if(_formKey.currentState.validate()){
                calculate();
              }
            },
          ),)
          ),
          Text(
            _infoText,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 25),)
        ],
        ) , 
        )
         )
    );
  }
}