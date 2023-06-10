import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:intl/intl.dart';
import 'package:csc_picker/model/select_status_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class csc extends StatefulWidget {
  const csc({Key? key}) : super(key: key);

  @override
  State<csc> createState() => _cscState();
}

class _cscState extends State<csc> {
  final Treck_keys = GlobalKey<FormState>();

  var days = DateFormat('yMMMMd').format(DateTime.now());

  int selected = 0;
  var check = false;
  var _imageFile;

  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController img = TextEditingController();

  var passnotvisible = true;
  var passwordnotvisible = true;

  Future<void> submitdata() async {}


  // late LocationData _currentPosition;
  // var late;
  // var long;
  //
  // Future<void> getLocation() async{
  //   if(await Permission.location.isGranted){
  //     _currentPosition = await Location().getLocation();
  //     // // pressure(_currentPosition);
  //     //   print("Location");
  //     print(_currentPosition.latitude);
  //     print(_currentPosition.longitude);
  //
  //     setState(() {
  //       late = _currentPosition.latitude.toString();
  //       long = _currentPosition.longitude.toString();
  //     });
  //
  //     String url ='https://api.openweathermap.org/data/2.5/forecast?late=$late&long=$long&appid=ff0d0154a0fbf7736676e415048f620b';
  //     var keys = 'ff0d0154a0fbf7736676e415048f620b';
  //     var response = await http.get (Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var mydata1 = await jsonDecode(response.body);
  //       //   Navigator.push(context, MaterialPageRoute(builder: (context) => weather()));
  //       print('response');
  //     } else {
  //       print('something went wrong');
  //     }
  //   }else{
  //     Permission.location.request();
  //   }
  // }


