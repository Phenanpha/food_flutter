/*

import 'package:flutter/services.dart';
import 'package:public_toilets/model/toilet.dart';

class ToiletRepository { //แหล่งเก็บข้อมูลทั้งหมด
  /*static List<Toilet> toilets = [
    Toilet(name: 'ห้องน้ำ 1', point: 4.1, distance: 150.0),
    Toilet(name: 'ห้องน้ำ 2', point: 4.5, distance: 50.0),
    Toilet(name: 'ห้องน้ำ 3', point: 3.7, distance: 350.0),
    Toilet(name: 'ห้องน้ำ 4', point: 4.0, distance: 220.0),
    Toilet(name: 'ห้องน้ำ 5', point: 4.8, distance: 550.0),
    Toilet(name: 'ห้องน้ำ 6', point: 2.5, distance: 10.0),
  ];*/


  static List <Toilet> toilets = [];
                       // อ่านไฟล์ toilets.json ที่จริงต้องดึง api มา
  static Future<String> readJsonData(String path) async { //load ข้อมูลจากไฟล์ ระบุpath
    // read json file
    return await rootBundle.loadString(path);

  }
}
*/

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:food_flutter/models/food.dart';


import '../services/api_caller.dart';


//เป็นแหล่งที่ไว้พักข้อมูล
// ดึงข้อมูล จาก api มาพักเก็บไว้ เพื่อส่งต่อไปให้กับ ui อีกทีนึง
//หน้า home_page จะมา call กับ class ToiletRepository
class foodRepository { // class ที่ทำหน้าที่ ดึงข้อมูล จาก call api
  Future<List<food>> getfood() async {
    try { //call ไปที่ api caller ซึ่งมี method get ส่ง endpoint ไป
      var result = await ApiCaller().get('food?_embed=reviews'); //ออกสอบ ใส่ endpoint  //เรียก api จะได้ string ที่เป็น json
      List list = jsonDecode(result); // แปลงจาก string ของ json ที่ได้จากการ call api ให้เปนโครงสร้าง map ในภาษา dart //array ของ json จะเป้น list ของ dart และ object ของ json เป้น map ของ dart
      List<food> foodList =
      list.map<food>((item) => food.fromJson(item)).toList(); // แปลงจากlist ของ object map เป็น list ของ object  toliet  // แปลง map แต่ละก้อนที่อยู่ใน list ไปเป็น object toilet ที่อยู่ใน list แทน
      return foodList; //สิ่งที่ return จาก getToilets() ออกไป จะกลายเป็น list ของ toilet และใน toilet จะมี list ของ review ด้วย เอาไปใช้ใน ui ได้แล้ว
    } catch (e) {
      // TODO:
      rethrow;
    }
  }


  Future<void> addfood( // เพิ่มข้อมูลห้องน้ำ
          {required String name, required double distance}) async {
    try {
      var result = await ApiCaller() // call ไปที่ api caller ใช้ post
          .post('food', params: {'name': name, 'distance': distance}); // เตรียมพารามิเตอร์ 2 ตัว คือ name distance กรอกข้อมูล name distance
    } catch (e) {
      // TODO:
      rethrow;
    }
  }
}
