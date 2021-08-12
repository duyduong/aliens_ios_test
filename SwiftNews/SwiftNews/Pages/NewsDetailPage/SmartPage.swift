//
//  SmartPage.swift
//  SwiftNews
//
//  Created by Dao Duy Duong on 12/08/2021.
//

import SwiftUI

struct SmartPage: View {
    let news: News
    
    var body: some View {
        ScrollView {
            VStack {
                Text(news.title)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 5)
                
                HStack {
                    Text(news.author)
                        .font(.body)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(news.date)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                AsyncImage(url: news.postImageURL) {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                
                NewsParagraph(paragraphs: news.paragraphs)
            }
            .padding(.horizontal)
        }
    }
}
