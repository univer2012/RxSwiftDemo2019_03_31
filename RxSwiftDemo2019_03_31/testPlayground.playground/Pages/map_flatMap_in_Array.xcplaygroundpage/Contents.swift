//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport


let numbers = [1,2,3,4]
let result = numbers.flatMap {$0 + 2}
print(result) //[3, 4, 5, 6]

let numbersCompound = [[1,2,3], [4,5,6]]
var res = numbersCompound.map { $0.map{$0 + 2} }
print(res)  //[[3, 4, 5], [6, 7, 8]]

var flatRes = numbersCompound.flatMap{ $0.map{ $0 + 2 } }
print(flatRes) //[3, 4, 5, 6, 7, 8]


let optionalArray: [String?] = ["AA", nil, "BB", "CC"]
var optionalResult = optionalArray.flatMap { $0 }
print(optionalResult)   //["AA", "BB", "CC"]
print(optionalArray)    //[Optional("AA"), nil, Optional("BB"), Optional("CC")]

print(optionalArray.map{ $0 })

var imageNames = ["test.png", "aa.png", "icon.png"]
imageNames.flatMap { UIImage(named: $0) }




