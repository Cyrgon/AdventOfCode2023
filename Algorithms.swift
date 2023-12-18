//
//  Algorithms.swift
//  AdventOfCode2022
//
//  Created by Lukas Gustavsson on 2022-12-12.
//

import Foundation

struct Algorithms {
    static func aStar<T: Hashable, U: Numeric & Comparable>(start: T,
                                                            goal: T,
                                                            h: (T) -> U,
                                                            neighbors: (T) -> [(T, U)]) -> [T] {
        aStar(starts: [start],
              goals: [goal],
              h: h,
              neighbors: neighbors)
    }
    
    static func aStar<T: Hashable, U: Numeric & Comparable>(starts: [T],
                                                            goal: T,
                                                            h: (T) -> U,
                                                            neighbors: (T) -> [(T, U)]) -> [T] {
        aStar(starts: starts,
              goals: [goal],
              h: h,
              neighbors: neighbors)
    }
    
    static func aStar<T: Hashable, U: Numeric & Comparable>(start: T,
                                                            goals: [T],
                                                            h: (T) -> U,
                                                            neighbors: (T) -> [(T, U)]) -> [T] {
        aStar(starts: [start],
              goals: goals,
              h: h,
              neighbors: neighbors)
    }
    
    static func aStar<T: Hashable, U: Numeric & Comparable>(starts: [T],
                                                            goals: [T],
                                                            h: (T) -> U,
                                                            neighbors: (T) -> [(T, U)]) -> [T] {
        func reconstructPath(cameFrom: [T: T], current: T) -> [T] {
            var c = current
            var totalPath: [T] = [c]
            while let cr = cameFrom[c] {
                c = cr
                totalPath.insert(c, at: 0)
            }
            return totalPath
        }
        
        var openSet: [(T, U)] = []
        for start in starts {
            openSet.append((start, 0))
        }
        
        var cameFrom: [T: T] = [:]
        
        var gScore: [T: U] = [:]
        for start in starts {
            gScore[start] = 0
        }
        
        while !openSet.isEmpty {
            let current = openSet.removeFirst()
            for goal in goals {
                if current.0 == goal {
                    return reconstructPath(cameFrom: cameFrom, current: current.0)
                }
            }
            
            for nb in neighbors(current.0) {
                let tentativeGScore = gScore[current.0]! + nb.1
                if gScore[nb.0] == nil || tentativeGScore < gScore[nb.0]! {
                    cameFrom[nb.0] = current.0
                    gScore[nb.0] = tentativeGScore
                    if !openSet.contains(where: { $0.0 == nb.0 }) {
                        openSet.append((nb.0, tentativeGScore + h(nb.0)))
                    }
                }
            }
            
            openSet.sort { $0.1 < $1.1 }
        }
        
        return []
    }
    
    static func aStarF<T: Hashable, U: Numeric & Comparable>(start: T,
                                                            goal: @escaping (T) -> Bool,
                                                            h: (T) -> U,
                                                            neighbors: (T) -> [(T, U)]) -> [T] {
        aStarF(starts: [start],
              goals: [goal],
              h: h,
              neighbors: neighbors)
    }
    
    static func aStarF<T: Hashable, U: Numeric & Comparable>(starts: [T],
                                                            goals: [(T) -> Bool],
                                                            h: (T) -> U,
                                                            neighbors: (T) -> [(T, U)]) -> [T] {
        func reconstructPath(cameFrom: [T: T], current: T) -> [T] {
            var c = current
            var totalPath: [T] = [c]
            while let cr = cameFrom[c] {
                c = cr
                totalPath.insert(c, at: 0)
            }
            return totalPath
        }
        
        var openSet: [(T, U)] = []
        for start in starts {
            openSet.append((start, 0))
        }
        
        var cameFrom: [T: T] = [:]
        
        var gScore: [T: U] = [:]
        for start in starts {
            gScore[start] = 0
        }
        
        while !openSet.isEmpty {
            let current = openSet.removeFirst()
            for goal in goals {
                if goal(current.0) {
                    return reconstructPath(cameFrom: cameFrom, current: current.0)
                }
            }
            
            for nb in neighbors(current.0) {
                let tentativeGScore = gScore[current.0]! + nb.1
                if gScore[nb.0] == nil || tentativeGScore < gScore[nb.0]! {
                    cameFrom[nb.0] = current.0
                    gScore[nb.0] = tentativeGScore
                    if !openSet.contains(where: { $0.0 == nb.0 }) {
                        openSet.append((nb.0, tentativeGScore + h(nb.0)))
                    }
                }
            }
            
            openSet.sort { $0.1 < $1.1 }
        }
        
        return []
    }
    
    static func area(_ points: [CGPoint]) -> Double {
        var area = 0.0
        let numPoints = points.count

        for i in 0 ..< numPoints {
            let j = (i + 1) % numPoints
            area += (points[i].x * points[j].y)
            area -= (points[j].x * points[i].y)
        }

        area = abs(area) / 2.0
        return area
    }
}
