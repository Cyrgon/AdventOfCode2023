//
//  8.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-08.
//

import Foundation

func day8a() {
    let input = readRegExLetters(name: "8")
    
    var map: [String: [String]] = [:]
    let sequence = input[0][0]
    
    for i in 2 ..< input.count {
        map[input[i][0]] = [input[i][1], input[i][2]]
    }
    
    var c = 0
    var next = "AAA"
    while(true) {
        let step = sequence[c % sequence.count]
        if step == "L" {
            next = map[next]![0]
        } else {
            next = map[next]![1]
        }
        
        c += 1
        
        if next == "ZZZ" {
            print(c)
            break
        }
    }
}

func day8b() {
    let input = readRegExLetters(name: "8")
    
    var map: [String: [String]] = [:]
    let sequence = input[0][0]
    
    for i in 1 ..< input.count {
        map[input[i][0]] = [input[i][1], input[i][2]]
    }
    var next: [String] = []
    for m in map.keys.sorted() {
        if m.last == "A" {
            next.append(m)
        }
    }

    let start = next
    var result: [String: [Int]] = [:]
    for i in 0 ..< next.count {
        var c = 0
        var res = 0
        while(true) {
            let step = sequence[c % sequence.count]
            
            if step == "L" {
                next[i] = map[next[i]]![0]
            } else {
                next[i] = map[next[i]]![1]
            }
            c += 1
            
            if next[i].last == "Z" {
                if res > 0 {
                    result[start[i]] = [res, c - res]
                    break
                }
                res = c
            }
        }
    }
    print(result)
    print(result.values.reduce(1, { Math.lcm($0, $1[0]) }))
}
