import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:intl/intl.dart';
// import 'package:csc_picker/model/select_status_model.dart';
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

  var selected = 'male';
  var check = false;
  File ? _imageFile;

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


  void resetdata() {
    uname.text = '';
    pass.text = '';
    cpass.text = '';
    email.text = '';
    mobile.text = '';
    dob.text = '';
    city.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Wel come to user app',
      //   ),
      //   backgroundColor: Colors.transparent,
      // ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0mXkfDwdEbS2yG2NrY6MDhBp2IoRhboSaRg&usqp=CAU'),
        //     fit: BoxFit.fill
        //   )
        // ),
        // height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Form(
            key: Treck_keys,
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://img.freepik.com/free-vector/man-going-trip-booking-tour-online-guy-sitting-front-computer-table-looking-voyage-summer-vacation_575670-946.jpg?w=360'),
                            fit: BoxFit.fill
                        )),
                    height: MediaQuery.of(context).size.height -500,
                    ),
                SizedBox(
                  height: 1,
                ),
              //  Text('Enter Your User Details‍‍',style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
                Container(
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd7hN7tr7rLdleu3r-CLaEvfwJXTF9a-c66w&usqp=CAU'),
                  //     fit: BoxFit.cover
                  //   )
                  // ),
                  //   width: 500,
                  // height: 90,
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
                // Padding(
                //   padding: const EdgeInsets.only(right: 230),
                //   child: Text(
                //     'Enter User Name :',
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontStyle: FontStyle.italic,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 15),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextFormField(
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
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: Icon(Icons.person,size: 31,color: Colors.black,),
                        ),
                        // prefixIcon: Icon(
                        //   Icons.person,
                        //   color: Colors.black87,
                        //   size: 31,
                        // ),
                        // focusedBorder: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(23),
                        //     borderSide:
                        //         BorderSide(width: 2, color: Colors.black)),
                        // enabledBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(width: 2, color: Colors.black),
                        //   borderRadius: BorderRadius.circular(23),
                        // ),
                      )),
                ),
                SizedBox(
                  height: 13,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 200),
                //   child: Text('Enter Your Password :',
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontStyle: FontStyle.italic,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 15)),
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextFormField(
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
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                      // prefixIcon: Icon(
                      //   Icons.lock,
                      //   color: Colors.black87,
                      // ),
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Icon(Icons.lock,color: Colors.black,size: 29,),
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
                      // focusedBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(23),
                      //     borderSide: BorderSide(width: 2, color: Colors.black)),
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(width: 2, color: Colors.black),
                      //   borderRadius: BorderRadius.circular(23),
                      // ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 180),
                //   child: Text('Enter Confime Password :',
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontStyle: FontStyle.italic,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 15)),
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextFormField(
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
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                      // prefixIcon: Icon(
                      //   Icons.lock,
                      //   color: Colors.black87,
                      //   size: 30,
                      // ),
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Icon(Icons.lock,size: 29,color: Colors.black,),
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
                      // focusedBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(23),
                      //     borderSide: BorderSide(width: 2, color: Colors.black)),
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(width: 2, color: Colors.black),
                      //   borderRadius: BorderRadius.circular(23.0),
                      // ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 230),
                //   child: Text('Enter Email_id :',
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontStyle: FontStyle.italic,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 15)),
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextFormField(
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

                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      // prefixIcon: Icon(
                      //   Icons.email,
                      //   color: Colors.black,
                      // ),
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Icon(Icons.email,size: 29,color: Colors.black,),
                      )
                      // focusedBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(23),
                      //   borderSide: BorderSide(width: 2, color: Colors.black),
                      // ),
                      // enabledBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(width: 2, color: Colors.black),
                      //     borderRadius: BorderRadius.circular(23)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 170),
                //   child: Text('Enter Your Mobile Number :',
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontStyle: FontStyle.italic,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 15)),
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextFormField(
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

                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        // prefixIcon: Icon(
                        //   Icons.phone,
                        //   color: Colors.black,
                        //   size: 31,
                        // ),
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Icon(Icons.phone,size: 29,color: Colors.black,),
                      )
                        // focusedBorder: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(23),
                        //     borderSide:
                        //         BorderSide(width: 2, color: Colors.black)),
                        // enabledBorder: OutlineInputBorder(
                        //     borderSide: BorderSide(width: 2, color: Colors.black),
                        //     borderRadius: BorderRadius.circular(23))
                    ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 220),
                //   child: Text('Enter Birth Date :',
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontStyle: FontStyle.italic,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 15)),
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextFormField(
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

                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      // prefixIcon: Icon(
                      //   Icons.calendar_month_outlined,
                      //   color: Colors.black,
                      //   size: 31,
                      // ),
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Icon(Icons.calendar_month_outlined,size: 29,color: Colors.black,),
                      )
                      // focusedBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(23),
                      //   borderSide: BorderSide(
                      //     width: 2,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      // enabledBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(width: 2, color: Colors.black),
                      //     borderRadius: BorderRadius.circular(23)),
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
                ),
                SizedBox(
                  height: 13,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 240),
                //   child: Text('Enter Your City :',
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontStyle: FontStyle.italic,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 15)),
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextFormField(
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
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      // prefixIcon: IconButton(
                      //     onPressed: () {
                      //       showModalBottomSheet(
                      //           context: context,
                      //           builder: (context) => country());
                      //     },
                      //     icon: Icon(Icons.location_city)),
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Icon(Icons.location_city,size: 29,color: Colors.black,),
                      )
                      // focusedBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(23),
                      //   borderSide: BorderSide(
                      //     width: 2,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      // enabledBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(width: 2, color: Colors.black),
                      //     borderRadius: BorderRadius.circular(23)),
                    ),
                  ),
                ),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: 15,
                //     ),
                //     Text(
                //       'Gender :',
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 18,
                //           fontStyle: FontStyle.italic),
                //     ),
                //     RadioMenuButton(
                //         value: 1,
                //         groupValue: selected,
                //         onChanged: (value) {
                //           setState(() {
                //             selected = 1;
                //             print('$selected');
                //           });
                //           //   value = selected;
                //         },
                //         child: Text(
                //           "Male",
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 17,
                //               fontStyle: FontStyle.italic),
                //         )),
                //     RadioMenuButton(
                //       value: 2,
                //       groupValue: selected,
                //       onChanged: (value) {
                //         setState(() {
                //           selected = 2;
                //           print('$selected');
                //         });
                //       },
                //       child: Text(
                //         "Female",
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 17,
                //             fontStyle: FontStyle.italic),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 13,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Text('Gender :-',style:
                      TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(width: 20,),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: Image(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoGa43cPo70DYcZ847mc02nOf8y0r9nJ38WQ&usqp=CAU')),

                          // child: IconButton(onPressed: () {
                          //   setState(() {
                          //     selected = 'male';
                          //     print('$selected');
                          //   });
                          // },
                          //     icon: Icon(Icons.male,size: 35,))

                        ),
                        Text('Male',style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(width: 32,),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Image(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrH61XOFcRQuQs_ZY5yNgm9QMdrBup7J2-qA&usqp=CAU',)
                          ),

                          // child: IconButton(onPressed: () {
                            //   setState(() {
                            //     selected = 'female';
                            //     print('$selected');
                            //   });
                            // },
                            //     icon: Icon(Icons.female,size: 35,))
                        ),
                        Text('Female', style : TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                      ],
                    )
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
                              var postUri = Uri.parse('https://pinkesh2620.000webhostapp.com/api.php');
                              http.MultipartRequest request = http.MultipartRequest('POST', postUri);
                              if(_imageFile!=null){
                                request.files.add(http.MultipartFile.fromBytes('photo', File(_imageFile!.path).readAsBytesSync(),filename: _imageFile!.path));
                              }
                              request.fields['uname'] = uname.text;
                              request.fields['pass'] = pass.text;
                              request.fields['cpass'] = cpass.text;
                              request.fields['email'] = email.text;
                              request.fields['mob'] = mobile.text;
                              request.fields['birthdate'] = dob.text;
                              request.fields['country'] = city.text;
                             // request.fields['gender'] = gender.toString();
                              var streamedResponse = await request.send();
                              var response = await http.Response.fromStream(streamedResponse);
                            //  print(response.statusCode);
                              if (response.statusCode == 200) {
                               print(request.fields);
                                var data = await jsonDecode(response.body);
                                if (data['status'] == 1) {
                                  Get.defaultDialog(
                                      title: 'Regitretion Successful',
                                      middleText: '',
                                      titlePadding: EdgeInsets.only(top: 40),
                                      titleStyle: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic),
                                      radius: 15,
                                      backgroundColor: Colors.white,
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>()));
                                            },
                                            child: Text('Ok'))
                                      ]);
                                }
                              } else {
                                print('something went wrong');
                              }
                            }
                          },
                        ),
                      ),
                    ),
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
    );
    if (pickedFile == null) return;
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  getfromcamera() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera);
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
