//
//  4.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-04.
//

import Foundation

func day4a() {
    let numbers = readRegExNumbers(name: "4")
    
    var sum = 0
    for row in numbers {
        var rowSum = 0
        for n in row[11...] {
            if row[1...10].contains(n) {
                if rowSum == 0 {
                    rowSum = 1
                } else {
                    rowSum *= 2
                }
            }
        }
        sum += rowSum
        rowSum = 0
    }
    
    print(sum)
}

func day4b() {
    let numbers = Array(readRegExNumbers(name: "4").reversed())
    
    var map: [Int: Int] = [:]
    for row in numbers {
        var rowSum = 0
        for n in row[11...] {
            if row[1...10].contains(n) {
                rowSum += 1
            }
        }
        map[row[0]] = 1
        if rowSum > 0 {
            for i in (row[0] + 1 ... row[0] + rowSum).reversed() {
                map[row[0]]! += map[i]!
            }
        }
    }
    
    print(map.reduce(0, { $0 + $1.value }))
}
