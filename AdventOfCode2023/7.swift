//
//  7.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-07.
//

import Foundation

func day7a() {
    let order = "23456789TJQKA".split(separator: "").map { String($0) }
    let hands = readTextLines(name: "7").map { $0.split(separator: " ").map { String($0) } }
    let ranked = Array(hands.sorted {
        let rank0 = rank($0[0])
        let rank1 = rank($1[0])
        if rank0 != rank1 {
            return rank0 > rank1
        } else {
            for i in 0 ..< $0[0].count {
                let c0 = String($0[0][i])
                let c1 = String($1[0][i])
                if order.firstIndex(of: c0)! != order.firstIndex(of: c1)! {
                    return order.firstIndex(of: c0)! > order.firstIndex(of: c1)!
                }
            }
            return true
        }
    }.reversed())
    
    var sum = 0
    for i in 0 ..< ranked.count {
        sum += (i + 1) * Int(ranked[i][1])!
    }
    
    print(sum)
}

func rank(_ hand: String) -> Int {
    let uniques = Set(hand)
    
    var c: [Int] = []
    for type in uniques {
        c.append(hand.filter { $0 == type}.count)
    }
    
    let val = Array(c.sorted().reversed())
    if val[0] == 5 {
        return 7
    } else if val[0] == 4 {
        return 6
    } else if val[0] == 3 {
        if val[1] == 2 {
            return 5
        } else {
            return 4
        }
    } else if val[0] == 2 {
        if val[1] == 2 {
            return 3
        } else {
            return 2
        }
    } else {
        return 1
    }
}

func day7b() {
    let order = "J23456789TQKA".split(separator: "").map { String($0) }
    let hands = readTextLines(name: "7").map { $0.split(separator: " ").map { String($0) } }
    let ranked = Array(hands.sorted {
        let rank0 = rankB($0[0])
        let rank1 = rankB($1[0])
        if rank0 != rank1 {
            return rank0 > rank1
        } else {
            for i in 0 ..< $0[0].count {
                let c0 = String($0[0][i])
                let c1 = String($1[0][i])
                if order.firstIndex(of: c0)! != order.firstIndex(of: c1)! {
                    return order.firstIndex(of: c0)! > order.firstIndex(of: c1)!
                }
            }
            return true
        }
    }.reversed())
    
    var sum = 0
    for i in 0 ..< ranked.count {
        sum += (i + 1) * Int(ranked[i][1])!
    }
    
    print(sum)
}

func rankB(_ hand: String) -> Int {
    
    let newHand = hand.filter { $0 != "J"}
    let jokers = 5 - newHand.count
    let uniques = Set(hand)
    
    var c: [Int] = []
    for type in uniques {
        c.append(newHand.filter { $0 == type}.count)
    }
    var val = Array(c.sorted().reversed())
    val[0] += jokers
    if val[0] == 5 {
        return 7
    } else if val[0] == 4 {
        return 6
    } else if val[0] == 3 {
        if val[1] == 2 {
            return 5
        } else {
            return 4
        }
    } else if val[0] == 2 {
        if val[1] == 2 {
            return 3
        } else {
            return 2
        }
    } else {
        return 1
    }
}
