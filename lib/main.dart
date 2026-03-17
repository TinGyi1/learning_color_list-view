import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Material App Bar')),
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int count = 0;
  List colorLst = [];

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  void changeColor(Color color) {
    pickerColor = color;
    setState(() {});
  }

  void showdialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Pick a Color"),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              currentColor = pickerColor;
              colorLst.add(pickerColor);
              setState(() {});
              Navigator.of(context).pop();
            },
            child: Text("Choice Color"),
          ),
        ],
      ),
    );
  }

  Widget viewColorBox({required int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: colorLst[index],
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Row(
          spacing: 180,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text("Color $index", style: TextStyle(color: Colors.white)),
            ),
            IconButton(
              onPressed: () {
                colorLst.removeAt(index);
                setState(() {});
              },
              icon: Icon(Icons.remove,
              color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Rendom Colors click",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: colorLst.isEmpty ? Colors.grey : colorLst[count],
            shape: BoxShape.circle,
            border: Border.all(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (colorLst.isEmpty) return;
                  count++;
                  if (count >= colorLst.length) {
                    count = 0;
                  }
                  setState(() {});
                },
                child: Text("Serial"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (colorLst.isEmpty) return;
                  int rdnC;
                  Random rdm = Random();
                  do {
                    rdnC = rdm.nextInt(colorLst.length);
                    debugPrint("Random Number :$rdnC");
                  } while (count == rdnC);
                  count = rdnC;
                  debugPrint("Result : $count");

                  setState(() {});
                },
                child: Text("Random"),
              ),
              ElevatedButton(onPressed: showdialog, child: Text("Pick Color")),
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: colorLst.length,
            itemBuilder: (context, index) => viewColorBox(index: index),
          ),
        ),
      ],
    );
  }
}