  void resetdata() {
    uname.text = '';
    pass.text = '';
    cpass.text = '';
    email.text = '';
    mobile.text = '';
    dob.text = '';
    city.text = '';
    gender.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wel come to user app',
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9zZf18lYEwbdOiWxkW1TEn65uVm5x88XvHQ&usqp=CAU'),
            fit: BoxFit.cover
          )
        ),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: Treck_keys,
            child: Column(
              children: [
                Container(
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         image: NetworkImage(
                    //             'https://img.freepik.com/premium-vector/modern-flat-design-isometric-illustration-augmented-reality-can-be-used-website-mobile-website-landing-page-easy-edit-customize-vector-illustration_145666-1443.jpg'),
                    //         fit: BoxFit.fill
                    //     )),
                    //
                    // height: MediaQuery.of(context).size.height -600,
                    ),
                SizedBox(
                  height: 1,
                ),
                Text('🧑Enter Your User Details🧑‍‍',style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd7hN7tr7rLdleu3r-CLaEvfwJXTF9a-c66w&usqp=CAU'),
                      fit: BoxFit.cover
                    )
                  ),
                    width: 500,
                  height: 90,
                  //  width: MediaQuery.of(context).size.width,
                    child: _imageFile == null
                        ? GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Wrap(children: [
                                      ListTile(
                                        onTap: () {
                                          getfromcamera();
                                        },
                                        leading: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 110),
                                          child: Icon(
                                            Icons.camera_alt,
                                          ),
                                        ),
                                        title: Text('Camera',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Divider(thickness: 1),
                                      ListTile(
                                          onTap: () {
                                            getfromgallry();
                                          },
                                          leading: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 110),
                                            child: Icon(Icons.image),
                                          ),
                                          title: Text('Gallery',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 17,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ]);
                                  });
                            },
                            child: CircleAvatar(
                              radius: 45,
                              child: Icon(Icons.camera_alt),
                            ),
                          )
                        : CircleAvatar(
                            radius: 45,
                            child: CircleAvatar(
                                backgroundColor: Colors.deepOrange,
                                backgroundImage: Image.file(
                                  _imageFile!,
                                  fit: BoxFit.cover,
                                ).image,
                                radius: 45))),
                SizedBox(height: 4,),
                Text('Select Photo',style:
                TextStyle(fontWeight: FontWeight.bold,fontSize: 17,fontStyle: FontStyle.italic),),


                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 230),
                  child: Text(
                    'Enter User Name :⤵',
                    style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: uname,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ' UserName is Required';
                      }
                    },
                    decoration: InputDecoration(
                      //   labelText: 'User Name',
                      hintText: 'User Name',
                      hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      filled: true,
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black87,
                        size: 31,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(23),
                      ),
                    )),
                SizedBox(
                  height: 13,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: Text('Enter Your Password :⤵',
                      style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ),
                TextFormField(
                  controller: pass,
                  obscureText: !passnotvisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password is Required';
                    }
                    String pattern =
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                    RegExp regExp = new RegExp(pattern);
                    var match = regExp.hasMatch(value);
                    if (value.length < 8) {
                      return 'Please Enter 8 charter';
                    } else {
                      if (match == false) {
                        return 'Enter the strong password';
                      }
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    filled: true,
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black87,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(passnotvisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          passnotvisible = !passnotvisible;
                        });
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23),
                        borderSide: BorderSide(width: 2, color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(23),
                    ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 180),
                  child: Text('Enter Confime Password :⤵',
                      style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: cpass,
                  obscureText: !passnotvisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password is wrong';
                    }
                    if (value != pass.text) {
                      return 'password is not match';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Confime password',
                    hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    filled: true,
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black87,
                      size: 30,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(passnotvisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          passnotvisible = !passnotvisible;
                        });
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23),
                        borderSide: BorderSide(width: 2, color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 230),
                  child: Text('Enter Email_id :⤵',
                      style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email_Id is Required';
                    }
                    if (!value.contains('@gmail.com')) {
                      return 'Email is not valid';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Email Id',
                    hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    filled: true,
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23),
                      borderSide: BorderSide(width: 2, color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(23)),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 170),
                  child: Text('Enter Your Mobile Number :⤵',
                      style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: mobile,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mobile number is Required';
                    }
                    if (value.length < 10 || value.length > 10) {
                      return 'Please Enter The vaild mobile number';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Mobile Number',
                      hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      filled: true,
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.black,
                        size: 31,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(23))),
                ),
                SizedBox(
                  height: 13,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 220),
                  child: Text('Enter Birth Date :⤵',
                      style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ),
                TextFormField(
                  controller: dob,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Dob is Required';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Select Dob Date',
                    hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    filled: true,
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    prefixIcon: Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.black,
                      size: 31,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(23)),
                  ),
                  onTap: () async {
                    DateTime? datepicker = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1995),
                        lastDate: DateTime(2025));
                    if (datepicker != null) {
                      setState(() {
                        dob.text = DateFormat('yMMMMd').format(datepicker);
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 13,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 240),
                  child: Text('Enter Your City :⤵',
                      style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ),
                TextFormField(
                  controller: city,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'city is Required';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Select City',
                    hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    filled: true,
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    prefixIcon: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => country());
                        },
                        icon: Icon(Icons.location_city)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(23)),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Gender :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontStyle: FontStyle.italic),
                    ),
                    RadioMenuButton(
                        value: 1,
                        groupValue: selected,
                        onChanged: (value) {
                          setState(() {
                            selected = 1;
                            print('$selected');
                          });
                          //   value = selected;
                        },
                        child: Text(
                          "Male",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontStyle: FontStyle.italic),
                        )),
                    RadioMenuButton(
                      value: 2,
                      groupValue: selected,
                      onChanged: (value) {
                        setState(() {
                          selected = 2;
                          print('$selected');
                        });
                      },
                      child: Text(
                        "Female",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                    ),
                    Checkbox(
                      value: check,
                      onChanged: (bool? value) {
                        setState(() {
                          check = value!;
                        });
                      },
                    ),
                    Text(
                      'I agree to the tems',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                    ),
                    IgnorePointer(
                      ignoring: !check,
                      child: Container(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              overlayColor:
                                  getColor(Colors.white, Colors.deepOrange)),
                          child: Text('Reset'),
                          onPressed: () {
                            resetdata();
                            if (Treck_keys.currentState!.validate()) {}
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    IgnorePointer(
                      ignoring: !check,
                      child: Container(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              overlayColor:
                                  getColor(Colors.white, Colors.deepOrange)),
                          child: Text('Submit'),
                          onPressed: () async {
                            if (Treck_keys.currentState!.validate()) {
                           //    var submitdata = {
                           //
                           // //     'img':img.isSelectionWithinTextBounds(_imageFile),
                           // //      'uname': uname.text,
                           // //      'pass': pass.text,
                           // //      'cpass': cpass.text,
                           // //      'email': email.text,
                           // //      'mob': mobile.text,
                           // //      'birthdate': dob.text,
                           // //      'gender': gender.text,
                           // //      'country': city.text,
                           //    };
                           //    // print(uname.text);
                           //    // print(pass.text);
                           //    // print(cpass.text);
                           //    // print(email.text);
                           //    // print(mobile.text);
                           //    // print(dob.text);
                           //    // print(city.text);
                           //  //  print(gender.value);
                              var postUri = Uri.parse('https://pinkesh2620.000webhostapp.com/api.php');
                              http.MultipartRequest request = http.MultipartRequest('POST', postUri);
                              http.MultipartFile multipartFile = await http.MultipartFile.fromPath('file',_imageFile);
                              request.files.add(multipartFile);
                              request.fields['uname'] = uname.text;
                              request.fields['pass'] = pass.text;
                              request.fields['cpass'] = cpass.text;
                              request.fields['email'] = email.text;
                              request.fields['mob'] = mobile.text;
                              request.fields['birthdate'] = dob.text;
                              request.fields['city'] = city.text;
                              http.StreamedResponse response = await request.send();
                              print(response.statusCode);
                              // if (response.statusCode == 200) {
                              //     print(jsonEncode(response));
                              //   // var data = await jsonDecode(response.body);
                              //   // if (data['status'] == 1) {
                              //   //   Get.defaultDialog(
                              //   //       title: 'Regitretion Successful',
                              //   //       middleText: '',
                              //   //       titlePadding: EdgeInsets.only(top: 40),
                              //   //       titleStyle: TextStyle(
                              //   //           fontSize: 17,
                              //   //           color: Colors.black,
                              //   //           fontStyle: FontStyle.italic),
                              //   //       radius: 15,
                              //   //       backgroundColor: Colors.white,
                              //   //       actions: [
                              //   //         ElevatedButton(
                              //   //             onPressed: () {
                              //   //               //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginpage()));
                              //   //             },
                              //   //             child: Text('Ok'))
                              //   //       ]);
                              //   // }
                              // } else {
                              //   print('something went wrong');
                              // }


                              //   var response = await http.post(
                            //       Uri.parse(
                            //           'https://pinkesh2620.000webhostapp.com/api.php'),
                            //       body: jsonEncode(submitdata));
                              // if (response.statusCode == 200) {
                              //   //  print(jsonEncode(submitdata));
                              //   var data = await jsonDecode(response.body);
                              //   if (data['status'] == 1) {
                              //     Get.defaultDialog(
                              //         title: 'Regitretion Successful',
                              //         middleText: '',
                              //         titlePadding: EdgeInsets.only(top: 40),
                              //         titleStyle: TextStyle(
                              //             fontSize: 17,
                              //             color: Colors.black,
                              //             fontStyle: FontStyle.italic),
                              //         radius: 15,
                              //         backgroundColor: Colors.white,
                              //         actions: [
                              //           ElevatedButton(
                              //               onPressed: () {
                              //                 //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginpage()));
                              //               },
                              //               child: Text('Ok'))
                              //         ]);
                              //   }
                              // } else {
                              //   print('something went wrong');
                              // }
                            }
                          //  if (Treck_keys.currentState!.validate()) {}
                          },
                        ),
                      ),
                    ),

                    // ElevatedButton(onPressed: () async {
                    //   if(Treck_keys.currentState!.validate()) {
                    //     var submitdata = {
                    //       'uname':uname.text,
                    //       'pass':pass.text,
                    //       'cpass':cpass.text,
                    //       'email': email.text,
                    //       'mob': mobile.text,
                    //       'birthdate': dob.text,
                    //       'gender': gender.text,
                    //       'country': city.text,
                    //     };
                    //     print(uname.text);
                    //     print(pass.text);
                    //     print(cpass.text);
                    //     print(email.text);
                    //     print(mobile.text);
                    //     print(dob.text);
                    //     print(city.text);
                    //     print(gender.value);
                    //     var response = await http.post(
                    //         Uri.parse('https://ntce.000webhostapp.com/get.php'),
                    //         body: jsonEncode(submitdata)
                    //     );
                    //     if (response.statusCode == 200) {
                    //       //  print(jsonEncode(submitdata));
                    //       var data= await jsonDecode(response.body);
                    //       if (data['status']==1) {
                    //         Get.defaultDialog(
                    //             title: 'Regitretion successful',
                    //             middleText: '',
                    //             titlePadding: EdgeInsets.only(top: 40),
                    //             titleStyle: TextStyle(fontSize: 17,color: Colors.black,fontStyle: FontStyle.italic),
                    //             radius: 15,
                    //             backgroundColor: Colors.white,
                    //             actions: [
                    //               ElevatedButton(onPressed: () {
                    //
                    //                 //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginpage()));
                    //               }, child: Text('Ok'))
                    //             ]
                    //         );
                    //       }
                    //     } else {
                    //       print('something went wrong');
                    //     }
                    //   }
                    // },
                    //     child: Text('Submit')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  MaterialStateProperty<Color> getColor(Color color, Color colorpressed) {
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return colorpressed;
      } else {
        return color;
      }
    };
    return MaterialStateProperty.resolveWith(getColor);
  }

  getfromgallry() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 200,
      maxWidth: 150,
    );
    if (pickedFile == null) return;
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  getfromcamera() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 100, maxHeight: 100);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Widget country() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text('Select city'),
            SizedBox(
              height: 100,
            ),
            CSCPicker(
              layout: Layout.vertical,
              flagState: CountryFlag.DISABLE,
              onCountryChanged: (Countries) {},
              onStateChanged: (state) {},
              onCityChanged: (City) {},
              countryDropdownLabel: "Country",
              stateDropdownLabel: 'State',
              cityDropdownLabel: 'city',
              searchBarRadius: 25,
            ),
            ElevatedButton(
              onPressed: () {
                     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>country())) ;
              },
              child: Text('Okk'),
            )
          ],
        ),
      ),
    );
  }
