//
//  DrawCircle.swift
//  drawcircle
//
//  Created by manogna podishetty on 10/28/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//
import SwiftUI
struct DrawCircle: View {
    var status: CircleState;
    var saveState : (CircleState) -> ()
    var editmode : Bool
    var col : Color
    var heightMaxY: CGFloat
    var wightX: CGFloat
    var delete : (CircleState) ->()
    var body: some View {
        Circle()
        .frame(width: status.radius, height: status.radius)
        .foregroundColor(status.colour)
        .position(self.status.centerCord)
        .gesture(DragGesture()
                 .onChanged {
                     value in
                     if self.status.editmode == false &&  self.editmode == false{
                         self.status.centerCord = value.location
                     }
                     else{
                         let rad = CGPointDistance(from: self.status.centerCord, to: value.location)*2
                         self.status.radius = rad
                         self.saveState(self.status)
                     }
                 }
                 .onEnded {
                     value in
                     if self.status.editmode == false &&  self.editmode == false{
                         self.status.centerCord = value.location
                     }
                     else {
                         let rad = CGPointDistance(from: self.status.centerCord, to: value.location)*2
                         self.status.radius = rad
                         self.status.editmode = false
                     }
                     if self.editmode == false {
                         self.saveState(self.status)
                     }
                 })
        .gesture(TapGesture().onEnded({
            self.delete(self.status)
        }))
        .animation(.spring())
        .onAppear(perform: {
            print("came alive \(self.status.centerCord)")
        })
    }

    func createOffset(value:DragGesture.Value) -> Void {
        self.status.currentPosition = CGSize(width: value.translation.width + self.status.newPosition.width, height: value.translation.height + self.status.newPosition.height)
    }

    func createNewCircleCord(old: CGPoint,new: CGPoint) -> CGPoint {
        let newcord = CGPoint(x: old.x + new.x,y:old.y + new.y  )
        return newcord
    }

}
struct ColourSelect: View {
    var isActive: Bool = false;
    var col: Color;
    var ontap : (Color) -> ()
    var body: some View {
        let cir = Circle().foregroundColor(col).gesture(TapGesture().onEnded{
            val in self.ontap(self.col)
        })
        return cir
    }

}

