//
//  6.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-07.
//

import Foundation

func day6a() {
    let input = readRegExNumbers(name: "6")
    print(input)
    var prod = 1
    for i in 0 ..< input[0].count {
        var ways = 0
        let time = input[0][i]
        let record = input[1][i]
        for speed in 0 ... time {
            let distance = speed * (time - speed)
            if distance > record {
                ways += 1
            }
        }
        print(ways)
        prod *= ways
    }
    
    print(prod)
}

func day6b() {
    let input = readRegExNumbers(name: "6").map { $0.map { String($0) } }.map { Int($0.joined())! }
    var ways = 0
    let time = input[0]
    let record = input[1]
    for speed in 0 ... time {
        if speed % 1000 == 0 {
            print(speed)
        }
        let distance = speed * (time - speed)
        if distance > record {
            ways += 1
        }
    }
    print(ways)
}
