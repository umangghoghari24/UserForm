import 'package:flutter/material.dart';
import 'package:userform/userform.dart';

class userlogo extends StatefulWidget {
  const userlogo({Key? key}) : super(key: key);

  @override
  State<userlogo> createState() => _userlogoState();
}

class _userlogoState extends State<userlogo> {
  bool loaded = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      loaded = true;
    });
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>csc()));
      setState(() {
        loaded = false;
      });
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 310,),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assetsimage/img.jpg',),
            ),
            SizedBox(height: 10,),
            Text('Userform',style: TextStyle(
              fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 20,
            ),),
            SizedBox(height: 10,),
            CircularProgressIndicator(
              color: Colors.lightBlueAccent,
            )
          ],
        ),
      ),
    );
  }
}
