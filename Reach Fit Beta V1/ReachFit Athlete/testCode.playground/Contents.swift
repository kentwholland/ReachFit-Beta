//: Playground - noun: a place where people can play

import UIKit

func <=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 <= rhs.timeIntervalSince1970
}
func >=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 >= rhs.timeIntervalSince1970
}
func >(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 > rhs.timeIntervalSince1970
}
func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 < rhs.timeIntervalSince1970
}
func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 == rhs.timeIntervalSince1970
}

let date0 = NSDate(timeIntervalSince1970: 0)
let date1 = NSDate(timeIntervalSince1970: 0)
let date2 = NSDate(timeIntervalSince1970: 1839203982)
let date3 = NSDate(timeIntervalSince1970: 1339203982)

date1 < date2 // true
date0 == date1 // true
date3 > date2 // false

var hello: [String] = ["hello", "two"]
find(hello, "hello")
