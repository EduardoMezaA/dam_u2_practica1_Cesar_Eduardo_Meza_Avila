import 'package:flutter/material.dart';

class practica1 extends StatefulWidget {
  const practica1({Key? key}) : super(key: key);

  @override
  State<practica1> createState() => _practica1State();
}

class _practica1State extends State<practica1> {
  final burro = TextEditingController();
  bool _isChecked = false;
  int burritos = 0;
  int salsaxd = 0;
  bool _boton  = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 239, 200, 50),
      appBar: AppBar(title: const Text("Práctica 1: Venta de burritos"),
        actions: [
          IconButton(onPressed: (){
            burritos = 0;
            _isChecked = false;
            _boton  = false;
            burro.clear();
            setState(() {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("OVER OVER")));
            });
          }, icon: Icon(Icons.new_label),)
        ],),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.fromLTRB(60,10,60,10)),
          const Text("Ordena aquí!!!", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.red),),
          SizedBox(height: 10,),
          Image.asset('assets/burritos.jpg', width: 250, height: 250,),
          Padding(padding: EdgeInsets.fromLTRB(60,10,60,10),
            child: TextField(
              controller: burro,
              decoration: InputDecoration(
                labelText: "De que quieres el burro",
                prefixIcon: Icon(Icons.dangerous),
              ),
            ),
          ),

          SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Salsa extra"),
              Checkbox(value: _isChecked, onChanged: (bool? n){
                if(_isChecked){
                  salsaxd = 0;
                }else{
                  salsaxd = 10;
                }

                setState(() {
                  _isChecked = n!;
                });
              }),
            ],
          ),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                if(burritos > 0){
                  burritos--;
                }else{
                  setState(() {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("NO")));
                  });
                }

                if(burritos == 0){
                  _boton = false;
                }

                setState(() {
                });
              }, child: const Text("-",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    minimumSize: Size(50, 50)),),

              SizedBox(width: 60,),

              Text("${burritos}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                  color: Colors.red),),


              SizedBox(width: 60,),

              ElevatedButton(onPressed: (){
                burritos = burritos + 1;
                if(burritos > 0){
                  _boton = true;
                }
                setState(() {

                });
              }, child: const Text("+",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    minimumSize: Size(50, 50)),),
            ],
          ),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: _boton ? (){
            total(burro.text, burritos, salsaxd);
          }: null, child: Text("Comprar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                minimumSize: Size(300, 50)),),

        ],
      ),
    );
  }

  void total(String text, int burritos, int salsaxd) {
    //a 30 el burrito
    int total = (burritos * 30) + salsaxd;
    String zapallo = "burritos";

    if(burritos < 2){
      zapallo = "burro";
    }

    if(text == ""){
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("No dijiste de que los quieres")));
      });
    }else{
      showDialog(context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("TOTAL A PAGAR"),
              content: Text("Su pedido es: ${burritos} ${zapallo} de ${text}"
                  "\n \n Total a pagar: ${total}", style: TextStyle(fontSize: 16),),
              actions: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop();//Quita el cuadro de dialogo
                }, child: Text("Ok"))
              ],
            );
          });
    }

  }
}