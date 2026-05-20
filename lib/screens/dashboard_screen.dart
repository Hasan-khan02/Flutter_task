import 'package:flutter/material.dart';
import 'detail_screen.dart';

class DashboardScreen extends StatelessWidget{

DashboardScreen({super.key});

List subjects=[

"Mobile App Development",
"Software Re-engineering",
"Management Information Systems"

];

@override
Widget build(BuildContext context){

return Scaffold(

appBar:
AppBar(title:Text("Dashboard")),

body:

ListView.builder(

itemCount:subjects.length,

itemBuilder:(context,index){

return ListTile(

title:
Text(subjects[index]),

onTap:(){

Navigator.push(

context,

MaterialPageRoute(

builder:(_)=>DetailScreen(
subject:subjects[index]
)

)

);

}

);

}

)

);

}

}