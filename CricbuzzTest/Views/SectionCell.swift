//
//  SectionCell.swift
//  CricbuzzTest
//
//  Created by shubham gupta on 19/07/24.
//

import SwiftUI

struct SectionCell: View {
    let type: SectionType
    @EnvironmentObject var viewModelConatiner: ViewModelContainer<MovieListViewModelImpl>
    @Binding var selectedSection: SectionType?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(type.rawValue)
                Spacer()
                if selectedSection == type {
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
                if type != .AllMovies {
                    SectionView(type: type)
                        .padding(8)
                } else {
                    SectionView(type: type)
                        .padding(8)
                }
            }
        }
    }
}
