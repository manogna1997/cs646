//
//  ContentView.swift
//  drawcircle
//
//  Created by manogna podishetty on 10/28/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//          SceneView(scene: GameScene(fileNamed:"MoveCircle")!).previewLayout(.sizeThatFits)
import SwiftUI
import SpriteKit
struct ContentView: View {
    @EnvironmentObject var cStatus : CircleStates
    @State var heightmisc :CGFloat
    @State var col : [Color] = [Color.green, Color.red, Color.blue, Color.black]
    @State  var selectedColor = Color.black
    @State  var editmode = false
    @State  var deletmode = false
    @State  var movemode = false
    @State var h :CGFloat!
    @State var w :CGFloat!
    var body: some View {
        VStack{
            GeometryReader {
                geometry in

                HStack{
                    if !self.movemode {
                        ZStack{
                            ForEach(self.cStatus.circles){
                                stud in
                                DrawCircle(status: stud,
                                           saveState: {
                                               st in self.saveCircle(sta: st)
                                           },
                                           editmode: self.editmode,
                                           col: self.selectedColor ,
                                           heightMaxY: geometry.size.height,
                                           wightX: geometry.size.width,
                                           delete:  {
                                               st in self.deleteNode(sta: st)
                                            }
                                            )
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height , alignment: .topTrailing).background(Color.yellow)
                        .onAppear( perform: {
                            self.heightmisc = (geometry.size.height * 8)/100 ; print("helo")
                            self.h = geometry.size.height
                            self.w = geometry.size.width
                        })
                        
                        .background(Color.red)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                            .onEnded( {
                                (value) in
                                let cor = CGPoint(x: value.location.x, y: value.location.y - self.heightmisc/4)
                                let  newCircle = CircleState(cent: cor,edit: true)
                                newCircle.colour = self.selectedColor
                                self.cStatus.circles.append(newCircle)
                            }))
                    }
                    else{
                          SceneView(scene: self.getScene(w: self.w, h: self.h))
               
                        //                        SceneView(scene: self.getScene(), wid: geometry.size.width, heigh: geometry.size.height)
                    }
                }
                HStack {
                    Button(action: {self.selectmode(mode: "edit")})
                    {
                        if self.editmode == true {
                            Text("edit").underline()
                        }
                        else{
                            Text("edit")
                        }
                    }
                    Button(action: {self.selectmode(mode: "move")})
                    {
                        if self.movemode == true {
                            Text("move").underline()
                        }
                        else{
                            Text("move")
                        }
                    }
                    ForEach(0 ..< self.col.count) {
                        if self.selectedColor != self.col[$0] {
                            ColourSelect(col: self.col[$0], ontap: {
                                sel in
                                print(sel)
                                self.selectedColor = sel
                            })
                        }
                        else{
                            ColourSelect(col: self.col[$0], ontap: {
                                sel in
                                print(sel)
                                self.selectedColor = sel
                            })
                            .overlay(Circle().stroke(Color.yellow,lineWidth: 4))
                        }
                    }
                    Button(action: {self.selectmode(mode: "delete")})
                    {
                        if self.deletmode == true {
                            Text("delete").underline()
                        }
                        else{
                            Text("delete")
                        }
                    }
                }
                .padding((geometry.size.height * 2)/100)
                .frame(width: geometry.size.width, height: (geometry.size.height * 8)/100,alignment: .top).background(Color.white)
            }
        }
    }


    func deleteNode(sta : CircleState) -> Void {
        if self.deletmode == true {
            self.cStatus.circles.removeAll(where: {
                $0 == sta
            })
        }
    }
    func forcedelete(sta : CircleState) -> Void {
        self.cStatus.circles.removeAll(where: {
            $0 == sta
        })
    }
    func saveCircle(sta : CircleState) -> Void {
        if !self.cStatus.circles.contains(sta){
            self.cStatus.circles.append(sta)
        }
        else{
            self.forcedelete(sta: sta)
            self.cStatus.circles.append(sta)
        }
    }
    func selectmode(mode :String) {
        switch mode {
            case "edit":
            if self.editmode == true {
                self.editmode = false
            }
            else{
                self.editmode = true
                self.deletmode = false
                self.movemode = false
            }
            return
            case "delete":
            if self.deletmode == true {
                self.deletmode = false
            }
            else{
                self.deletmode = true
                self.editmode = false
                self.movemode = false
            }
            return
            case "move":
            if self.movemode == true {
                self.movemode = false
              
              
            }
            else{
                self.movemode = true
                self.deletmode = false
                self.editmode = false
    
             
            }
            return
            default:
            print("nothing")
        }
    }
    func getScene(w: CGFloat,h: CGFloat) -> GameScene {
        let scen = GameScene(fileNamed:"MoveCircle")!
        scen.circledata = self.cStatus.circles
        scen.wid = w
        scen.heigh = h
        return scen
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(heightmisc: 20)
    }
}


