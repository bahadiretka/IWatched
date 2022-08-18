//
//  EmojiView.swift
//  IWatched
//
//  Created by Bahadır Kılınç on 12.08.2022.
//

import SwiftUI

struct EmojiView : View {
    
    @Binding var show : Bool
    @Binding var txt : String
    @Environment(\.presentationMode) var isShowing
    var body : some View{
        
        ZStack(alignment: .topLeading) {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 15){
                    
                    ForEach(self.getEmojiList(),id: \.self){i in
                        
                        HStack(spacing: 25){
                            
                            ForEach(i,id: \.self){j in
                                
                                Button(action: {
                                    
                                    self.txt = String(UnicodeScalar(j)!)
                                    show.toggle()
                                    
                                }) {
                                    
                                    if (UnicodeScalar(j)?.properties.isEmoji)!{
                                        
                                        Text(String(UnicodeScalar(j)!)).font(.system(size: 55))
                                    }
                                    else{
                                        
                                        Text("")
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.top)
                
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .background(Color.black)
            .cornerRadius(25)
            Button(action: {
                self.show.toggle()
            }) {
                Image(systemName: "xmark").foregroundColor(.white)
            }.padding()
        }
        .animation(Animation.easeOut(duration: 0.3))
        
    }
    
    func getEmojiList()->[[Int]]{
        
        var emojis : [[Int]] = []
        
        for i in stride(from: 0x1F601, to: 0x1F64F, by: 4){
            
            var temp : [Int] = []
            
            for j in i...i+3{
                
                temp.append(j)
            }
            
            emojis.append(temp)
        }
        
        return emojis
    }
}

struct Previews_EmojiView_Previews: PreviewProvider {

    static var previews: some View {
        EmojiView(show: .constant(true), txt: .constant(""))
    }
}
