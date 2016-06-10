//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var num: Int = 0

func test() {
    let initialBits: UInt8 = 0b00001111
    let invertedBits = ~initialBits // 11110000
    print(invertedBits)
    
    var unsignedOverflow = UInt8.max
    unsignedOverflow = unsignedOverflow &+ 1 // now is 0
}