// Widget Buttom () {
//   return Container(
//     height: 250,
//     // width: MediaQuery.of(context).size.width,
//     child: Padding(
//       padding: const EdgeInsets.only(top: 15),
//       child: Card(
//         // color: Colors.amberAccent,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 12),
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border.all(width: 1),
//             ),
//             child: Column(
//               // mainAxisSize: MainAxisSize.max,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   color: Colors.deepOrange,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 125),
//                     child: Row(
//                       children: [
//                         IconButton(onPressed: () {
//                           //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Cameraapp()));
//                         },
//                           icon: Icon(Icons.camera),
//                           color: Colors.white,),
//                         Text('Camera',
//                           style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
//                       ],
//                     ),
//                   ),
//                 ),Divider(thickness: 1,color: Colors.black,),
//
//                 Container(
//                   width: MediaQuery.of(context).size.width, color: Colors.deepOrange,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 125),
//                     child: Row(
//                       children: [
//                         IconButton(onPressed: () {},
//                           icon: Icon(Icons.photo),color: Colors.white,),
//                         Text('Gallery',
//                           style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
//                       ],
//                     ),
//                   ),
//                 ),Divider(thickness: 1,color: Colors.black,),
//                 Container(
//                   width: MediaQuery.of(context).size.width, color: Colors.deepOrange,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 125),
//                     child: Row(
//                       children: [
//                         IconButton(onPressed: () {},
//                           icon: Icon(Icons.cancel),color: Colors.white,),
//                         Text('Cancel',
//                           style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
}
