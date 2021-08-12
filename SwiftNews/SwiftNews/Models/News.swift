//
//  News.swift
//  SwiftNews
//
//  Created by Dao Duy Duong on 11/08/2021.
//

import Foundation

enum TextStyle {
    case normal
    case header
    case link(String)
}

struct News: Decodable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case title, url, date, author, extern
        case postImageUrl, paragraphs
    }
    
    struct Paragraph: Decodable {
        enum ParagraphType: String, Decodable {
            case text, img
        }
        
        var type: ParagraphType
        var texts: [TextContent]
        var url: String?
    }
    
    struct TextContent: Decodable {
        enum Style: String, Decodable {
            case normal, link, header
        }
        
        var style: Style
        var text: String
        var url: String?
    }
    
    var id = UUID()
    var title: String
    var url: URL
    var date: String
    var author: String
    var extern: String
    var postImageURL: URL
    var paragraphs: [Paragraph]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decode(URL.self, forKey: .url)
        date = try container.decode(String.self, forKey: .date)
        author = try container.decode(String.self, forKey: .author)
        extern = try container.decode(String.self, forKey: .extern)
        postImageURL = try container.decode(URL.self, forKey: .postImageUrl)
        paragraphs = try container.decode([Paragraph].self, forKey: .paragraphs)
    }
}

extension Collection where Element == News {
}

extension Collection where Element == News.TextContent {
    
    var richString: String {
        map { content -> String in
            switch content.style {
            case .normal:
                return content.text
            case .header:
                return "<h3>\(content.text)</h3>"
            case .link:
                return "<a href=\"\(content.url!)\">\(content.text)</a>"
            }
        }
        .joined()
    }
}
