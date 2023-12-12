//
//  10.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-10.
//

import Foundation

func day10a() {
    let map = readTextLines(name: "10")
    
    let y = map.firstIndex { $0.contains("S") }!
    
    let x = map[y].firstIndex(of: "S")!.distance(in: map[y])
    
    print("Start: \((x, y))")
    for j in y - 1 ... y + 1 {
        for i in x - 1 ... x + 1 {
            guard j != y || i != x else {
                continue
            }
            guard j == y || i == x else {
                continue
            }
            
            var c = 0
            var last = (x, y)
            var new = (i, j)
            while(true) {
                c += 1
                guard let n = next(pos: new, last: last, map: map) else {
                    break
                }
                if map[n.1][n.0] == "S" {
                    print(c)
                    print(ceil(Double(c) / 2))
                    return
                }
                last = new
                new = n
            }
        }
    }
}

func day10b() {
    let map = readTextLines(name: "10")
    
    let y = map.firstIndex { $0.contains("S") }!
    
    let x = map[y].firstIndex(of: "S")!.distance(in: map[y])
    
    print("Start: \((x, y))")
    for j in y - 1 ... y + 1 {
        for i in x - 1 ... x + 1 {
            guard j != y || i != x else {
                continue
            }
            guard j == y || i == x else {
                continue
            }
            
            var c = 0
            var last = (x, y)
            var new = (i, j)
            var path: [(Int, Int)] = [last, new]
            
            while(true) {
                c += 1
                guard let n = next(pos: new, last: last, map: map) else {
                    break
                }
                path.append(n)
                if map[n.1][n.0] == "S" {
                    print(c)
                    print(ceil(Double(c) / 2))
                    var sum = 0
                    
                    let pathSet: Set<String> = Set(path.map { "\($0.0),\($0.1)" })
                    var crosses = 0
                    
                    for a in 0 ..< map.count {
                        var start: Character?
                        for b in 0 ..< map[0].count {
                            let v = "\(b),\(a)"
                            if pathSet.contains(v) {
                                if let s = start {
                                    switch s {
                                    case "|":
                                        start = map[a][b]
                                        if start == "|" {
                                            crosses += 1
                                        }
                                    case "F":
                                        if map[a][b] == "J" || map[a][b] == "S" {
                                            crosses += 1
                                            start = nil
                                        } else if map[a][b] == "7" {
                                            start = nil
                                        }
                                    case "L":
                                        if map[a][b] == "7" {
                                            crosses += 1
                                            start = nil
                                        } else if map[a][b] == "J" || map[a][b] == "S" {
                                            start = nil
                                        }
                                    default:
                                        fatalError()
                                    }
                                } else {
                                    start = map[a][b]
                                    if start == "|" {
                                        crosses += 1
                                    }
                                }
                            } else if crosses % 2 == 1 {
                                start = nil
                                sum += 1
                            }
                        }
                    }
                    print(sum)
                    return
                }
                last = new
                new = n
            }
        }
    }
}

func next(pos: (Int, Int), last: (Int, Int), map: [String]) -> (Int, Int)? {
    switch map[pos.1][pos.0] {
    case "-":
        return ne([(pos.0 + 1, pos.1), (pos.0 - 1, pos.1)], last: last)
    case "|":
        return ne([(pos.0, pos.1 + 1), (pos.0, pos.1 - 1)], last: last)
    case "F":
        return ne([(pos.0, pos.1 + 1), (pos.0 + 1, pos.1)], last: last)
    case "L":
        return ne([(pos.0, pos.1 - 1), (pos.0 + 1, pos.1)], last: last)
    case "7":
        return ne([(pos.0, pos.1 + 1), (pos.0 - 1, pos.1)], last: last)
    case "J":
        return ne([(pos.0, pos.1 - 1), (pos.0 - 1, pos.1)], last: last)
    default:
        return nil
    }
}

func ne(_ alt: [(Int, Int)], last: (Int, Int)) -> (Int, Int)? {
    guard alt.contains(where: {
        $0 == last
    }) else {
        return nil
    }
    return alt.first { $0 != last }
}
