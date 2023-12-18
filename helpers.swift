//
//  helpers.swift
//  AdventofCode2020
//
//  Created by Lukas Gustavsson on 2020-12-04.
//

import Foundation

func readTextFile(name: String) -> String {
    guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
        print("Could not read \(name)")
        fatalError()
    }
    
    do {
        let data = try String(contentsOfFile: path, encoding: .utf8)
        return data
    } catch {
        print(error)
        fatalError()
    }
}

func readTextLines(name: String, ignoreEmptyLines: Bool = true) -> [String] {
    guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
        print("Could not read \(name)")
        fatalError()
    }
    
    do {
        let data = try String(contentsOfFile: path, encoding: .utf8)
        return data.components(separatedBy: .newlines).compactMap { $0.isEmpty ? (ignoreEmptyLines ? nil : $0) : $0 }
    } catch {
        print(error)
        fatalError()
    }
}

func readCharacters(name: String, ignoreEmptyLines: Bool = true) -> [[Character]] {
    return readTextLines(name: name, ignoreEmptyLines: ignoreEmptyLines).map { Array($0) }
}

protocol EncodeFromString {
    associatedtype T
    static func encodeFrom(_ str: String) -> T?
}

extension Int: EncodeFromString {
    typealias T = Int
    static func encodeFrom(_ str: String) -> Int? {
        return Int(str)
    }
}

extension Double: EncodeFromString {
    typealias T = Double
    static func encodeFrom(_ str: String) -> Double? {
        return Double(str)
    }
}

func readLines<T: EncodeFromString>(name: String) -> [T] {
    guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
        print("Could not read \(name)")
        fatalError()
    }
    
    do {
        let data = try String(contentsOfFile: path, encoding: .utf8)
        return data.components(separatedBy: .newlines).compactMap { T.encodeFrom($0) as? T }
    } catch {
        print(error)
        fatalError()
    }
}

func readOptionalLines<T: EncodeFromString>(name: String) -> [T?] {
    guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
        print("Could not read \(name)")
        fatalError()
    }
    
    do {
        let data = try String(contentsOfFile: path, encoding: .utf8)
        return data.components(separatedBy: .newlines).map { T.encodeFrom($0) as? T }
    } catch {
        print(error)
        fatalError()
    }
}

func readRegExLines(name: String, regex: String) -> [[String]] {
    return readTextLines(name: name).map { $0.matches(for: regex ) }
}

func readRegExNumbers(name: String) -> [[Int]] {
    return readTextLines(name: name).map { $0.matches(for: "-*[0-9]+" ) }
        .map { $0.map { Int($0)! } }
}

func readRegExLetters(name: String) -> [[String]] {
    return readTextLines(name: name).map { $0.matches(for: "-*[A-Za-z]+" ) }
        .map { $0.map { $0 } }
}
