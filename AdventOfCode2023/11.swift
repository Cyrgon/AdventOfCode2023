//
//  11.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-11.
//

import Foundation

func day11a() {
    let input = readTextLines(name: "11")
    
    var expanded: [String] = []
    
    for line in input {
        expanded.append(line)
        if line.allSatisfy( { $0 == "." } ) {
            expanded.append(line)
        }
    }
    
    for i in stride(from: expanded[0].count - 1, through: 0, by: -1) {
        var all = true
        for line in expanded {
            if line[i] != "." {
                all = false
                break
            }
        }
        if all {
            for j in 0 ..< expanded.count {
                expanded[j].insert(".", at: expanded[j].index(expanded[j].startIndex, offsetBy: i))
            }
        }
    }
    
    var galaxies: [[Int]] = []
    for y in 0 ..< expanded.count {
        for x in 0 ..< expanded[y].count {
            if expanded[y][x] == "#" {
                galaxies.append([x, y])
            }
        }
    }
    
    var sum = 0
    for i in 0 ..< galaxies.count - 1 {
        for j in i + 1 ..< galaxies.count {
            sum += abs(galaxies[i][0] - galaxies[j][0]) + abs(galaxies[i][1] - galaxies[j][1])
        }
    }
    print(sum)
}

func day11b() {
    let input = readTextLines(name: "11")
    
    var extraX: [Int] = []
    var extraY: [Int] = []
    
    for i in 0 ..< input.count {
        if input[i].allSatisfy( { $0 == "." } ) {
            extraY.append(i)
        }
    }
    
    for i in stride(from: input[0].count - 1, through: 0, by: -1) {
        var all = true
        for line in input {
            if line[i] != "." {
                all = false
                break
            }
        }
        if all {
            extraX.append(i)
        }
    }
    
    var galaxies: [[Int]] = []
    for y in 0 ..< input.count {
        for x in 0 ..< input[y].count {
            if input[y][x] == "#" {
                galaxies.append([x, y])
            }
        }
    }
    
    let extra = 999999
    
    var sum = 0
    for i in 0 ..< galaxies.count - 1 {
        for j in i + 1 ..< galaxies.count {
            let g1 = galaxies[i]
            let g2 = galaxies[j]
            var dist = abs(g1[0] - g2[0]) + abs(g1[1] - g2[1])
            dist += extra * extraX.filter { min(g1[0], g2[0]) < $0 && max(g1[0], g2[0]) > $0 }.count
            dist += extra * extraY.filter { min(g1[1], g2[1]) < $0 && max(g1[1], g2[1]) > $0 }.count
            sum += dist
        }
    }
    print(sum)
}
