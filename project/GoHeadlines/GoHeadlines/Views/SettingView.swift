//
//  SettingView.swift
//  GoHeadlines
//
//  Created by Manogna podishetty on 12/4/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
import SwiftUI
struct SettingView: View {
    @State var setting : Settings;
    @State var sours : [String]?;
    @State var mode : Int = 0;
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var celsius: Double = 0
    var refreahCallBack : (Settings) -> ()
    @State var resMsg: GenearlRes?;
    @State var alertError: Bool = false
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select New Feeds").font(.headline)){
                    Picker("Select news mode", selection: self.$setting.mode) {
                        ForEach(0 ..< modes.count,id: \.self) {
                            index in
                            Text(modes[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    if modes[self.setting.mode] == everything {
                        Picker("Select language", selection: self.$setting.lang) {
                            ForEach(0 ..< language.count, id: \.self) {
                                Text(language[$0])
                            }
                        }
                    }
                    if self.setting.sources.count > 0 {
                        Text("category and country are disabled when sources are selected")
                        .foregroundColor(.red)
                        .font(.footnote)
                    }
                    Picker("Select category", selection: self.$setting.category) {
                        ForEach(0 ..< category.count,id: \.self) {
                            Text(category[$0])
                        }
                    }
                    .disabled(self.setting.sources.count > 0)
                    Picker("Select country", selection: self.$setting.country) {
                        ForEach(0 ..< country.count,id: \.self) {
                            Text(country[$0])
                        }
                    }
                    .disabled(self.setting.sources.count > 0)

                }
                if self.sours != nil {
                    Section(header: Text("Select Sources").font(.headline)){
                        NavigationLink(destination: SelectSources(
                            items: self.sours!,
                            selections: self.setting.sources,
                            update: { sel in
                                self.setting.sources = sel
                            }
                            ))
                        {
                            HStack {
                                Image(systemName: "plus.rectangle.on.rectangle")
                                .font(.body)
                                Text("Select news sources")
                                Spacer()
                                Text("\(self.setting.sources.count)")
                            }
                        }
                    }
                }
                Section(){
                    Slider(value: self.$setting.pagesize, in: 20...99, step: 5)
                    Text("results \(Int(self.setting.pagesize))")
                }

                Button( action: {
                    self.presentationMode.wrappedValue.dismiss()
                    self.refreahCallBack(self.setting)
                }
                       ,label: {
                           HStack {
                               Spacer()
                               Image(systemName: "gear").foregroundColor(.white)
                               Text("Save")
                               .fontWeight(.bold)
                               .foregroundColor(.white)
                               .padding(.vertical,10)
                               Spacer()
                           }
                           .background(Color.green)
                           .cornerRadius(4)
                       })
            }
            .navigationBarTitle(Text("News Feed"))
        }.alert(isPresented: self.$alertError ) {
            Alert(title: Text("Sorry!"), message: Text(self.resMsg!.errors), dismissButton: .default(Text("Ok")))
        }
        .onAppear(perform: {
            self.loadSourceData()
        })
    }

    func loadSourceData(){
        if sours == nil {
        var request = getSourcesURL(usrStr: self.setting)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            var  responseJSON =   try? decoder.decode(Sources.self, from: data)
            if let responseJSON = responseJSON as? Sources {
                print("got sources : \(responseJSON.sources?.count)")
                if responseJSON.sources != nil {
                    self.sours = []
                    for s  in responseJSON.sources! {
                        self.sours?.append(s.id!)
                    }
                }else{
                    self.resMsg = getErrorAlert(str: "Sorry! new cannot load data from https://newsapi.org")
                    self.alertError = true;
                }
            }
        }
        task.resume()
    }
    }
}
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(setting: Settings(), mode: 0, refreahCallBack: {
            s in print("hello")
        })
    }

}

