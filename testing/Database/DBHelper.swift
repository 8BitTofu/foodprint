import SwiftyJSON
import Foundation
// import SQLite3


class DBHelper
{
    var file_pointers = [String: Int]()
    var db: dbReader
        
    init()
    {
        func retrieve_fps() -> Dictionary<String, Int>
        {
            var post = [String: Int]()
            if let path = Bundle.main.path(forResource: "fp", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                    let jsonObj = try JSON(data: data)
                    for (key, value) in  jsonObj
                    {
                        post[key] = value.intValue
                    }
                } catch let error {
                    print("parse error: \(error.localizedDescription)")
                }
            } else {
                print("Invalid filename/path.")
            }
            return post
        }
        
        self.file_pointers = retrieve_fps()
        print("fp: \(UInt64(file_pointers["Sweet Banana Bread"]!))")
        
        let pathname = Bundle.main.path(forResource: "allrecipes", ofType: "json")

        self.db = dbReader(path: pathname!)!
        for _ in 1...10{
            if let line = db.nextLine() {
                print("line: \(line)")
            }
        }
        
        let file: FileHandle? = FileHandle(forReadingAtPath: pathname!)

        if file == nil {
            print("File open failed")
        } else {
            file?.seek(toFileOffset: UInt64(file_pointers["Sweet Banana Bread"]!))
            let databuffer = file?.readData(ofLength: 100)
            let str = String(decoding: databuffer!, as: UTF8.self)
            print("STRING \(str)")
            file?.closeFile()
        }
    }
}
