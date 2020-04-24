//: [Previous](@previous)

import Foundation
import UIKit


class Calcuator {
    var a: Int = 1
    private var b: Int = 1

    var sum: Int {
        get {
            return a + b
        }
        set {
            b = newValue - a
        }
    }
}
extension Calcuator {
    //计算型属性
    ///1、extension可以添加计算型属性。
    ///2、Swift 4及以上版本中，可以访问private属性。
    var multiplication: Int {
        get {
            return a * b
        }
        set {
            b = newValue / a
        }
    }
    
    //计算型静态属性
    static var div: Int {
        return 8 / 2
    }
    //计算型属性
    var subtraction: Int {
        return 4
    }
    
    //存储型属性
    ///报错：Extensions must not contain stored properties
    //var c:Int = 1
    
    //新的构造器
    convenience init(a:Int, b: Int) {
        self.init()
        self.a = a
        self.b = b
    }
    
}



//MARK: 给字符串String类添加下标脚本，支持索引访问
#if false
extension String {
    public subscript(start: Int, length: Int) -> String {
        get {
            let index1 = self.index(self.startIndex, offsetBy: start)
            let index2 = self.index(index1, offsetBy: length)
            return String(self[index1 ..< index2])
        }
        set {
            let tmp = self
            var s = ""
            var e = ""
            for (idx, item) in tmp.enumerated() {
                if idx < start {
                    s += "\(item)"
                }
                if idx >= start + length {
                    e += "\(item)"
                }
            }
            self = s + newValue + e
        }
    }
    
    public subscript(index: Int) -> String {
        get {
            return String(self[self.index(self.startIndex,offsetBy: index)])
        }
        
        set {
            let tmp = self
            self = ""
            for (idx, item) in tmp.enumerated() {
                if idx == index {
                    self += "\(newValue)"
                } else {
                    self += "\(item)"
                }
            }
        }
    }
}

var str = "univer2012.com"
print(str[11,3])
print(str[1])

str[11,3] = "COM"
str[0] = "U"

print(str[0,14])
#endif



extension Double {
    func mm() -> String {
        return "\(self/1)mm"
    }
    func cm() -> String {
        return "\(self/10)cm"
    }
    func dm() -> String {
        return "\(self/100)dm"
    }
    func m() -> String {
        return "\(self/1000)m"
    }
    func km() -> String {
        return "\(self/(1000 * 1000))km"
    }
}

let value = 2000000000.0
print(value.mm())
print(value.cm())
print(value.dm())
print(value.m())
print(value.km())






//: [Next](@next)
