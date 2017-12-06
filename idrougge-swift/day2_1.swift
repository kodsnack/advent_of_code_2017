import Foundation

let rows = try! String(contentsOfFile: FileManager.default.currentDirectoryPath
+"/day2.txt")
    .components(separatedBy: .newlines)
    .map{$0.components(separatedBy: .whitespaces)
        .flatMap(Int.init)
        .sorted()}
let checksum = rows.reduce(0){val,row in val + row.last! - row.first!}
print(checksum)
