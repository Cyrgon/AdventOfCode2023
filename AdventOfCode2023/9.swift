//
//  9.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-09.
//

import Foundation

func day9a() {
    let input = readRegExNumbers(name: "9")
    var sum = 0
    for line in input {
        var res: [[Int]] = [line]
        while(true) {
            var new: [Int] = []
            var prev: Int?
            for n in res.last! {
                guard let p = prev else {
                    prev = n
                    continue
                }
                
                new.append(n - p)
                prev = n
            }
            
            res.append(new)

            if new.allSatisfy({ $0 == 0 }) {
                break
            }
        }
        for i in stride(from: res.count - 1, through: 0, by: -1) {
            let c = res[i].count - 1
            let next: Int
            if i < res.count - 1 {
                next = res[i][c] + res[i + 1][c]
            } else {
                next = 0
            }
            if i == 0 {
                sum += next
            } else {
                res[i].append(next)
            }
        }
    }
    
    print(sum)
}

func day9b() {
    let input = readRegExNumbers(name: "9")
    var sum = 0
    for line in input {
        var res: [[Int]] = [line]
        while(true) {
            var new: [Int] = []
            var prev: Int?
            for n in res.last! {
                guard let p = prev else {
                    prev = n
                    continue
                }
                
                new.append(n - p)
                prev = n
            }
            
            res.append(new)

            if new.allSatisfy({ $0 == 0 }) {
                break
            }
        }
        for i in stride(from: res.count - 1, through: 0, by: -1) {
            let next: Int
            if i < res.count - 1 {
                next = res[i][0] - res[i + 1][0]
            } else {
                next = 0
            }
            if i == 0 {
                sum += next
            } else {
                res[i].insert(next, at: 0)
            }
        }
    }
    
    print(sum)
}

func day9aRec() {
    let input = readRegExNumbers(name: "9")
    var sum = 0
    for line in input {
        sum += next(line)
    }
    
    print(sum)
}

func day9bRec() {
    let input = readRegExNumbers(name: "9")
    var sum = 0
    for line in input {
        sum += next(line.reversed())
    }
    
    print(sum)
}

func next(_ line: [Int]) -> Int {
    if line.allSatisfy({ $0 == 0 }) {
        return 0
    } else {
        return line.last! + next(zip(line, line.dropFirst()).map { $1 - $0 })
    }
}
