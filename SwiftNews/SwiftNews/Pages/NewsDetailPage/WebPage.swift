//
//  WebPage.swift
//  SwiftNews
//
//  Created by Dao Duy Duong on 12/08/2021.
//

import SwiftUI
import WebKit

struct WebPage: View {
    @Binding var state: LoadingState
    let webView: WKWebView
    
    var body: some View {
        ZStack {
            GeometryReader { g in
                WebView(webView: webView)
                    .frame(width: g.size.width, height: g.size.height)
            }
            
            if state == .loading {
                ProgressView()
            }
        }
    }
}

fileprivate extension WebPage {
    
    struct WebView: UIViewRepresentable {
        let webView: WKWebView
        
        func makeUIView(context: Context) -> WKWebView  {
            webView
        }
        
        func updateUIView(_ uiView: WKWebView, context: Context) {}
    }
}
