import 'dart:io';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key, required this.cameran});
  final cameran;
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to C.O.E.U.S"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
            label: const Text('Take a picture from Camera'), // <-- Text
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
                  label: const Text('Upload from Galary'), // <-- Text
                ),
          if (pickedfile != null)
                // SizedBox(
                //     width: 400, height: 300, child: Image.file(fileToDisplay!)),
                SizedBox(height: 40, width: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: [
                Text(
                  _fileName?.toString() ?? " ",
                  style: const TextStyle(
                      color: Colors.grey, fontSize: 20, fontFamily: 'Roboto'),
                ),
                _fileName == null
                    ? const SizedBox(
                        height: 30,
                        width: 10,
                      )
                    : Column(children: [
                        const SizedBox(
                          height: 30,
                          width: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.upload_file_sharp,
                          ),
                          label: Text('Submt'), // <-- Text
                        ),
                      ])
              ])
            ],
          ),
        ],
      )),
    );
  }
}