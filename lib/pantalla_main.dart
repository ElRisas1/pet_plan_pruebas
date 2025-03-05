import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key, required this.title});

  final String title;
  
  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {

  //AQUI VAN LAS VARIABLES GLOBALES//

  @override
  void initState(){
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
      return  Scaffold( 
        
        backgroundColor: const Color.fromARGB(248, 238, 220, 138),
        body: 
        
        content(),
        /**
         SingleChildScrollView(child:Column(mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Divider(height: 80),
             ], //Children 
        ))
         */
      );
  } //Build

  Widget content() {
    
    return Container(
       margin: const EdgeInsets.only(left: 15, top: 350, bottom: 20),   
       child: CarouselSlider(
        
        items: [1,2,3].map((i) { 
          return Container(
           
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 7),

            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 232, 236, 239),
              borderRadius: BorderRadius.circular(10),
             /* boxShadow: [
                BoxShadow(
                  
                  color: Colors.grey.withValues(),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 0),
                )
              ]*/
            ),
            child: Text("mascota \n número: $i", style: TextStyle(fontSize: 35),),
          );
        },).toList(),
         options: CarouselOptions(
          
          height: 150,
          
        ),
      ),
    );
  }
} 