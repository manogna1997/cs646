////
////  DrawingPanel.swift
////  drawcircle
////
////  Created by manogna podishetty on 10/30/19.
////  Copyright © 2019 manogna podishetty. All rights reserved.
////
//import SwiftUI
//struct DrawingPanel: View {
//    @State var status: [CircleState];
//    @State var endPoint = CGPoint(x:110, y:200)
//    var saveState : (CircleState) -> ()
//    var body: some View {
//        GeometryReader {
//            geometry in
//         
//                Path {
//                    path in
//                    path.move(to: CGPoint(x: 0,y: 0))
//                    path.addLine(to: self.endPoint)
//                }
//                .stroke(Color.red, lineWidth: 2.0)
//                ForEach(self.status){
//                    stud in
//                    DrawCircle(status: stud,saveState: {
//                        sta in
//                        self.saveState(sta)
//                    }).position()
//                }
//            
//        }.gesture(
//            DragGesture(minimumDistance: 8)
//            .onEnded( {
//                (value) in
//                self.endPoint = value.location
//                print("self.endPoint")
//        }))
//
//    }
//
////    func addNewCircle(cord : CGPoint) -> Void{
////    }
//
//}
//struct DrawingPanel_Previews: PreviewProvider {
//    static var previews: some View {
//        DrawingPanel( status: CircleStates().circles,saveState: {
//            st in print(st)
//        })
//    }
//
//}
//
