//
//  DetailedItemView.swift
//  IWatched
//
//  Created by Bahadır Kılınç on 10.08.2022.
//

import SwiftUI
struct DetailedItemView: View {
    var item: Item
    var body: some View {
        ScrollView{
            VStack{
                Image(uiImage: UIImage(data: item.cover!)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                
                infoView(feature: "Name", content: item.name!)
                
                infoView(feature: "Category", content: item.category!)
                
                infoView(feature: "Vibe", content: item.vibe!)
                
                VStack{
                    Text("Notes")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .padding()
                    HStack(alignment: .firstTextBaseline){
                        Text(item.note!)
                            .padding()
                    }
                }
                .padding()
                .background(Color(UIColor.tertiarySystemFill))
                .cornerRadius(9)
                .padding()
            }
        }
    }
    
    @ViewBuilder func infoView(feature: String, content: String) -> some View{
        HStack{
            Text(feature)
            Spacer()
            Text(content)
                .fontWeight(.bold)
        }
        .padding()
        .background(Color(UIColor.tertiarySystemFill))
        .cornerRadius(9)
        .font(.system(size: 18, design: .default))
        .padding()
    }
}

