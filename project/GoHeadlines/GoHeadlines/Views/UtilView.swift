//
//  UtilView.swift
//  GoHeadlines
//
//  Created by Manogna podishetty on 12/15/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//

import SwiftUI

struct SelectSources: View {
    var items: [String]
    @State var selections: [String]?
    var update: ([String]) -> ()
//    var remove: (String) -> ()
    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                MultipleSelectionRow(title: item, isSelected: self.selections!.contains(item),action: {
                    if self.selections!.contains(item) {
                        self.selections!.removeAll(where: { $0 == item })
//                        self.remove(item)
                    }
                    else {
                        print(item)
                        self.selections!.append(item)
//                        self.add(item)
                    }
                })
            }
        }.onDisappear(perform: {
            self.update(self.selections!)
            
        })
        .navigationBarTitle("Select Classes", displayMode: .inline)
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> ()

    var body: some View {
        Button(action: self.action) {
            HStack {
                VStack{
                    HStack{
                        Text("\(self.title)").font(.headline)
                        Spacer()
                        if self.isSelected {
                            Image(systemName: "checkmark.seal.fill")
                        }
                    }
                }
            }
        }
    }
}
