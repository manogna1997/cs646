//
//  PostOptionsView.swift
//  PostSocial
//
//  Created by Manogna Podishetty on 11/17/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
import SwiftUI
struct PostOptionsView: View {
    var selectedName : [String] = [];
    var filter : String = "";
    var options : [String] = [];
    var hsize : CGFloat = 10;
    var displayName : String = "TODO";
    var selectedcallBack : (String) -> ()
    var body: some View {
        VStack{
            HStack(spacing: 8) {
                Text(self.displayName).font(.subheadline).bold()
                Spacer()
            }
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(0 ..< self.options.count){
                        int in
                        if !self.selectedName.contains(self.options[int]) {
                            Button(action: {
                                self.selectedcallBack(self.options[int])
                            }
                                   ,label:{
                                       Text(self.options[int])
                                       .bold()
                                       .foregroundColor(.blue)
                                       .font(.subheadline)
                                       .frame(height: self.hsize*1.5 )
                                       .padding(3)
                                   })
                        }
                        else{
                            Button(action: {
                                self.selectedcallBack(self.options[int])
                            }
                                   ,label:{
                                       Text(self.options[int])
                                       .bold().italic()
                                       .foregroundColor(.black)
                                       .font(.subheadline)
                                       .frame(height: self.hsize )
                                       .padding(3)
                                       .overlay(
                                           RoundedRectangle(cornerRadius: 10)
                                           .stroke(Color.black, lineWidth: 3))
                                   })
                            .background(Color.yellow)
                        }
                    }
                }
            }
        }
    }

    func isItReadyForView(tag:String) -> Bool{
        var valid = false;
        if self.filter == ""{
            valid = self.selectedName.contains(tag)
        }
        else{
            valid = self.selectedName.contains(tag) && tag.contains( self.filter)
        }
        return valid;
    }

}
struct PostOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        PostOptionsView( selectedcallBack: {
            s in print(s)
        })
    }

}

