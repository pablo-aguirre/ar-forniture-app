//
//  BrowseView.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 04/08/24.
//

import SwiftUI

struct BrowseView: View {
    @Binding var isBrowseVisible: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                ModelsByCategoryGrid(isBrowseVisible: $isBrowseVisible)
            }
            .navigationTitle("Browse")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        isBrowseVisible.toggle()
                    }.bold()
                }
            })
        }
    }
}

struct ModelsByCategoryGrid: View {
    @Binding var isBrowseVisible: Bool
    let models = Models()
    
    var body: some View {
        VStack {
            ForEach(ModelCategory.allCases, id: \.self) { category in
                let models = models.get(by: category)
                if !models.isEmpty {
                    HorizontalGrid(isBrowseVisible: $isBrowseVisible, title: category.label, items: models)
                }
            }
        }
    }
}

struct HorizontalGrid: View {
    @Binding var isBrowseVisible: Bool
    var title: String
    var items: [Model]
    private let gridItemLayout = [GridItem(.fixed(150))]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2).bold()
                .padding(.leading, 22)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridItemLayout, spacing: 30) {
                    ForEach(items) { item in
                        ItemButton(model: item) {
                            isBrowseVisible.toggle()
                            print("BrowseView: selected \(item.name)")
                            
                        }
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 10)
            }
        }
    }
}

struct ItemButton: View {
    let model: Model
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(uiImage: model.thumbnail)
                .resizable()
                .frame(width: 150 ,height: 150)
                .aspectRatio(contentMode: .fit)
                .background(Color(.secondarySystemFill))
                .presentationCornerRadius(8.0)
        })
    }
}
