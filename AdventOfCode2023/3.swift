//
//  3.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-03.
//

import Foundation

func day3a() {
    let lines = readTextLines(name: "3")
    var num = 0
    var toUse = false
    var sum = 0
    for y in 0 ..< lines.count {
        if num > 0 && toUse {
            sum += num
            num = 0
            toUse = false
        }
        for x in 0 ..< lines[0].count {
            if let v = Int(String(lines[y][x])) {
                for i in y - 1 ... y + 1 {
                    for j in x - 1 ... x + 1 {
                        if i < 0 || i >= lines.count || j < 0 || j >= lines[0].count {
                            continue
                        }
                        if lines[i][j] != "." && Int(String(lines[i][j])) == nil {
                            toUse = true
                        }
                    }
                }
                if num == 0 {
                    num = v
                } else {
                    num = num * 10 + v
                }
            } else if num > 0 && toUse {
                sum += num
                num = 0
                toUse = false
                
            } else {
                num = 0
            }
        }
    }
    if num > 0 && toUse {
        sum += num
        num = 0
        toUse = false
    }
    
    print(sum)
}

func day3b() {
    var map: [String: [Int]] = [:]
    let lines = readTextLines(name: "3")
    var num = 0
    var adjecent: Set<String> = []
    
    for y in 0 ..< lines.count {
        if !adjecent.isEmpty {
            for a in adjecent {
                if !map[a, default: []].contains(num) {
                    map[a, default: []].append(num)
                }
            }
        }
        num = 0
        adjecent = []
        for x in 0 ..< lines[0].count {
            if let v = Int(String(lines[y][x])) {
                for i in y - 1 ... y + 1 {
                    for j in x - 1 ... x + 1 {
                        if i < 0 || i >= lines.count || j < 0 || j >= lines[0].count {
                            continue
                        }
                        if lines[i][j] == "*" {
                            adjecent.insert("\(i),\(j)")
                        }
                    }
                }
                if num == 0 {
                    num = v
                } else {
                    num = num * 10 + v
                }
            } else if !adjecent.isEmpty {
                for a in adjecent {
                    if !map[a, default: []].contains(num) {
                        map[a, default: []].append(num)
                    }
                }
                num = 0
                adjecent = []
                
            } else {
                num = 0
            }
        }
    }
    if !adjecent.isEmpty {
        for a in adjecent {
            if !map[a, default: []].contains(num) {
                map[a, default: []].append(num)
            }
        }
        num = 0
        adjecent = []
    }
    
    print(map.values.reduce(0, {
        if $1.count == 2 {
            return $0 + $1[0] * $1[1]
        } else {
            return $0
        }
    }))
}
