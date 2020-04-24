//: [Previous](@previous)

import Foundation
import UIKit

//来自：[Swift - 文件，文件夹操作大全](https://www.hangge.com/blog/cache/detail_527.html)

#if false
//MARK: 1，遍历一个目录下的所有文件
///（1）首先我们获取用户文档目录路径
let manager = FileManager.default
let urlForDocument = manager.urls(for: .documentDirectory, in:.userDomainMask)
let url = urlForDocument[0] as URL
print(url)


///2）对指定路径执行浅搜索，返回指定目录路径下的文件、子目录及符号链接的列表
let contentsOfPath = try? manager.contentsOfDirectory(atPath: url.path)
print("contentsOfPath: \(contentsOfPath)")


///（3）类似上面的，对指定路径执行浅搜索，返回指定目录路径下的文件、子目录及符号链接的列表
let contentsOfURL = try? manager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
print("contentsOfURL: \(contentsOfURL)")


///4）深度遍历，会递归遍历子文件夹（但不会递归符号链接）
let enumeratorAtPath = manager.enumerator(atPath: url.path)
print("enumeratorAtPath: \(enumeratorAtPath?.allObjects)")


///（5）类似上面的，深度遍历，会递归遍历子文件夹（但不会递归符号链接）
let enumeratorAtURL = manager.enumerator(at: url, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles, errorHandler: nil)
print("enumeratorAtURL: \(enumeratorAtURL?.allObjects)")

///（6）深度遍历，会递归遍历子文件夹（包括符号链接，所以要求性能的话用enumeratorAtPath）
let subPaths = manager.subpaths(atPath: url.path)
print("subPaths: \(subPaths)")
#endif


//MARK: 2，判断文件或文件夹是否存在
//let fileManager = FileManager.default
//let filePath: String = NSHomeDirectory() + "/Documents/univer2012.txt"
//let exist = fileManager.fileExists(atPath: filePath)




//MARK: 3，创建文件夹
///方式1：
//let myDirectory: String = NSHomeDirectory() + "/Documents/myFolder/Files"
//let fileManager = FileManager.default
//
////withIntermediateDirectories为true，表示路径之间如果有不存在的文件夹都会创建
//try! fileManager.createDirectory(atPath: myDirectory, withIntermediateDirectories: true, attributes: nil)


///方式2：
#if false
func createFolder(name: String, baseUrl: NSURL) {
    let manager = FileManager.default
    let folder = baseUrl.appendingPathComponent(name, isDirectory: true)
    print("文件夹：\(folder)")
    let exist = manager.fileExists(atPath: folder!.path)
    if !exist {
        try! manager.createDirectory(atPath: folder!.path, withIntermediateDirectories: true, attributes: nil)
    }
}

//在文档目录下新建folder目录
let manager = FileManager.default
let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
let url = urlForDocument[0] as NSURL
createFolder(name: "folder", baseUrl: url)
#endif


//MARK: 4，将对象写入文件
///（1）把String保存到文件
#if false
let filePath: String = NSHomeDirectory() + "/Documents/univer2012.txt"
let info = "欢迎来到univer2012.com"
try! info.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
#endif

///（2）把图片保存到文件路径下
//let filePath: String = NSHomeDirectory() + "/Documents/univer2012.png"
//let image = UIImage(named: "apple.png")
//if let data: Data = image?.pngData() {
//    try? data.write(to: URL(fileURLWithPath: filePath))
//}


///（3）把NSArray保存到文件路径下
#if false
let array = NSArray(objects: "aaa", "bbb", "ccc")
let filePath: String = NSHomeDirectory() + "/Documents/array.plist"
array.write(toFile: filePath, atomically: true)
#endif


///（4）把NSDictionary保存到文件路径下
#if false
let dictionary: NSDictionary = ["Gold": "1st Place", "Silver": "2nd Place"]
let filePath: String = NSHomeDirectory() + "/Documents/dictionary.plist"
try! dictionary.write(toFile: filePath, atomically: true)
#endif


//MARK: 5，创建文件
#if false
func createFolder(name: String, fileBaseUrl: URL) {
    let manager = FileManager.default
    
    let file = fileBaseUrl.appendingPathComponent(name)
    print("文件夹：\(file)")
    let exist = manager.fileExists(atPath: file.path)
    if !exist {
        let data = Data(base64Encoded: "aGVsbG8gd29ybGQ=", options: .ignoreUnknownCharacters)
        let createSuccess = manager.createFile(atPath: file.path, contents: data, attributes: nil)
        print("文件创建结果： \(createSuccess)")
    }
}

//在文档目录下新建test.txt文件
let manager = FileManager.default
let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
let url = urlForDocument[0]
createFolder(name: "folder/new.txt", fileBaseUrl: url)
#endif


//MARK: 6，复制文件
//方法1
//let fileManager = FileManager.default
//let homeDirectory = NSHomeDirectory()
//let scrUrl = homeDirectory + "/Documents/univer2012.txt"
//let toUrl = homeDirectory + "/Documents/copyed.txt"
//try! fileManager.copyItem(atPath: scrUrl, toPath: toUrl)

//（2）方法2
#if false
//定位到用户文档目录
let manager = FileManager.default
let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
let url = urlForDocument[0]

//将test.txt文件拷贝到文档目录根目录下的copyed.txt文件
let srcUrl = url.appendingPathComponent("test1.txt")
let toUrl = url.appendingPathComponent("copyed1.txt")

try! manager.copyItem(at: srcUrl, to: toUrl)
#endif


//MARK: 7，移动文件
#if false
//（1）方法1 (要先确保该目录下有`\moved\` 这个文件目录，不然会崩溃)
//注意：
//1、要先确保该目录下有`\moved\` 这个文件目录，不然会崩溃
//2、要确保`\moved\` 目录下没有`univer2012.txt`文件，否则会崩溃

