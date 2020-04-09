//
//  Example.swift
//  drawcircle
//
//  Created by Abhilash Keerthi on 10/28/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//
import SwiftUI
struct Example: View {
    @State var endPoint = CGPoint(x:110, y:200)
    var body: some View {
        GeometryReader {
            geometry in
            Path {
                path in
                path.move(to: CGPoint(x: 0,y: 0))
                path.addLine(to: self.endPoint)
            }
            .stroke(Color.red, lineWidth: 2.0)
        }
        .background(Color.gray) .gesture(
            DragGesture(minimumDistance: 0.1) .onChanged( {
                (value) in
                self.endPoint = value.location
                print("hello")
//                print(self.endPoint)
            }).onEnded( {
                (value) in
                self.endPoint = value.location
                print("end")
                // (177.0, 374.3333282470703)
                print(self.endPoint)
            }))
    }

}
struct Example_Previews: PreviewProvider {
    static var previews: some View {
        Example()
    }

}

