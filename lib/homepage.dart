import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'itemdetail.dart';


class HomePage extends StatelessWidget {
 Future<List> getProfileList() async {
    http.Response response = await http.get("https://jsonplaceholder.typicode.com/users");
    return json.decode(response.body);
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile from htttp"),
      ),
      body: Container(
        child: FutureBuilder(
          future: getProfileList(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot){
           if(!snapshot.hasData) return
           Center(child: CircularProgressIndicator(),
           );

            // if(!snapshot.hasError)return 
            // Center(child: Text("Error in Connection of internet"),
            // );

            List users =snapshot.data;
            
             return ListView.builder(
               itemCount: users.length,
               itemBuilder: (BuildContext context , int index){
                 var user =users[index];
                 return ListTile(
                   onTap: ()=>Navigator.push(context, MaterialPageRoute(
                  builder: (_) => ItemDetails(user:user)
                )),
                  title: Text(users[index]['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Text(user["email"]),
                    SizedBox(height: 5.0), 
                    Text(user["phone"]) 
                    
                    ],
                  ),
                 );
               },
             );
          },
        ),
      ),
    );
  }
}