//
//  SectionCell.swift
//  CricbuzzTest
//
//  Created by shubham gupta on 19/07/24.
//

import SwiftUI

struct Cell: View {
    @EnvironmentObject var viewModelConatiner: ViewModelContainer<MovieListViewModelImpl>
    let type: SectionType
    @Binding var selectedSection: SectionType?
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(type.rawValue)
                Spacer()
                if selectedSection == type && selectedSection != .AllMovies {
                    Image(systemName: "chevron.up")
                } else {
                    Image(systemName: "chevron.right")
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if selectedSection == type {
                    selectedSection = nil
                } else {
                    selectedSection = type
                    viewModelConatiner.viewModel.onExpand(type: type)
                }
            }
            if selectedSection == type {
                SectionView(type: type)
                    .padding(8)
            }
        }
    }
}

struct SectionCell: View {
    let type: SectionType
    @EnvironmentObject var viewModelConatiner: ViewModelContainer<MovieListViewModelImpl>
    @Binding var selectedSection: SectionType?
    @State var isActive: Bool = false
    var body: some View {
        ZStack {
            if type == .AllMovies {
                NavigationLink {
                    AllMovies()
                } label: {
                    EmptyView()
                }
                .navigationTitle("Home")
                
                Cell(type: type, selectedSection: $selectedSection)
                    .contentShape(Rectangle().size(.zero))
            } else {
                Cell(type: type, selectedSection: $selectedSection)
            }
        }
    }
}
