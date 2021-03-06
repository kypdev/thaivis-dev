import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thaivis_dev/common/cus_btn.dart';

class UserRegister extends StatefulWidget {
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  Future<File> file;
  String base64Image;
  File tmpFile;

  // imageSource(source) async {
  //   final pickedFile = await picker.getImage(source: source);
  //   print('img: $pickedFile');
  //   print('pickedFile: $pickedFile');
  //   file = ImagePicker.pickImage(source: ImageSource.gallery);
  //   file = picker.getImage(source: source);
  // }

  // chooseImageSource() {
  //   print('camera: show modal');
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return Container(
  //           child: new Wrap(
  //             children: <Widget>[
  //               new ListTile(
  //                 leading: new Icon(Icons.camera_alt),
  //                 title: new Text('กล้อง'),
  //                 onTap: () {
  //                   debugPrint('camera');

  //                   Navigator.pop(context);
  //                 },
  //               ),
  //               new ListTile(
  //                 leading: new Icon(Icons.photo_library),
  //                 title: new Text('คลังรูปภาพ'),
  //                 onTap: () {
  //                   debugPrint('gallery');
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

  chooseImageSource() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.camera_alt),
                  title: new Text('กล้อง'),
                  onTap: () {
                    setState(() {
                      file = ImagePicker.pickImage(source: ImageSource.camera);
                    });
                    Navigator.pop(context);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('คลังรูปภาพ'),
                  onTap: () {
                    setState(() {
                      file = ImagePicker.pickImage(source: ImageSource.gallery);
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      // future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child:
                // CircleAvatar(
                //     backgroundColor: Colors.blue,
                //     radius: 75.0,
                //     child: CircleAvatar(
                //       radius: 70.0,
                //       backgroundColor: Color(0XFFFFFFFF),
                //       child: Padding(
                //         padding: const EdgeInsets.all(16.0),
                //         child: Image.file(
                //           snapshot.data,
                //           color: Colors.grey,
                //         ),
                //       ),
                //     ),
                //   ),
            //     Image.file(
            //   snapshot.data,
            //   fit: BoxFit.fill,
            // ),
            Text('img selected'),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return Stack(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 75.0,
                child: CircleAvatar(
                  radius: 70.0,
                  backgroundColor: Color(0XFFFFFFFF),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/user.png',
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 4.0,
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    child: ClipOval(
                      child: Material(
                        color: Color(0xff5663FF),
                        child: InkWell(
                          onTap: (){
                            chooseImageSource();
                          },
                          child: SizedBox(
                            width: 56,
                            height: 56,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                          
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0XFFFFFFFF),
          appBar: AppBar(
            title: Text('ลงทะเบียนบุคคลทั่วไป'),
            centerTitle: true,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  cusBtn(
                    action: () {
                      print('test: $file');
                    },
                    text: 'test',
                    color: Colors.lightBlue,
                  ),
                  showImage(),
                ],
              ),
            ),
          )),
    );
  }
}
