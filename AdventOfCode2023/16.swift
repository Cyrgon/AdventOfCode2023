//
//  16.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-17.
//

import Foundation

func day16a() {
    struct L: Hashable {
        let x: Int
        let y: Int
        let dx: Int
        let dy: Int
    }
    let input = readCharacters(name: "16")
    
    print(input)
    
    var lights: Set<L> = []
    
    lights.insert(L(x: -1, y: 0, dx: 1, dy: 0))
    
    var done: Set<L> = []
    var energized: Set<String> = []
    
    while let light = lights.first {
        let newX = light.x + light.dx
        let newY = light.y + light.dy
        lights.remove(light)
        
//        print(lights.count)
        guard newX >= 0 && newX < input[0].count && newY >= 0 && newY < input.count && !done.contains(light) else {
            continue
        }
        
        done.insert(light)
        
        energized.insert("\(newX),\(newY)")
        
        switch input[newY][newX] {
        case ".":
            lights.insert(L(x: newX, y: newY, dx: light.dx, dy: light.dy))
        case "/":
            if light.dx == 1 {
                lights.insert(L(x: newX, y: newY, dx: 0, dy: -1))
            } else if light.dx == -1 {
                lights.insert(L(x: newX, y: newY, dx: 0, dy: 1))
            } else if light.dy == 1 {
                lights.insert(L(x: newX, y: newY, dx: -1, dy: 0))
            } else {
                lights.insert(L(x: newX, y: newY, dx: 1, dy: 0))
            }
        case "\\":
            if light.dx == 1 {
                lights.insert(L(x: newX, y: newY, dx: 0, dy: 1))
            } else if light.dx == -1 {
                lights.insert(L(x: newX, y: newY, dx: 0, dy: -1))
            } else if light.dy == 1 {
                lights.insert(L(x: newX, y: newY, dx: 1, dy: 0))
            } else {
                lights.insert(L(x: newX, y: newY, dx: -1, dy: 0))
            }
        case "-":
            if light.dx != 0 {
                lights.insert(L(x: newX, y: newY, dx: light.dx, dy: 0))
            } else {
                lights.insert(L(x: newX, y: newY, dx: 1, dy: 0))
                lights.insert(L(x: newX, y: newY, dx: -1, dy: 0))
            }
        case "|":
            if light.dy != 0 {
                lights.insert(L(x: newX, y: newY, dx: 0, dy: light.dy))
            } else {
                lights.insert(L(x: newX, y: newY, dx: 0, dy: -1))
                lights.insert(L(x: newX, y: newY, dx: 0, dy: 1))
            }
        default:
            fatalError()
        }
    }
    
    print(energized.count)
    
//    for y in 0 ..< input.count {
//        for x in 0 ..< input[y].count {
//            if energized.contains("\(x),\(y)") {
//                print("#", terminator: "")
//            } else {
//                print(".", terminator: "")
//            }
//        }
//        print("")
//    }
}

func day16b() {
    struct L: Hashable {
        let x: Int
        let y: Int
        let dx: Int
        let dy: Int
    }
    let input = readCharacters(name: "16")
    
    
    var starts: Set<L> = []
    
    for x in 0 ..< input[0].count {
        starts.insert(L(x: x, y: -1, dx: 0, dy: 1))
        starts.insert(L(x: x, y: input.count, dx: 0, dy: -1))
    }
    
    for y in 0 ..< input.count {
        starts.insert(L(x: -1, y: y, dx: 1, dy: 0))
        starts.insert(L(x: input[0].count, y: y, dx: -1, dy: 0))
    }
    
    var max = -1
    
    for start in starts {
        print("Check start \(start)")
        var lights: Set<L> = []
        
        var done: Set<L> = []
        var energized: Set<String> = []
        
        lights.insert(start)
        
        while let light = lights.first {
            let newX = light.x + light.dx
            let newY = light.y + light.dy
            lights.remove(light)
            
            //        print(lights.count)
            guard newX >= 0 && newX < input[0].count && newY >= 0 && newY < input.count && !done.contains(light) else {
                continue
            }
            
            done.insert(light)
            
            energized.insert("\(newX),\(newY)")
            
            switch input[newY][newX] {
            case ".":
                lights.insert(L(x: newX, y: newY, dx: light.dx, dy: light.dy))
            case "/":
                if light.dx == 1 {
                    lights.insert(L(x: newX, y: newY, dx: 0, dy: -1))
                } else if light.dx == -1 {
                    lights.insert(L(x: newX, y: newY, dx: 0, dy: 1))
                } else if light.dy == 1 {
                    lights.insert(L(x: newX, y: newY, dx: -1, dy: 0))
                } else {
                    lights.insert(L(x: newX, y: newY, dx: 1, dy: 0))
                }
            case "\\":
                if light.dx == 1 {
                    lights.insert(L(x: newX, y: newY, dx: 0, dy: 1))
                } else if light.dx == -1 {
                    lights.insert(L(x: newX, y: newY, dx: 0, dy: -1))
                } else if light.dy == 1 {
                    lights.insert(L(x: newX, y: newY, dx: 1, dy: 0))
                } else {
                    lights.insert(L(x: newX, y: newY, dx: -1, dy: 0))
                }
            case "-":
                if light.dx != 0 {
                    lights.insert(L(x: newX, y: newY, dx: light.dx, dy: 0))
                } else {
                    lights.insert(L(x: newX, y: newY, dx: 1, dy: 0))
                    lights.insert(L(x: newX, y: newY, dx: -1, dy: 0))
                }
            case "|":
                if light.dy != 0 {
                    lights.insert(L(x: newX, y: newY, dx: 0, dy: light.dy))
                } else {
                    lights.insert(L(x: newX, y: newY, dx: 0, dy: -1))
                    lights.insert(L(x: newX, y: newY, dx: 0, dy: 1))
                }
            default:
                fatalError()
            }
        }
        
        print(energized.count)
        
        
        if energized.count > max {
            max = energized.count
        }
    }
    
    print(max)
}
