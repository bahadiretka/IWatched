//
//  ItemRowView.swift
//  IWatched
//
//  Created by Bahadır Kılınç on 15.08.2022.
//

import SwiftUI

struct ItemRowView: View {
    
    var item: Item
    var body: some View {
        HStack{
            Image(uiImage: UIImage(data: item.cover!)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 100, height: 100)
            Spacer()
            VStack(alignment: .leading) {
                Text(item.name!)
                    .font(.title)
                Text(item.category!)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(item.vibe!)
                .font(.system(size: 24))
                .padding()

        }
    }
}
