//
//  14.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-14.
//

import Foundation

func day14a() {
    let input = readTextLines(name: "14")
    
    var board = input
    
    for y in 1 ..< board.count {
        for x in 0 ..< board[y].count {
            if board[y][x] == "O" {
                for i in stride(from: y - 1, through: 0, by: -1) {
                    if board[i][x] == "." {
                        board[i] = board[i].replace(x, "O")
                        board[i + 1] = board[i + 1].replace(x, ".")
                    } else {
                        break
                    }
                }
            }
        }
    }
    
    var sum = 0
    var c = 0
    for y in 0 ..< board.count {
        print(board[y])
        for x in 0 ..< board[y].count {
            if board[y][x] == "O" {
                c += 1
                sum += board.count - y
            }
        }
    }
    
    print(c)
    print(sum)
    
}

func day14b() {
    day14a()
    
    var board = readCharacters(name: "14")
    
    var res: [[[Character]]] = []
    
    let rep = 2000
    
    var scores: [Int] = []
    
    for ii in 0 ..< rep {
        tilt(board: &board, direction: .north)
        tilt(board: &board, direction: .west)
        tilt(board: &board, direction: .south)
        tilt(board: &board, direction: .east)
        
        res.append(board)
                
        scores.append(scoreBoard(board))
        
        if ii % 10 == 0 {
            print(ii)
        }
        
        if ii % 100 == 0 {
            if let cycle = scores.detectCycle() {
                print(cycle)
                print(scores[(1000000000 - 1) % cycle])
            }
        }
    }
    
    print("Boards generated")
}

func scoreBoard(_ board: [[Character]]) -> Int {
    var sum = 0
    for y in 0 ..< board.count {
        for x in 0 ..< board[y].count {
            if board[y][x] == "O" {
                sum += board.count - y
            }
        }
    }
    return sum
}

enum Direction {
    case north
    case south
    case west
    case east
}

func tilt(board: inout [[Character]], direction: Direction) {
    switch direction {
    case .north:
        for y in 1 ..< board.count {
            for x in 0 ..< board[y].count {
                if board[y][x] == "O" {
                    for i in stride(from: y - 1, through: 0, by: -1) {
                        if board[i][x] == "." {
                            board[i][x] = board[i + 1][x]
                            board[i + 1][x] = "."
                        } else {
                            break
                        }
                    }
                }
            }
        }
    case .south:
        for y in stride(from: board.count - 2, through: 0, by: -1) {
            for x in 0 ..< board[y].count {
                if board[y][x] == "O" {
                    for i in y + 1 ... board.count - 1 {
                        if board[i][x] == "." {
                            board[i][x] = board[i - 1][x]
                            board[i - 1][x] = "."
                        } else {
                            break
                        }
                    }
                }
            }
        }
    case .west:
        for y in 0 ..< board.count {
            for x in 1 ..< board[y].count {
                if board[y][x] == "O" {
                    for i in stride(from: x - 1, through: 0, by: -1) {
                        if board[y][i] == "." {
                            board[y][i] = board[y][i + 1]
                            board[y][i + 1] = "."
                        } else {
                            break
                        }
                    }
                }
            }
        }
    case .east:
        for y in 0 ..< board.count {
            for x in stride(from: board[y].count - 2, through: 0, by: -1) {
                if board[y][x] == "O" {
                    for i in x + 1 ... board.count - 1 {
                        if board[y][i] == "." {
                            board[y][i] = board[y][i - 1]
                            board[y][i - 1] = "."
                        } else {
                            break
                        }
                    }
                }
            }
        }
    }
    
}
