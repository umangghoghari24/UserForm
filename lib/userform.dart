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
import 'package:userform/userlogo.dart';



class csc extends StatefulWidget {
  const csc({Key? key}) : super(key: key);

  @override
  State<csc> createState() => _cscState();
}

class _cscState extends State<csc> {


  final Treck_keys = GlobalKey<FormState>();
  String? selectedValue;
  final List<String> items = [
      'Ahmedabad',
    	'Surat',
    	'Vadodara',
      'Rajkot',
    	'Bhavnagar',
    	'Jamnagar',
    	'Gandhinagar',
    	'Junagadh',
    	'Gandhidham',
    	'Anand',
    	'Navsari',
    	'Morbi',
    	'Nadiad',
    	'Surendranagar',
    	'Bharuch',
    	'Mehsana',
    	'Bhuj',
    	'Porbandar',
    	'Palanpur',
    	'Valsad',
    	'Vapi',
    	'Gondal',
    	'Veraval',
    	'Godhra',
    	'Patan',
    	'Kalol',
    	'Dahod',
    	'Botad',
    	'Amreli',
     'Deesa',
     'Jetpur'
  ];

  var days = DateFormat('yMMMMd').format(DateTime.now());
  String? selected;
  var select = 'male';
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

  //Future<void> submitdata() async {}


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
      appBar: AppBar(
        title: Text(
          'Wel come to user app',
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assetsimage/bg.jpg'),
              fit: BoxFit.fill
          )
        ),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Form(
            key: Treck_keys,
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assetsimage/imang.jpg'),
                            fit: BoxFit.fill
                        )),
                    height: MediaQuery.of(context).size.height -500,
                    ),
                SizedBox(
                  height: 1,
                ),
                Container(
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
                                backgroundColor: Colors.lightBlueAccent,
                                backgroundImage: Image.file(
                                  _imageFile!,
                                  fit: BoxFit.cover,
                                ).image,
                                radius: 45))),
                SizedBox(height: 4,),
                Text('Select Photo',style:
                TextStyle(fontWeight: FontWeight.bold,fontSize: 17,fontStyle: FontStyle.italic,),),
                SizedBox(
                  height: 8,
                ),
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
                      )),
                ),
                SizedBox(
                  height: 13,
                ),
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
                    ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),

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
                    ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
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
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Icon(Icons.email,size: 29,color: Colors.black,),
                      )
                    ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
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
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Icon(Icons.phone,size: 29,color: Colors.black,),
                      )
                    ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
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
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Icon(Icons.calendar_month_outlined,size: 29,color: Colors.black,),
                      )
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
                Padding(
                  padding: const EdgeInsets.only(right: 18,left: 52),
                  child: DropdownButton(
                    hint: Text('Select City :',style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                ),),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_drop_down,size: 35,),
                    isExpanded: true,
                    value: selectedValue,
                      onChanged: (newvalue) {
                      setState(() {
                        selectedValue = newvalue;
                      });
                      },
                    items: items.map((selectedValue) {
                      return DropdownMenuItem(
                        value: selectedValue,
                          child: Text(selectedValue),
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
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
                          child: Image(image: AssetImage('assetsimage/male.jpg'),
                        ),
                        ),
                        SizedBox(height: 5,width: 10,),

                        RadioMenuButton(
                            value: 'male',
                            groupValue: selected,
                            onChanged: (value) {
                              setState(() {
                                selected = value;
                                print('$selected');
                              });
                            },
                            child: Text(
                              "Male",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  fontStyle: FontStyle.italic),
                            ),),
                      ],
                    ),
                    SizedBox(width: 2,),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Image(image: AssetImage('assetsimage/female.jpg')
                          ),
                        ),
                        RadioMenuButton(
                                  value: 'Female',
                                  groupValue: selected,
                                  onChanged: (value) {
                                    setState(() {
                                      selected = 'Female';
                                      print('$selected');
                                    });
                                  },
                                  child: Text(
                                    "Female",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        fontStyle: FontStyle.italic),
                                  )),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 40,
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
                                  getColor(Colors.white, Colors.lightBlueAccent)),
                          child: Text('Reset',style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),),
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
                                  getColor(Colors.white, Colors.lightBlueAccent)),
                          child: Text('Submit',style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),),
                          onPressed: () async {
                            if (Treck_keys.currentState!.validate()) {
                              var postUri = Uri.parse('https://ntce.000webhostapp.com/get.php');
                              http.MultipartRequest request = http.MultipartRequest('POST', postUri);
                              if(_imageFile!=null) {
                                request.files.add(http.MultipartFile.fromBytes('photo', File(_imageFile!.path).readAsBytesSync(),filename: _imageFile!.path));
                              }
                              request.fields['uname'] = uname.text;
                              request.fields['pass'] = pass.text;
                              request.fields['cpass'] = cpass.text;
                              request.fields['email'] = email.text;
                              request.fields['mob'] = mobile.text;
                              request.fields['birthdate'] = dob.text;
                              request.fields['city'] = selectedValue.toString();
                              request.fields['gender'] = selected.toString();
                              var streamedResponse = await request.send();
                              var response = await http.Response.fromStream(streamedResponse);
                              print(response.statusCode);
                              if (response.statusCode == 200) {
                               print(request.fields);
                               print(response.body);
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
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>csc()));
                                            },
                                            child: Text('Okk'))
                                      ]);
                                }
                              } else {
                                Get.defaultDialog(
                                  title: 'Invalid Input',
                                  middleText: 'Try Again',middleTextStyle: TextStyle(fontSize: 17,color: Colors.red,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
                                  titlePadding: EdgeInsets.only(top: 30),
                                  titleStyle: TextStyle(fontSize: 20,color: Colors.red,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                );

                               // print('something went wrong');
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
}
