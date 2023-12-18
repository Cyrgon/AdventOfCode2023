//
//  15.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-15.
//

import Foundation

func day15a() {
    let input = Array(readTextLines(name: "15").map { $0.split(separator: ",") }.joined().map { Array($0) })
    
    print(input)
    
    var sum = 0
    for line in input {
        var p = 0
        for c in line {
            p += Int(c.asciiValue!)
            p *= 17
            p %= 256
        }
        sum += p
    }
    
    print(sum)
    
}

func day15b() {
    struct Lens {
        var label: String
        var value: Int
        var operation: Character
        var focal: Int?
    }
        
    let input = Array(readTextLines(name: "15").map { $0.split(separator: ",") }.joined().map {
        if $0.last == "-" {
            let label = $0[0...$0.count - 2]
            return Lens(label: String(label), value: hash(Array(label)), operation: "-")
        } else {
            let label = $0[0...$0.count - 3]
            return Lens(label: String(label), value: hash(Array(label)), operation: "=", focal: Int(String($0.last!)))
        }
    })
    
    var boxes: [Int: [Lens]] = [:]
    
    for lens in input {
        switch lens.operation {
        case "-":
            if let index = boxes[lens.value, default: []].firstIndex(where: { $0.label == lens.label}) {
                boxes[lens.value, default: []].remove(at: index)
            }
        case "=":
            if let index = boxes[lens.value, default: []].firstIndex(where: { $0.label == lens.label}) {
                boxes[lens.value, default: []].remove(at: index)
                boxes[lens.value, default: []].insert(lens, at: index)
            } else {
                boxes[lens.value, default: []].append(lens)
            }
        default:
            break
        }
    }
    
    var sum = 0
    for i in 0 ..< 256 {
        var c = 1
        for lens in boxes[i, default: []] {
            sum += (i + 1) * c * lens.focal!
            c += 1
        }
    }
    
    print(sum)
}

func hash(_ line: [Character]) -> Int {
    var p = 0
    for c in line {
        p += Int(c.asciiValue!)
        p *= 17
        p %= 256
    }
    return p
}
