//
//  NewsListPage.swift
//  SwiftNews
//
//  Created by Dao Duy Duong on 09/08/2021.
//

import SwiftUI

struct NewsListPage: View {
    
    @EnvironmentObject var newsListStore: NewsListStore
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(newsListStore.news, id: \.id) { news in
                    NavigationLink(
                        destination: NewsPage(news: news),
                        label: {
                            NewsItem(news: news)
                        })
                }
            }
        }
        .navigationBarTitle("News")
    }
}

struct NewsItem: View {
    
    let news: News
    
    var body: some View {
        HStack {
            VStack {
                Text(news.title)
                    .bold()
                    .lineLimit(2)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                
                HStack {
                    Text(news.date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(alignment: .leading)
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "ellipsis")
                    })
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.trailing, 5)
            
            AsyncImage(url: news.postImageURL) {
                ProgressView()
            }
            .frame(width: 140, height: 80)
            .scaledToFit()
        }
        .padding(.all, 10)
    }
}

struct NewsListPage_Previews: PreviewProvider {
    static var previews: some View {
        NewsListPage()
            .environmentObject(NewsListStore())
    }
}
