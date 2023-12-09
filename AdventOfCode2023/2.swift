//
//  2.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-01.
//

import Foundation

struct Round {
    var red: Int
    var green: Int
    var blue: Int
}

func day2a() {
    let lines: [String] = readTextLines(name: "2")
    
    var sum = 0
    for line in lines {
        let split1 = line.split(separator: ": ")
        let gameId = Int(String(split1[0][5...]))!

        let game = split1[1].split(separator: "; ")
        
        var possible = true
        for round in game {
            let r = parseRound(roundString: String(round))
            if r.red > 12 || r.green > 13 || r.blue > 14 {
                possible = false
                break
            }
        }
        if possible {
            sum += gameId
        }
    }
    
    print(sum)
}

func day2b() {
    let lines: [String] = readTextLines(name: "2")
    
    var sum = 0
    for line in lines {
        let split1 = line.split(separator: ": ")
        let gameId = Int(String(split1[0][5...]))!

        let game = split1[1].split(separator: "; ")
        
        var min = Round(red: 0, green: 0, blue: 0)
        for round in game {
            let r = parseRound(roundString: String(round))
            if r.red > min.red {
                min.red = r.red
            }
            if r.green > min.green {
                min.green = r.green
            }
            if r.blue > min.blue {
                min.blue = r.blue
            }
        }
        sum += min.red * min.green * min.blue
    }
    
    print(sum)
}

func parseRound(roundString: String) -> Round {
    let split = roundString.split(separator: ", ")
    var res = Round(red: 0, green: 0, blue: 0)
    for s in split {
        let ss = s.split(separator: " ")
        let n = Int(ss[0])!
        switch ss[1] {
        case "red":
            res.red = n
        case "green":
            res.green = n
        case "blue":
            res.blue = n
        default:
            fatalError()
        }
    }
    
    return res
}
