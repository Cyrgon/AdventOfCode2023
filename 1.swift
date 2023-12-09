//
//  1.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-01.
//

import Foundation

func day1a() {
    let digits = "1234567890"
    let lines: [String] = readTextLines(name: "1")
    
    var sum = 0
    for line in lines {
        guard let first = line.first(where: { digits.contains($0) }),
        let last = line.last(where: { digits.contains($0) }) else {
            fatalError()
        }
        sum += Int("\(first)\(last)")!
        
    }
    
    print(sum)
}

func day1b() {
    let digits = "1234567890"
    let digitsSpelled = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    
    let lines: [String] = readTextLines(name: "1")
    
    var sum = 0
    for line in lines {
        var firstIndex = line.firstIndex(where: { digits.contains($0) })
        var lastIndex = line.reversed().firstIndex(where: { digits.contains($0) })
        
        var first: String?
        var last: String?
        if let firstIndex {
            first = String(line[firstIndex])
        }
        if let lastIndex {
            last = String(line.reversed()[lastIndex])
        }
        
        for i in 1 ... digitsSpelled.count {
            let spelled = digitsSpelled[i - 1]
            if let range = line.firstRange(of: spelled) {
                if firstIndex == nil || range.lowerBound < firstIndex! {
                    firstIndex = range.lowerBound
                    first = "\(i)"
                }
            }
            
            if let range = line.reversed().firstRange(of: spelled.reversed()) {
                if lastIndex == nil || range.lowerBound < lastIndex! {
                    lastIndex = range.lowerBound
                    last = "\(i)"
                }
            }
        }
        
        sum += Int("\(first!)\(last!)")!
        
    }
    
    print(sum)
}

func day1Test() {
    let digits = ["1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "0": 0,
                  "one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9]
    let lines: [String] = readTextLines(name: "1")
    
    var sum = 0
    for line in lines {
        var res: [Int] = []
        for i in 0 ..< line.count {
            for digit in digits {
                if line[i...].starts(with: digit.key) {
                    res.append(digit.value)
                }
            }
        }
        sum += Int("\(res.first!)\(res.last!)")!
    }
    
    print(sum)
}
