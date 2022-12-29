
import 'package:flutter/material.dart';
import 'package:quotes_app/models/images.dart';
import 'package:quotes_app/models/quotes.dart';
import 'package:quotes_app/services/remote_services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Quotes>? quotes;
  late Images images;
  List<Hit>? Lhits;
  bool isLoaded= false;
  @override
  void initState(){

    super.initState();
    getData();

  }

  //getting data
  getData() async{
    quotes= await RemoteService().getQuotes();
    images= (await RemoteService().getImages())!;
    Lhits= images.hits;
    int l=1;
    if(quotes!=null && images!=null){
      l= quotes!.length;
      debugPrint(l.toString());
      setState(() {
        isLoaded= true;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(child: Text('Beautiful Quotes')),
      ),
      body: Visibility(
        visible: isLoaded,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          ListView.builder(
              itemCount: Lhits?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey,
                                image: new DecorationImage(
                            image: NetworkImage(Lhits![index].previewUrl),
                        fit: BoxFit.fill,
                      )
                            ),


                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text( quotes![index].text.toString(),
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                Text("Author: " + quotes![index].author.toString() ,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
        replacement: const Center(child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
