//
//  main.swift
//  SwiftDemo
//
//  Created by Jingfu Li on 2024/7/4.
//

import Foundation

/// 可调用
/// Adder(firstValue: 20, secondValue: 32)()
struct Adder<T> {
    let firstValue: T
    let secondValue: T

    func callAsFunction() -> T where T: AdditiveArithmetic {
        firstValue + secondValue
    }

    func callAsFunction() async -> T where T: AdditiveArithmetic {
        firstValue + secondValue
    }
}

/// https://github.com/swiftlang/swift-evolution/blob/main/proposals/0216-dynamic-callable.md
@dynamicCallable
struct DynamicCallable {
    func dynamicallyCall(withArguments args: [Int]) -> Int { return args.count }

    //func dynamicallyCall(withKeywordArguments args: [String]) -> String { return args.last ?? "" }
}

let dynamicCallable = DynamicCallable()
print(dynamicCallable(1, 2, 3, 1, 2, 3))

/// https://github.com/swiftlang/swift-evolution/blob/main/proposals/0195-dynamic-member-lookup.md
@dynamicMemberLookup
struct MemberLookup {
    subscript(dynamicMember member: String) -> String {
        get {
            return "unknow"
        }
        set {
        }
    }

    subscript(dynamicMember member: Int) -> String {
        get {
            return "unknow"
        }
        set {
        }
    }
}

var memberLookup = MemberLookup()
memberLookup.hi = "Hi"
print(memberLookup.hi)
