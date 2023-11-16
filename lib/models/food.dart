import 'review.dart';
import 'package:collection/collection.dart';


class food {
  final String name;
  final double distance;
  final double averageRating; // ไม่ได้มาจาก json จะทำการคำนวนเอง
  final List<Review> reviews; // เอา list ของ review มาเก็บไว้ใน toilet ด้วย เพราะมีข้อมูล review อยู่ใน object toilet ทำตาม patten ของ api

  food({ // contructor ชื่อเดียวกับ class
    required this.name,
    required this.distance,
    required this.averageRating,
    required this.reviews,
  });
  // fromJson ตรงนี้ตั้งชื่อเป้นไรก้อได้
  //Map สามารถกำหนด key value ได้ ,คล้ายๆ array ที่เป็น index
  // <String, dynamic> กำหนด type ของ <key,value> จะมี key เป็น string และ value เป็น dynamic

  factory food.fromJson(Map<String, dynamic> json){ //รับค่า map ที่ได้จากการแปลงรูปแบบ json เป็น map แล้ว อยู่ในตัวแปรชื่อ json ลงใน object toilet
    List<Review> reviews = // เป็น list ของ review  //จะแปลง ฟิว json['reviews'] ที่เป็น list ของ map ให้เป็น list ของ object model review
    json['review'].map<Review>((item) => Review.fromJson(item)).toList(); // แปลง list review ของ map  ไปเป็น list ของ object review
    var averageRating = 0.0; //ถ้าไม่มี review ก้อจะให้เป็น 0
    if (reviews.isNotEmpty) { // check ว่ามี review รึยัง
      averageRating = reviews.map((review) => review.rating).average; // ต้อง import collection ถึงจะใช้ .average ได้
      // คำนวน averageRating
    }

    return food( // รีเทินค่าที่ได้เก็บข้อมูลที่รับมาใส่ลงในตัวแปร ของ model class toilet //return object toilet
      name: json['name'],// ต้องเขียนชื่อให้ตรงกับ api
      distance: json['distance'],
      averageRating: averageRating, //มาจากบรรทัด 30
      reviews: reviews, //json['reviews'].map<Review>((item) => Review.fromJson(item)).toList();
    ); // เอา object map ใส่เข้าไปใน object toilet

  }

}

//ข้อมูลที่เป็นกลุ่มก้อน collections in dart
//lists [] มี index ในการระบุลำดับก่อนหลัง
//sets{} ใน set ไม่มีลำดับ สนใจแค่ค่า ไม่ได้ลนใจลำดับใครมาก่อนมาหลังและจะเก็บข้อมูลที่ไม่ซ้ำเท่านั้น
// Maps{key : value}ช้อมูลแต่ละตัวที่ key ประจำตัวมันอยู่ ในภาษา dart key ใช้เปน type อะไรก้อได้ แต่ส่วนใหญ่และ json ใช้ string
//ใน json {ตรงนี้เรียกว่า object ที่ key ต้องเป๋น string เท่านั้น}