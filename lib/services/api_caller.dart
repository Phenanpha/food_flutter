import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//อาจารย์ให้ copy file นี้ไปใช้ได้เลย

//class ที่ทำหน้าที่ call api
class ApiCaller { //call ไปที่ api จริง
  static const baseUrl = 'http://localhost:3000/'; // ออกสอบใส่ url ให้ถูกต้อง
  static final _dio = Dio(BaseOptions(responseType: ResponseType.plain)); //ใช้ dio ทำการ get api ตาม path ที่ระบุ

  // มี 2 method คือ get คือ ดึงข้อมูลจาก api มาแสดงผลในแอป , post คือ ส่งข้อมูลจากแอปไปที่ api เช่น กรอกฟอม
  Future<String> get(String endpoint, {Map<String, dynamic>? params}) async { //ส่ง endpoint มา
    try { //try catch สอบไม่จำเปนต้องทำ
      final response =
      await _dio.get('$baseUrl/$endpoint', queryParameters: params);
      debugPrint(response.data.toString());
      return response.data.toString(); // String ธรรมดาเลย //ส่งจะString ธรรมดา ไปให้ class ToiletRepository ทำการตั้ง model toilet
    } catch (e) {
      // TODO:
      rethrow;
    }
  }
  // post ไว้บันทีึกข้อมูลลง api
  Future<String> post(String endpoint,
      {required Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.post('$baseUrl/$endpoint', data: params);
      debugPrint(response.data.toString());
      return response.data.toString();
    } catch (e) {
      // TODO:
      rethrow;
    }
  }
}
