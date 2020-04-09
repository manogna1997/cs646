//
//  CircleState.swift
//  drawcircle
//
//  Created by Abhilash Keerthi on 10/28/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//

import Foundation
import SwiftUI



class CircleState : Identifiable,Equatable,ObservableObject{
    
    @Published  var id = UUID()
    @Published  var editmode: Bool = false
    @Published  var currentPosition: CGSize
    @Published  var newPosition: CGSize
    @Published  var radius: CGFloat
    @Published  var centerCord: CGPoint
    @Published  var outerCordinates: CGPoint
    @Published  var colour : Color
    init(){
        self.currentPosition = .zero
        self.newPosition = .zero
        self.colour = Color.black
        self.centerCord = .zero
        self.outerCordinates = CGPoint(x: 10, y: 10)
        self.radius = 30
    }
    init( cent : CGPoint , edit : Bool){
        self.centerCord = cent
        self.currentPosition = .zero
        self.newPosition = .zero
        self.colour = Color.black
        self.outerCordinates = CGPoint(x: 10, y: 10)
        self.radius = 30
        self.editmode = edit
       
    }

}
extension CircleState {
    static func ==(lhs: CircleState, rhs: CircleState) -> Bool {
        return lhs.id == rhs.id
    }
}

class CircleStates:  ObservableObject{
    @Published  var id = UUID()
    @Published  var circles : [CircleState]
    
    init(inv:[CircleState]) {
        self.circles = inv
    }

    init() {
        self.circles = []
    }
}
func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
    return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
}

func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
    return sqrt(CGPointDistanceSquared(from: from, to: to))
}
