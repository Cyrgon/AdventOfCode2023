//
//  17.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-17.
//

import Foundation

func day17a() {
    let input = readCharacters(name: "17").map { $0.map { Int(String($0))! } }
    
    struct L: Hashable {
        let x: Int
        let y: Int
        
        let dx: Int
        let dy: Int
        let c: Int
    }
    
    func h(_ l: L) -> Int {
        return input[0].count - 1 - l.x + input.count - 1 - l.y
    }
    
    func goal(_ l: L) -> Bool {
        return l.x == input[0].count - 1 
        && l.y == input.count - 1
    }

    let result = Algorithms.aStarF(start: L(x: 0, y: 0, dx: 1, dy: 0, c: 0),
                                   goal: goal,
                                   h: h,
                                   neighbors: { l in
        var neighbors: [(L, Int)] = []
        for x in (l.x - 1) ... (l.x + 1) {
            for y in (l.y - 1) ... (l.y + 1) {
                guard x >= 0 && x < input[0].count && y >= 0 && y < input.count &&
                        (x != l.x || y != l.y) else {
                    continue
                }
                let newdx = x - l.x
                let newdy = y - l.y
                if abs(newdx) == abs(newdy) {
                    continue
                }
                if newdx == l.dx + 2 || newdx == l.dx - 2 || newdy == l.dy + 2 || newdy == l.dy - 2 { // Cannot reverse
                    continue
                }
                let newc: Int
                if newdx == l.dx && newdy == l.dy {
                    newc = l.c + 1
                } else {
                    newc = 1
                }
                if newc > 3 {
                    continue
                }
                neighbors.append((L(x: x,
                                    y: y,
                                    dx: newdx,
                                    dy: newdy,
                                    c: newc), input[y][x]))
            }
        }
        
        return neighbors
    })
    var copy = input.map { $0.map { Character("\($0)") }}
    var sum = -input[0][0]
    for res in result {
        if res.x > 0 || res.y > 0 {
            copy[res.y][res.x] = "#"
        }
        print("Add \(input[res.y][res.x])")
        sum += input[res.y][res.x]
    }
    
    for row in copy {
        print(String(row))
    }
    
    print(sum)
}

func day17aAlt() {
    let input = readCharacters(name: "17b").map { $0.map { Int(String($0))! } }
    
    struct L: Hashable {
        let x: Int
        let y: Int
        
        let dx: Int
        let dy: Int
    }
    
    func h(_ l: L) -> Int {
        return input[0].count - 1 - l.x + input.count - 1 - l.y
    }
    
    func goal(_ l: L) -> Bool {
        return l.x == input[0].count - 1
        && l.y == input.count - 1
    }

    let result = Algorithms.aStarF(start: L(x: 0, y: 0, dx: 0, dy: 1),
                                   goal: goal,
                                   h: h,
                                   neighbors: { l in
        var neighbors: [(L, Int)] = []
        
        let newx = [l.x + l.dy, l.x + 2 * l.dy, l.x + 3 * l.dy, l.x - l.dy, l.x - 2 * l.dy, l.x - 3 * l.dy]
        let newy = [l.y + l.dx, l.y + 2 * l.dx, l.y + 3 * l.dx, l.y - l.dx, l.y - 2 * l.dx, l.y - 3 * l.dx]
        let newdx = [l.dy, l.dy, l.dy, -l.dy, -l.dy, -l.dy]
        let newdy = [l.dx, l.dx, l.dx, -l.dx, -l.dx, -l.dx]
        
        var extra = 0
        for i in 0 ..< 3 {
            guard newx[i] >= 0 && newx[i] < input[0].count && newy[i] >= 0 && newy[i] < input.count else {
                continue
            }
            extra += input[newy[i]][newx[i]]
            neighbors.append((L(x: newx[i],
                                y: newy[i],
                                dx: newdx[i],
                                dy: newdy[i]), extra))
        }
        
        extra = 0
        for i in 3 ..< 6 {
            guard newx[i] >= 0 && newx[i] < input[0].count && newy[i] >= 0 && newy[i] < input.count else {
                continue
            }
            extra += input[newy[i]][newx[i]]
            neighbors.append((L(x: newx[i],
                                y: newy[i],
                                dx: newdx[i],
                                dy: newdy[i]), extra))
        }
        
        return neighbors
    })
                                   

    var copy = input.map { $0.map { Character("\($0)") }}
    var sum = -input[0][0]
    for res in result {
        if res.x > 0 || res.y > 0 {
            copy[res.y][res.x] = "#"
        }
        print("Add \(input[res.y][res.x])")
        sum += input[res.y][res.x]
    }
    
    for row in copy {
        print(String(row))
    }
    
    print(sum)
}

func day17b() {
    let input = readCharacters(name: "17").map { $0.map { Int(String($0))! } }
    
    struct L: Hashable {
        let x: Int
        let y: Int
        
        let dx: Int
        let dy: Int
        let c: Int
    }
    
    func h(_ l: L) -> Int {
        return input[0].count - 1 - l.x + input.count - 1 - l.y
    }
    
    func goal(_ l: L) -> Bool {
        return l.x == input[0].count - 1
        && l.y == input.count - 1 &&
        l.c >= 4 && l.c <= 10
    }

    let result = Algorithms.aStarF(start: L(x: 0, y: 0, dx: 1, dy: 0, c: 0),
                                   goal: goal,
                                   h: h,
                                   neighbors: { l in
        var neighbors: [(L, Int)] = []
        for x in (l.x - 1) ... (l.x + 1) {
            for y in (l.y - 1) ... (l.y + 1) {
                guard x >= 0 && x < input[0].count && y >= 0 && y < input.count &&
                        (x != l.x || y != l.y) else {
                    continue
                }
                let newdx = x - l.x
                let newdy = y - l.y
                if abs(newdx) == abs(newdy) {
                    continue
                }
                if newdx == l.dx + 2 || newdx == l.dx - 2 || newdy == l.dy + 2 || newdy == l.dy - 2 { // Cannot reverse
                    continue
                }
                let newc: Int
                if newdx == l.dx && newdy == l.dy {
                    newc = l.c + 1
                } else {
                    newc = 1
                }
                if newc == 1 && l.c < 4 && (l.x != 0 || l.y != 0) {
                    continue
                }
                if newc > 10 {
                    continue
                }
                neighbors.append((L(x: x,
                                    y: y,
                                    dx: newdx,
                                    dy: newdy,
                                    c: newc), input[y][x]))
            }
        }
        
        return neighbors
    })
    var copy = input.map { $0.map { Character("\($0)") }}
    var sum = -input[0][0]
    for res in result {
        if res.x > 0 || res.y > 0 {
            copy[res.y][res.x] = "#"
        }
        print("Add \(input[res.y][res.x])")
        sum += input[res.y][res.x]
    }
    
    for row in copy {
        print(String(row))
    }
    
    print(sum)
}
