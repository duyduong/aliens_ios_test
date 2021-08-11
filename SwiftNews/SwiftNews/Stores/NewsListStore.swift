//
//  NewsListStore.swift
//  SwiftNews
//
//  Created by Dao Duy Duong on 09/08/2021.
//

import UIKit
import Combine

class NewsListStore: ObservableObject {
    @Published var news: [News] = []
    
    init() {
        if let asset = NSDataAsset(name: "news") {
            let data = asset.data
            do {
                let news = try JSONDecoder().decode([News].self, from: data)
                self.news = news
            } catch {}
        }
    }
}
