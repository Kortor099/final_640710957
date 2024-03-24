import 'dart:convert';

import 'package:flutter/material.dart';

import '../helpers/api_caller.dart';
import '../helpers/dialog_utils.dart';
import '../models/todo_item.dart';

import '../helpers/my_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoItem> _todoItems = [];

  final TextEditingController _textFieldController = TextEditingController();

  var _urlController = TextEditingController();
  var _subtitleController = TextEditingController();

  final apiCaller = ApiCaller();

  @override
  void initState() {
    super.initState();
    _loadTodoItems();
  }

  Future<void> _loadTodoItems() async {
    try {
      final data = await ApiCaller().get("todos");
      // ข้อมูลที่ได้จาก API นี้จะเป็น JSON array ดังนั้นต้องใช้ List รับค่าจาก jsonDecode()
      List list = jsonDecode(data as String);
      setState(() {
        _todoItems = list.map((e) => TodoItem.fromJson(e)).toList();
      });
    } on Exception catch (e) {
      showOkDialog(context: context, title: "Error", message: "ต้องกรอก URL และเลือกประเภทเว็บ", url: '', description: '', type: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Webby Fondue'),
            const SizedBox(height: 5.0), 
            const Text('ระบบรายงานเว็บเลวๆ', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    ),
  ),
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('* ต้องกรอกข้อมูล'),
            SizedBox(height: 10.0),
            MyTextField(
              controller: _urlController,
              hintText: 'URL *',
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 10.0),
            MyTextField(
              controller: _subtitleController,
              hintText: 'รายละเอียด',
              keyboardType: TextInputType.text,
            ),

            const SizedBox(height: 24.0),

            Text('ระบุประเภทเว็บเลว *'),
            // ปุ่มทดสอบ POST API
            ElevatedButton(
              onPressed: _handleApiPost,
              child: const Text('Test POST API'),
            ),

            const SizedBox(height: 8.0),

            // ปุ่มทดสอบ OK Dialog
            ElevatedButton(
              onPressed: _handleShowDialog,
              child: const Text('Show OK Dialog'),
            ),

            
          ],
        ),
      ),
    );
  }

  Future<void> _handleApiPost() async {
    try {
      final data = await ApiCaller().post(
        "todos",
        params: {
          "id": "gambling",
          "title": "เว็บพนัน",
          "subtitle": "การพนัน แทงบอล และอื่นๆ",
          "image": "/images/webby_fondue/gambling.jpg"
        },
      );
      // API นี้จะส่งข้อมูลที่เรา post ไป กลับมาเป็น JSON object ดังนั้นต้องใช้ Map รับค่าจาก jsonDecode()
      Map map = jsonDecode(data);
      String text =
          'ส่งข้อมูลสำเร็จ\n\n - id: ${map['id']} \n - id: ${map['id']} \n - title: ${map['title']} \n - subtitle: ${map['subtitle']} \n - image: ${map['image']}';
      showOkDialog(context: context,
    title: "Success",
    message: text,
    url: 'URL value',
    description: 'Description value',
    type: 'Type value',);
    } on Exception catch (e) {
      showOkDialog(context: context, title: "Error", message: e.toString(), url: '', description: '', type: '');
    }
  }

  Future<void> _handleShowDialog() async {
    await showOkDialog(
      context: context,
      title: "Success",
      message: "This is a message",
      url: 'URL value',
      description: 'Description value',
      type: 'Type value',
    );
  }
}
