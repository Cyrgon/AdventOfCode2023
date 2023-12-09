//
//  5.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-05.
//

import Foundation

func day5a() {
    let seeds: [Int]
    var map: [[[Int]]] = []
    
    var lines = readRegExNumbers(name: "5")
    
    seeds = lines.removeFirst()
    lines.removeFirst()
    var m: [[Int]] = []
    for l in lines {
        if l.isEmpty {
            map.append(m)
            m = []
        } else {
            m.append(l)
        }
    }
    map.append(m)

    
    var lowest = Int.max
    for seed in seeds {
        let loc = seedToLocation(seed, map: map)
        if loc < lowest {
            lowest = loc
        }
    }
    
    print(lowest)
    
}

func day5b() {
    let seeds: [Int]
    var map: [[[Int]]] = []
    
    var lines = readRegExNumbers(name: "5")
    
    seeds = lines.removeFirst()
    lines.removeFirst()
    var m: [[Int]] = []
    for l in lines {
        if l.isEmpty {
            map.append(m)
            m = []
        } else {
            m.append(l)
        }
    }
    map.append(m)

    let size = 10000
    
    var lowest = Int.max
    var lowestSeed = 0
    var lowestSeedMin = 0
    var lowestSeedMax = 0
    for s in stride(from: 0, to: seeds.count - 1, by: 2) {
        for seed in stride(from: seeds[s], to: seeds[s] + seeds[s + 1], by: size) {
            let loc = seedToLocation(seed, map: map)
            if loc < lowest {
                lowest = loc
                lowestSeed = seed
                lowestSeedMin = seeds[s]
                lowestSeedMax = seeds[s] + seeds[s + 1] - 1
            }
        }
        
        for seed in max(lowestSeedMin, lowestSeed - size) ... min(lowestSeedMax, lowestSeed + size) {
            let loc = seedToLocation(seed, map: map)
            if loc < lowest {
                lowest = loc
            }
        }
    }
    
    print(lowest)
    
}

func seedToLocation(_ seed: Int, map: [[[Int]]]) -> Int {
    var r = seed
    outer: for m in map {
        for n in m {
            if r >= n[1] && r < n[1] + n[2] {
                r = n[0] + r - n[1]
                continue outer
            }
        }
    }
    
    return r
}