let fileManager = FileManager.default
let homeDirectory = NSHomeDirectory()
let srcUrl = homeDirectory + "/Documents/univer2012.txt"
let toUrl = homeDirectory + "/Documents/moved/univer2012.txt"
try? fileManager.moveItem(atPath: srcUrl, toPath: toUrl)
#endif


//（2）方法2
#if false
//注意：
//1、要确保目标目录存在，且没有`copyed2.txt`文件，否则移动失败，
//定位到用户文档目录
let manager = FileManager.default
let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
let url = urlForDocument[0]

let srcUrl = url.appendingPathComponent("test1.txt")
let toUrl = url.appendingPathComponent("copyed2.txt")
// 移动srcUrl中的文件（test1.txt）到toUrl中（copyed.2txt）
try? manager.moveItem(at: srcUrl, to: toUrl)
#endif


#if false
//MARK:8，删除文件
//（1）方法1
let fileManager = FileManager.default
let homeDirectory = NSHomeDirectory()
let srcUrl = homeDirectory + "/Documents/moved/univer2012.txt"
try? fileManager.removeItem(atPath: srcUrl)



//（2）方法2
//定位到用户文档目录
let manager = FileManager.default
let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
let url = urlForDocument[0]

let toUrl = url.appendingPathComponent("copyed.txt")
// 删除文档根目录下的toUrl路径的文件（copyed.txt文件）
try? manager.removeItem(at: toUrl)
#endif


#if false
// 9，删除目录下所有的文件
//（1）方法1：获取所有文件，然后遍历删除 
let fileManager = FileManager.default
let myDirectory = NSHomeDirectory() + "/Documents/folder"
if let fileArray = fileManager.subpaths(atPath: myDirectory) {
    for fn in fileArray {
        try? fileManager.removeItem(atPath: myDirectory + "/\(fn)")
    }
}

//（2）方法2：删除目录后重新创建该目录
let fileManager = FileManager.default
let myDirectory = NSHomeDirectory() + "/Documents/folder"
try? fileManager.removeItem(atPath: myDirectory)
try? fileManager.createDirectory(atPath: myDirectory, withIntermediateDirectories: true, attributes: nil)
#endif


#if false
//MARK: 10，读取文件
let manager = FileManager.default
let urlForDocDirectory = manager.urls(for: .documentDirectory, in: .userDomainMask)
let docPath = urlForDocDirectory[0]
let file = docPath.appendingPathComponent("test.txt")

//方法1
let readHandler = try? FileHandle(forReadingFrom: file)
if let data = readHandler?.readDataToEndOfFile() {
    let readString = String(data: data, encoding: String.Encoding.utf8)
    print("文件内容： \(readString)")
}

//方法2
if let data2 = manager.contents(atPath: file.path) {
    let readString2 = String(data: data2, encoding: String.Encoding.utf8)
    print("文件内容2： \(readString2)")
}
#endif



//MARK: 11，在任意位置写入数据
#if false
let manager = FileManager.default
let urlForDocDirectory = manager.urls(for: .documentDirectory, in: .userDomainMask)
let docPath = urlForDocDirectory[0]
let file = docPath.appendingPathComponent("test.txt")

let string = "添加一些文字到文件末尾"
if let appendedData = string.data(using: String.Encoding.utf8, allowLossyConversion: true),
    let writeHandler = try? FileHandle(forWritingTo: file) {
    
    writeHandler.seekToEndOfFile()
    writeHandler.write(appendedData)
}
#endif


//MARK:12，文件权限判断
#if false
let manager = FileManager.default
let urlForDocDirectory = manager.urls(for: .documentDirectory, in: .userDomainMask)
let docPath = urlForDocDirectory[0]
let file = docPath.appendingPathComponent("test.txt")

let readable = manager.isReadableFile(atPath: file.path)
print("可读： \(readable)")
let writeable = manager.isWritableFile(atPath: file.path)
print("可写： \(writeable)")
let executable = manager.isExecutableFile(atPath: file.path)
print("可执行： \(executable)")
let deleteable = manager.isDeletableFile(atPath: file.path)
print("可删除： \(deleteable)")
#endif



//MARK: 13，获取文件属性（创建时间，修改时间，文件大小，文件类型等信息）
#if false
let manager = FileManager.default
let urlForDocDirectory = manager.urls(for: .documentDirectory, in: .userDomainMask)
let docPath = urlForDocDirectory[0]
let file = docPath.appendingPathComponent("test.txt")

 //结果为[FileAttributeKey : Any]类型
if let attributes = try? manager.attributesOfItem(atPath: file.path) {
    //print("attributes: \(attributes)")
    print("创建时间：\(attributes[FileAttributeKey.creationDate])")
    print("修改时间：\(attributes[FileAttributeKey.modificationDate])")
    print("文件大小：\(attributes[FileAttributeKey.size])")
}
#endif



//MARK:14，文件/文件夹比较
#if false
let manager = FileManager.default
let urlForDocDirectory = manager.urls(for: .documentDirectory, in: .userDomainMask)
let docPath = urlForDocDirectory[0]
let contents = try! manager.contentsOfDirectory(atPath: docPath.path)

//下面比较用户文档中前面两个文件是否内容相同（该方法也可以用来比较目录）
let count = contents.count
if count > 1 {
    let path1 = docPath.path + "/" + (contents[0] as String)
    let path2 = docPath.path + "/" + (contents[1] as String)
    let equal = manager.contentsEqual(atPath: path1, andPath: path2)
    print("path1: \(path1)")
    print("path2: \(path2)")
    print("比较结果: \(equal)")
}
#endif

//: [Next](@next)
