//
//  main.swift
//  CommonLine
//
//  Created by Jingfu Li on 2025/2/5.
//

import Foundation

protocol Testable {
    func test() throws
}

struct RegexTest: Testable {
    func test() throws {
        let annotation = #"<e type="@" uid="2123809381" name="James" /><e type="@" uid="2123809381" name="Lo" />"#
        
        let pattern = "<e.[^<>]*\\/>"
        let regex = try NSRegularExpression(pattern: pattern)
        
        let matches = regex.matches(in: annotation, range: NSRange(location: 0, length: annotation.utf16.count))
        
        let result = matches.reduce("") { result, match in
            let matchString = (annotation as NSString).substring(with: match.range)
            return result.isEmpty ? matchString : result + " " + matchString
        }
        print(result)
    }
}

let list: [Testable] = [
    RegexTest()
]

list.forEach { test in
    do {
        try test.test()
    } catch {
        print(error)
    }
}
