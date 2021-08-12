//
//  NewsDetailStore.swift
//  SwiftNews
//
//  Created by Dao Duy Duong on 12/08/2021.
//

import WebKit
import Combine

class NewsDetailStore: ObservableObject {
    
    @Published var selectedSegment: Segment = .web
    @Published var state: LoadingState = .loading
    let news: News
    
    let webView = WKWebView()
    private var subscription: AnyCancellable?
    
    init(news: News) {
        self.news = news
        
        webView.load(URLRequest(url: news.url))
        subscribe()
    }
    
    private func subscribe() {
        subscription?.cancel()
        subscription = webView.publisher(for: \.isLoading)
            .sink { [weak self] value in
                self?.state = value ? .loading : .finished
            }
    }
}
