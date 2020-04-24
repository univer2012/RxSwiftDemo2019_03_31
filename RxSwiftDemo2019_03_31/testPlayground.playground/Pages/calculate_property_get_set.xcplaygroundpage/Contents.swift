//: [Previous](@previous)

import UIKit

//:来自：[Swift - 类的计算属性（使用get和set来间接获取/改变其他属性的值）](https://www.hangge.com/blog/cache/detail_521.html)


//class Calcuator {
//    var a: Int = 1
//    var b: Int = 1
//
//    var sum: Int {
//        get {
//            return a + b
//        }
//        set(val) {
//            b = val - a
//        }
//    }
//}




class Calcuator {
    var a: Int = 1
    var b: Int = 1

    var sum: Int {
        get {
            return a + b
        }
        set {
            b = newValue - a
        }
    }
}



//class Calcuator {
//    var a: Int = 1
//    var b: Int = 1
//
//    var sum: Int {
//        get {
//            return a + b
//        }
//    }
//}

let cal = Calcuator();
print(cal.sum)      //打印：2
cal.sum = 5
print(cal.b)        //打印：4


//: [Next](@next)
