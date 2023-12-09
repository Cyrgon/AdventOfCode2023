//
//  math.swift
//  AdventofCode2020
//
//  Created by Lukas Gustavsson on 2020-12-13.
//

import Foundation

struct Math {
    static func gcd(_ x: Int, _ y: Int) -> Int {
        var a = 0
        var b = max(x, y)
        var r = min(x, y)
        
        while r != 0 {
            a = b
            b = r
            r = a % b
        }
        return b
    }
    
    static func lcm(_ x: Int, _ y: Int) -> Int {
        return x / gcd(x, y) * y
    }
    
    /// https://en.wikipedia.org/wiki/Chinese_remainder_theorem
    static func CRT(a: EnumeratedSequence<[Int?]>) -> Int {
        let N = a.compactMap { $0.element }.reduce(1, *)
        
        let result = a.map { ele in
            guard let ni = ele.element else {
                return 0
            }
            let Ni = N / ni
            let bi = (ni - ele.offset) % ni
            if bi == 0 {
                return 0
            }
            var x = 0
            while( (Ni * x) % ni != 1) {
                x += 1
            }
            return bi * Ni * x
        }.reduce(0, +)
        
        return result % N
    }
    
    /// https://en.wikipedia.org/wiki/Chinese_remainder_theorem
    static func CRT(n: [Int], a: [Int]) -> Int {
        let N = n.reduce(1, *)
        
        var result = 0
        for i in 0 ... n.count - 1 {
            let Ni = N / n[i]
            let bi = (n[i] - a[i]) % n[i]
            if bi == 0 {
                continue
            }
            var x = 0
            while (Ni * x) % n[i] != 1 {
                x += 1
            }
            
            result += bi * Ni * x
        }
        
        return result % N
    }
}
