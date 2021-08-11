//
//  ContentView.swift
//  SwiftNews
//
//  Created by Dao Duy Duong on 09/08/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NewsListPage()
                .environmentObject(NewsListStore())
        }
    }
}
