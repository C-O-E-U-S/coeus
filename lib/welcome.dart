import 'dart:io';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'main.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key, required this.cameran});
  final cameran;
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  double? h = 50;
  late TextEditingController _controller;
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedfile;
  bool isLoading = false;
  File? fileToDisplay;
  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpeg'],
        allowMultiple: false,
      );
      if (result != null) {
        _fileName = result!.files.first.name;
        pickedfile = result!.files.first;
        // fileToDisplay = File(pickedfile!.path!);
      }
      print("File name $_fileName");
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text("Welcome to C.O.E.U.S"),
      // ),
      body: Stack(
        children: [
          Positioned(
              width: MediaQuery.of(context).size.width * 1.5,
              bottom: 200,
              left: 100,
              child: Image.asset('RiveAsset/Spline.png')),
          Positioned(
              child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
          )),
          RiveAnimation.asset(
            'RiveAsset/shapes.riv',
          ),
          Positioned(
              child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 30,
              sigmaY: 30,
            ),
            child: SizedBox(
                // height: 10,
                ),
          )),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Padding(
              padding: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.width) * 1 / 10,
                  right: (MediaQuery.of(context).size.width) * 1 / 10),
              child: TextField(
                onTap: () {
                  setState(() {
                    h = 130;
                  });
                },
                controller: _controller,
                decoration: InputDecoration(
                    // labelText: 'Type it out',
                    hintText: 'Type it out'),
                onSubmitted: (String value) async {
                  setState(() {
                    h = 50;
                  });
                  if (value != "") {
                    await showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Your Prompt'),
                          content: Text(value),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _controller.clear();
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  ;
                },
              ),
            ),
            SizedBox(
              height: h,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => TakePictureScreen(
                          camera: widget.cameran,
                        )));
              },
              icon: const Icon(
                Icons.camera_alt_rounded,
              ),
              label: const Text(
                'Take a picture from Camera',
                style: TextStyle(
                    fontFamily: "Mukta",
                    height: 1.2,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700),
              ), // <-- Text
            ),
            SizedBox(
              height: 50,
            ),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton.icon(
                    onPressed: () {
                      pickFile();
                    },
                    icon: const Icon(
                      Icons.file_upload,
                    ),
                    label: const Text(
                      'Upload from Gallery',
                      style: TextStyle(
                          fontFamily: "Mukta",
                          height: 1.2,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700),
                    ), // <-- Text
                  ),
            if (pickedfile != null)
              // SizedBox(
              //     width: 400, height: 300, child: Image.file(fileToDisplay!)),
              SizedBox(height: 40, width: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SafeArea(
                  child: Column(children: [
                    Text(
                      _fileName?.toString() ?? " ",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontFamily: 'Roboto'),
                    ),
                    _fileName == null
                        ? const SizedBox(
                            height: 10,
                            width: 10,
                          )
                        : Column(children: [
                            const SizedBox(
                              height: 40,
                              width: 10,
                            ),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.upload_file_sharp,
                              ),
                              label: Text('Submit'), // <-- Text
                            ),
                            SizedBox(
                              height: 50,
                            )
                          ])
                  ]),
                )
              ],
            ),
          ]),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(left: 32, top: 100),
            child: Column(
              children: [
                SizedBox(
                  width: 260,
                  child: Column(
                    children: [
                      Text(
                        "Welcome to Coeus",
                        style: TextStyle(
                            fontSize: 60,
                            fontFamily: "Mukta",
                            height: 1.2,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "Your solutions our Problem. Easy picture-oriented solution finder")
                    ],
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
