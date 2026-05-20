import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget{

final String subject;

const DetailScreen({
super.key,
required this.subject
});

@override
Widget build(BuildContext context){

return Scaffold(

appBar:
AppBar(
title:
Text(subject)
),

body:
Column(

children:[

Image.network(
'https://picsum.photos/300'
),

SizedBox(height:20),

Text(
"Course overview"
),

Text(
"Timing : 9 AM -11 AM"
)

]

)

);

}

}