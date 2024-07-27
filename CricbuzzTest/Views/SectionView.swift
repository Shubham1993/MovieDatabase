//
//  SectionView.swift
//  CricbuzzTest
//
//  Created by shubham gupta on 19/07/24.
//

import SwiftUI

struct SectionView: View {
    @State private var selectedSection: String? = nil
    var type: SectionType
    @EnvironmentObject var viewModelContainer: ViewModelContainer<MovieListViewModelImpl>
    
    init(type: SectionType) {
        self.type = type
    }
    
    var body: some View {
        List(viewModelContainer.viewModel.data, id: \.self) { name in
            HStack {
                Text(name)
                Spacer()
                if selectedSection == name {
                    Image(systemName: "chevron.up")
                } else {
                    Image(systemName: "chevron.right")
                }
            }
            .listRowBackground(Color(UIColor.secondarySystemGroupedBackground))
            .padding(.horizontal, 4)
            .contentShape(Rectangle())
            .listRowInsets(EdgeInsets())
            .onTapGesture {
                if selectedSection == name {
                    selectedSection = nil
                } else {
                    selectedSection = name
                    viewModelContainer.viewModel.onExpand(type: type, filter: name)
                }
            }
            
            if selectedSection == name {
                MovieListView(type: type, name: name)
                    .listRowBackground(Color(UIColor.secondarySystemGroupedBackground))
            }
        }
        .listStyle(PlainListStyle())
        .scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
        .frame(height: CGFloat(min(viewModelContainer.viewModel.data.count * 50, 300)))
        .contentMargins(0)
    }
}

