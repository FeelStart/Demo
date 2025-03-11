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

class CommitInfo {
    let hash: Int
    let userId: Int

    init(hash: Int, userId: Int) {
        self.hash = hash
        self.userId = userId
    }
}

// https://medium.com/@devslaf/reference-counter-in-swift-98ce26cc2fa1
let firstCommit = CommitInfo(hash: 0xffee, userId: 1)

@objc class CommitInfoObject: NSObject {
    let _hash: Int
    let userId: Int

    init(hash: Int, userId: Int) {
        self._hash = hash
        self.userId = userId
    }
}

let firstCommitObject = CommitInfo(hash: 0xffee, userId: 1)
let firstCommitClass = CommitInfo.self

var memberLookup = MemberLookup()
memberLookup.hi = "Hi"
print(memberLookup.hi)

class Man {
    let name: String
    let age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    static let shared = Man(name: "", age: 18)
}

struct Woman {
}

let manS = Man.shared

var m = Man(name: "Link", age: 10)
let n = m.name
let a = m.age
let m1 = m
let m2 = m
let m3 = m
let m4 = m

var m0 = Man(name: "Li", age: 8)
let p = withUnsafePointer(to: &m0) { pointer in
    print(pointer)
}

print("end")

protocol Book {
    var kind: String { get }
}

