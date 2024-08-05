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
                RecentsGrid(isBrowseVisible: $isBrowseVisible)
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
                    HorizontalGrid(isBrowseVisible: $isBrowseVisible, title: category.label, models: models)
                }
            }
        }
    }
}

struct HorizontalGrid: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var isBrowseVisible: Bool
    var title: String
    var models: [Model]
    private let gridItemLayout = [GridItem(.fixed(150))]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2).bold()
                .padding(.leading, 22)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridItemLayout, spacing: 30) {
                    ForEach(models) { model in
                        ItemButton(model: model) {
                            model.asyncLoadModelEntity()
                            placementSettings.selectedModel = model
                            isBrowseVisible.toggle()
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

struct RecentsGrid: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var isBrowseVisible: Bool
    
    var body: some View {
        if !placementSettings.recentlyPlaced.isEmpty {
            HorizontalGrid(isBrowseVisible: $isBrowseVisible, title: "Recents", models: getRecentsUniqueOrdered())
        }
    }
    
    func getRecentsUniqueOrdered() -> [Model] {
        var recentsUniqueOrderedArray: [Model] = []
        let modelNameSet: Set<String> = []
        
        for model in placementSettings.recentlyPlaced.reversed() {
            if !modelNameSet.contains(model.name) {
                recentsUniqueOrderedArray.append(model)
            }
        }
        return recentsUniqueOrderedArray
    }
    
}
