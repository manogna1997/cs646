//
//  demo.swift
//  drawcircle
//
//  Created by Abhilash Keerthi on 10/28/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//

import SwiftUI

struct demo: View {
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    var body: some View {
        Circle()
             .frame(width: 100, height: 100)
             .foregroundColor(Color.red)
             .offset(x: self.currentPosition.width, y: self.currentPosition.height)
             // 3.
             .gesture(DragGesture()
                 .onChanged { value in
                     self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
             }   // 4.
                 .onEnded { value in
                     self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                     print(self.newPosition.width)
                     self.newPosition = self.currentPosition
            }
        ).animation(.spring())
    }
}

struct demo_Previews: PreviewProvider {
    static var previews: some View {
        demo()
    }
}
