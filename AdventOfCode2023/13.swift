//
//  13.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-13.
//

import Foundation

func day13a() {
    let input = readTextLines(name: "13", ignoreEmptyLines: false)
    
    var boards: [[String]] = []
    
    var board: [String] = []
    for line in input {
        if line.isEmpty {
            boards.append(board)
            board.removeAll()
            continue
        }
        board.append(line)
    }
    if !board.isEmpty {
        boards.append(board)
    }
    
    var sum = 0
    
    for board in boards {
        let ref = findReflection(board: board)
        if ref.1 {
            sum += (ref.0 + 1) * 100
        } else {
            sum += ref.0 + 1
        }
    }
    print(sum)
}

func day13b() {
    let input = readTextLines(name: "13", ignoreEmptyLines: false)
    
    var boards: [[String]] = []
    
    var board: [String] = []
    for line in input {
        if line.isEmpty {
            boards.append(board)
            board.removeAll()
            continue
        }
        board.append(line)
    }
    if !board.isEmpty {
        boards.append(board)
    }
    
    var sum = 0
    
    for board in boards {
        let ref = findSmudgeReflection(board: board)
        if ref.1 {
            sum += (ref.0 + 1) * 100
        } else {
            sum += ref.0 + 1
        }
    }
    print(sum)
}

func printBoard(_ board: [String]) {
    for line in board {
        print(line)
    }
    print("")
}

func findSmudgeReflection(board: [String]) -> (Int, Bool) {
    let original = findReflection(board: board)
    for y in 0 ..< board.count {
        for x in 0 ..< board[y].count {
            var copy = board
            copy[y] = copy[y].replace(x, copy[y][x] == "." ? "#" : ".")
            let res = findReflection(board: copy, not: original)
            if res.0 != -1 {
                return res
            }
        }
    }
    print("Did not find for")
    printBoard(board)
    return (-1, true)
}

func findReflection(board: [String], not: (Int, Bool)? = nil) -> (Int, Bool) {
    for i in 0 ..< board.count - 1 {
        var ok = true
        if not?.0 == i && not?.1 == true {
            continue
        }
        for j in 1 ... board.count / 2 {
            guard i + 1 - j >= 0 && i + j < board.count else {
                break
            }
            
            if board[i + 1 - j] != board[i + j] {
                ok = false
                break
            }
        }
        if ok {
            return (i, true)
        }
    }
    
    for i in 0 ..< board[0].count - 1 {
        var ok = true
        if not?.0 == i && not?.1 == false {
            continue
        }
        for j in 1 ... board[0].count / 2 {
            guard i + 1 - j >= 0 && i + j < board[0].count else {
                break
            }
            
            for line in board {
                if line[i + 1 - j] != line[i + j] {
                    ok = false
                }
            }
            if !ok {
                break
            }
        }
        if ok {
            return (i, false)
        }
    }
    
    return (-1, false)
}
