//
//  18.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-18.
//

import Foundation

func day18a() {
    let input = readTextLines(name: "18").map {
        let s = $0.split(separator: " ")
        return (s[0], Int(s[1])!)
    }
    
    var dug: Set<String> = []
    dug.insert(key(0,0))
    var x = 0
    var y = 0
    var dx = 0
    var dy = 0
    
    for line in input {
        switch line.0 {
        case "R":
            dx = 1
            dy = 0
            for xx in stride(from: x + dx, through: x + line.1 * dx, by: dx) {
                dug.insert(key(xx, y))
            }
        case "L":
            dx = -1
            dy = 0
            for xx in stride(from: x + dx, through: x + line.1 * dx, by: dx) {
                dug.insert(key(xx, y))
            }
        case "U":
            dx = 0
            dy = -1
            for yy in stride(from: y + dy, through: y + line.1 * dy, by: dy) {
                dug.insert(key(x, yy))
            }
        case "D":
            dx = 0
            dy = 1
            for yy in stride(from: y + dy, through: y + line.1 * dy, by: dy) {
                dug.insert(key(x, yy))
            }
        default:
            fatalError()
        }
        
        x = x + line.1 * dx
        y = y + line.1 * dy
    }
    
    
    for y in 0 ..< 10 {
        for x in 0 ..< 10 {
            if dug.contains(key(x, y)) {
                print("#", terminator: "")
            } else {
                print(".", terminator: "")
            }
        }
        print("")
    }
    
    var toFill: Set<String> = []
    toFill.insert(key(1, 1))
    
    while let next = toFill.first {
        toFill.remove(next)
        
        if dug.contains(next) {
            continue
        } else {
            dug.insert(next)
        }
        let n = rKey(next)
        toFill.insert(key(n.0 + 1, n.1))
        toFill.insert(key(n.0 - 1, n.1))
        toFill.insert(key(n.0, n.1 + 1))
        toFill.insert(key(n.0, n.1 - 1))
    }
    
    print(dug.count)
}

func key(_ x: Int, _ y: Int) -> String {
    return "\(x),\(y)"
}

func rKey(_ key: String) -> (Int, Int) {
    let s = key.split(separator: ",")
    return (Int(s[0])!, Int(s[1])!)
}

func day18b() {
    let input = readTextLines(name: "18").map {
        let s = $0.split(separator: "(#")
        return (s[1][5], Int(s[1][0 ... 4], radix: 16)!)
    }
    
    var points: [CGPoint] = []
    var x = 0
    var y = 0
    var dx = 0
    var dy = 0
    
    var lineArea = 1
    
    for line in input {
        switch line.0 {
        case "0", "R":
            dx = 1
            dy = 0
        case "2", "L":
            dx = -1
            dy = 0
        case "3", "U":
            dx = 0
            dy = -1
        case "1", "D":
            dx = 0
            dy = 1
        default:
            fatalError()
        }
        
        x = x + line.1 * dx
        y = y + line.1 * dy
        
        if dx >= 0 && dy >= 0 {
            lineArea += (line.1 * dx + line.1 * dy)
        }
        
        points.append(CGPoint(x: Double(x), y: Double(y)))
    }
    
    print(Int(Algorithms.area(points)) + lineArea)
    
}
