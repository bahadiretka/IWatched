//
//  ContentView.swift
//  IWatched
//
//  Created by Bahadır Kılınç on 9.08.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var showingAddItemView = false

    var body: some View {
        
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        DetailedItemView(item: item)
                    } label: {
                        ItemRowView(item: item)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .foregroundColor(.white)
                }
                ToolbarItem {
                    Button(action: {
                        showingAddItemView.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                            .foregroundColor(.white)
                    }
                    .sheet(isPresented: $showingAddItemView, content: {AddItemView()})
                }
            }
        }
        .accentColor(.white)
        
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {

                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
