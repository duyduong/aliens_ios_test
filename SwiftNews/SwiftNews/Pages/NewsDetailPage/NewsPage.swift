//
//  NewsPage.swift
//  SwiftNews
//
//  Created by Dao Duy Duong on 11/08/2021.
//

import SwiftUI

struct NewsPage: View {
    @StateObject private var store: NewsDetailStore
    
    init(news: News) {
        _store = StateObject(wrappedValue: NewsDetailStore(news: news))
    }
    
    var body: some View {
        Group {
            switch store.selectedSegment {
            case .web:
                WebPage(
                    state: $store.state,
                    webView: store.webView
                )
            case .smart:
                SmartPage(news: store.news)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                SegmentedControl(segment: $store.selectedSegment)
            }
        }
    }
}
