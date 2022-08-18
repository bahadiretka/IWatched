//
//  AddItemView.swift
//  IWatched
//
//  Created by Bahadır Kılınç on 10.08.2022.
//

import SwiftUI


struct AddItemView: View {
    let categories = ["Action","Animation","Comedy","Crime","Drama","Experimental","Fantasy","Historical","Horror","Romance","Science Fiction","Thriller","Western","Other"]
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var isPresenting
    @State private var selectedCategory = "Select"
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var showingPopup = false
    @State private var name = ""
    @State private var vibe = ""
    @State private var note = ""
    @State private var showingEmojis = false
    @State private var isAlertShowing = false
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            
            NavigationView {
                ScrollView{
                    VStack {
                        
                        if selectedImage != nil {
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .frame(width: 150, height: 150)
                                .padding()
                        } else {
                            Image("icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .frame(width: 150, height: 150)
                                .onTapGesture {
                                    showingPopup.toggle()
                                }
                                .padding()
                            
                        }

                        HStack{
                            Text("Category")
                                .padding()
                            Spacer()
                            Menu{
                                ForEach(categories, id: \.self){ category in
                                    Button(action: {
                                        selectedCategory = category
                                    }, label: {
                                        Text(category)
                                            .font(.system(size: 24))
                                    })
                                    
                                }
                            } label: {
                                Text(selectedCategory)
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }
                            .padding()
                            
                        }
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .padding()
                        
                        
                        // MARK: - name section
                        HStack {
                            TextField("Name", text: $name)
                                .padding()
                                .background(Color(UIColor.tertiarySystemFill))
                                .cornerRadius(9)
                                .font(.system(size: 18, weight: .bold, design: .default))
                        }.padding()
                        // MARK: - vibe section
                        
                        HStack {
                            Text("Choose a vibe")
                                .padding()
                            
                            Spacer()
                            Button(action: {
                                self.showingEmojis.toggle()
                            }, label: {
                                if vibe.isEmpty{
                                    Text("🫵🏻")
                                }else{
                                    Text(vibe)
                                }
                            })
                            .padding()
                            .background(.white)
                            .cornerRadius(.infinity)
                        }
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .padding()

                        ZStack {
                            if self.note.isEmpty {
                                TextEditor(text: .constant("Enter some note"))
                                    .font(.system(size: 24))
                                    .foregroundColor(.gray)
                                    .disabled(true)
                                    .padding()
           
                                    
                            }
                            TextEditor(text: $note)
                                .font(.system(size: 24))
                                .opacity(self.note.isEmpty ? 0.25 : 1)
                                .padding()
                                
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(UIColor.tertiarySystemFill), lineWidth: 5)
                        )
                        .padding()

                        Button(action: {
                            if(selectedImage == nil ||
                                name.isEmpty ||
                                vibe == "🫵🏻" ||
                                note.isEmpty ||
                                selectedCategory == "Select"){
                                    isAlertShowing.toggle()
                            }else{
                                withAnimation {
                                    let newItem = Item(context: viewContext)
                                    newItem.name = name
                                    newItem.cover = selectedImage?.pngData()
                                    newItem.note = note
                                    newItem.vibe = vibe
                                    newItem.category = selectedCategory
                                    do {
                                        try viewContext.save()
                                    } catch {
                                        let nsError = error as NSError
                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    }
                                }
                                
                                isPresenting.wrappedValue.dismiss()
                                
                            }
                            
                        }){
                            
                            Text("Save")
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Color(UIColor.tertiarySystemFill))
                                .cornerRadius(9)
                                .foregroundColor(Color.white)
                        }
                        .alert("Please fill every blank", isPresented: $isAlertShowing) {
                                    Button("OK", role: .cancel) { }
                                }
                        .padding()
                        
                        
                    } // MARK: - VSTACK
                }
                
                .sheet(isPresented: self.$isImagePickerDisplay) {
                    ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                }
                .navigationBarHidden(true)
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .blur(radius: showingPopup ? 8.0 : 0, opaque: false)
            .popup(isPresented: $showingPopup) { // fix which will be use pop up view or this one
                ZStack {
                    VStack {
                        VStack(spacing: 16) {
                            Text("Where will you get the photo?")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .padding()
                                .background(.black)
                                .cornerRadius(10)
                            Button(action: {
                                self.sourceType = .camera
                                self.isImagePickerDisplay.toggle()
                            }){
                                Spacer()
                                Text("Camera")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                Spacer()
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(10)
                            Button(action: {
                                self.sourceType = .photoLibrary
                                self.isImagePickerDisplay.toggle()
                            }){
                                Spacer()
                                Text("Photo Library")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                Spacer()
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                        .background(.gray)
                        .cornerRadius(16)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
                        .frame(maxWidth: 640)
                    }
                    
                    .padding()
                }
                
                
            }
            EmojiView(show: self.$showingEmojis, txt: self.$vibe).offset(y: showingEmojis ?  (UIApplication.shared.windows.first?.safeAreaInsets.bottom)! : UIScreen.main.bounds.height)
            
        }
        
    }
    
    
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}

