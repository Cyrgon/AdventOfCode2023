//
//  12.swift
//  AdventOfCode2023
//
//  Created by Lukas Gustavsson on 2023-12-12.
//

import Foundation

func day12a() {
    let input = readTextLines(name: "12").map { String($0.split(separator: " ").first!) }
    let numbers = readRegExNumbers(name: "12")
    
    var sum = 0
    for i in 0 ..< input.count {
        let c = calc(springs: input[i], numbers: numbers[i])
        print(numbers[1])
        print(c)
        sum += c
    }
    print(sum)
}

func calc(springs: String, numbers: [Int]) -> Int {
//    print("Calc \(springs)")
    guard ofit(springs: springs, numbers: numbers) > 0 else {
        return 0
    }
    if let range = springs.firstRange(of: "?") {
        return calc(springs: springs.replacingCharacters(in: range, with: "."), numbers: numbers) +
        calc(springs: springs.replacingCharacters(in: range, with: "#"), numbers: numbers)
    } else {
        return 1
    }
}

func ofit(springs: String, numbers: [Int]) -> Int {
    var regexp = "^[\\.?]*"
    for i in 0 ..< numbers.count {
        regexp += "[#?]{\(numbers[i])}"
        if i != numbers.count - 1 {
            regexp += "[\\.?]+"
        }
    }
    regexp += "[\\.?]*$"

    return springs.matches(for: regexp).count
}

func fit(springs: String, numbers: [Int]) -> Bool {
    var regexp = "\\.*"
    for i in 0 ..< numbers.count {
        regexp += "#{\(numbers[i])}"
        if i != numbers.count - 1 {
            regexp += "\\.+"
        }
    }
    regexp += "\\.*$"

    return springs.matches(for: regexp).count == 1
}

func day12b() {
    let oInput = readTextLines(name: "12").map { String($0.split(separator: " ").first!) }
    let oNumbers = readRegExNumbers(name: "12")
    
    var input: [String] = []
    var numbers: [[Int]] = []
    for i in 0 ..< oInput.count {
        input.append(oInput[i] + "?" + oInput[i] + "?" + oInput[i] + "?" + oInput[i] + "?" + oInput[i])
        numbers.append(oNumbers[i] + oNumbers[i] + oNumbers[i] + oNumbers[i] + oNumbers[i])
    }
    
    var res: [String: Int] = [:]
    var sum = 0
    for i in 0 ..< input.count {
        let c = calc3(springs: input[i], numbers: numbers[i], res: &res)
        
        print(c)
        sum += c
    }
    print(sum)
}

// This is the most messy unmaintanable shit ever
func calc3(springs: String, numbers: [Int], res: inout [String: Int]) -> Int {
    let key = springs + " " + numbers.map { "\($0)," }.joined()
    if let r = res[key] {
        return r
    }
    if numbers.isEmpty {
        if springs.allSatisfy({ $0 == "." || $0 == "?" }) {
            res[key] = 1
            return 1
        } else {
            res[key] = 0
            return 0
        }
    } else if springs.isEmpty {
        res[key] = 0
        return 0
    }
    for i in 0 ..< springs.count {
        if springs[i] == "." {
            if i == springs.count - 1 {
                return 0
            } else {
                continue
            }
        } else if springs[i] == "#" {
            let newPos = i + numbers[0]
            if springs.count > newPos {
                var ok = true
                for j in i ..< newPos {
                    if springs[j] == "." {
                        ok = false
                        break
                    }
                }
                if ok {
                    if springs.count == newPos {
                        let r = numbers.count == 1 ? 1 : 0
                        res[key] = r
                        return r
                    } else if springs[newPos] == "#" {
                        res[key] = 0
                        return 0
                    } else {
                        if numbers.count > 1 {
                            let r = calc3(springs: String(springs[(newPos + 1)...]), numbers: Array(numbers[1...]), res: &res)
                            res[key] = r
                            return r
                        } else {
                            if springs[newPos...].allSatisfy({ $0 == "." || $0 == "?" }) {
                                res[key] = 1
                                return 1
                            } else {
                                res[key] = 0
                                return 0
                            }
                        }
                    }
                } else {
                    res[key] = 0
                    return 0
                }
            } else if springs.count == newPos && numbers.count == 1 {
                let r = springs[i...].allSatisfy { $0 == "#" || $0 == "?" } ? 1 : 0
                res[key] = r
                return r
            } else {
                res[key] = 0
                return 0
            }
        } else { //?
            var possible = 0
            let newPos = i + numbers[0]
            if springs.count > newPos {
                var ok = true
                for j in i ..< i + numbers[0] {
                    if springs[j] == "." {
                        ok = false
                        break
                    }
                }
                if ok {
                    if springs.count == newPos {
                        let r = numbers.count == 1 ? 1 : 0
                        possible = r
                    } else if springs[newPos] == "#" {
                        possible = 0
                    } else {
                        if numbers.count > 1 {
                            possible = calc3(springs: String(springs[(newPos + 1)...]), numbers: Array(numbers[1...]), res: &res)
                        } else {
                            if springs[newPos...].allSatisfy({ $0 == "." || $0 == "?" }) {
                                possible = 1
                            } else {
                                possible = 0
                            }
                        }
                    }
                } else {
                    possible = 0
                }
            } else if springs.count == newPos && numbers.count == 1 {
                possible = springs[i...].allSatisfy { $0 == "#" || $0 == "?" } ? 1 : 0
            } else {
                possible = 0
            }
            if let d = springs.distance(of: "?") {
                let r = possible + calc3(springs: String(springs[(d + 1)...]), numbers: numbers, res: &res)
                res[key] = r
                return r
            } else {
                fatalError()
            }
        }
    }
    fatalError()
}
