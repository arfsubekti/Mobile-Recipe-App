import 'package:flutter/material.dart';

class DetailResep extends StatefulWidget {
  final String title;
  final String url;
  final List<String> bahan;
  final List<String> caraBuat;
  const DetailResep({super.key, required this.title, required this.url, required this.bahan, required this.caraBuat});

  @override
  State<DetailResep> createState() => _DetailResepState();
}

class _DetailResepState extends State<DetailResep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resep ${widget.title}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      widget.url,
                      fit: BoxFit.cover,
                    ),
                  )),
              SizedBox(height: 10,),
              Text(" Bahan - Bahan",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(widget.bahan.length, (index){
                  return Text(widget.bahan[index]);
                }),
              ),
              SizedBox(height: 10,),
              Text(" Cara Membuat",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(widget.caraBuat.length, (index){
                  return Text("${index + 1}. ${widget.caraBuat[index]}" );
                }),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
