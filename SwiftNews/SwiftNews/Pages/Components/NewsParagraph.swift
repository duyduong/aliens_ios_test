//
//  NewsParagraph.swift
//  SwiftNews
//
//  Created by Dao Duy Duong on 11/08/2021.
//

import SwiftUI
import SwiftRichString

struct NewsParagraph: View {
    let paragraphs: [News.Paragraph]
    @StateObject private var textViewStore = TextViewStore()
    
    var body: some View {
        GeometryReader { geometry in
            TextViewWrapper(
                paragraphs: paragraphs,
                maxLayoutWidth: geometry.maxWidth,
                textViewStore: textViewStore
            )
        }
        .frame(minHeight: textViewStore.height)
    }
}

extension GeometryProxy {
    var maxWidth: CGFloat {
        size.width - safeAreaInsets.leading - safeAreaInsets.trailing
    }
}

fileprivate extension NewsParagraph {
    
    struct TextViewWrapper: UIViewRepresentable {
        let paragraphs: [News.Paragraph]
        let maxLayoutWidth: CGFloat
        let textViewStore: TextViewStore
        
        private static var defaultStyle: StyleXML {
            let base = Style {
                $0.font = UIFont.preferredFont(forTextStyle: .body)
                $0.color = UIColor.label
            }
                    
            let link = Style {
                $0.underline = (NSUnderlineStyle.single, UIColor.systemBlue)
                $0.color = UIColor.systemBlue
            }
            
            let header = Style {
                $0.font = UIFont.preferredFont(forTextStyle: .title3)
                $0.traitVariants = .bold
            }
            
            let note = Style {
                $0.font = UIFont.preferredFont(forTextStyle: .caption1)
                $0.traitVariants = .italic
                $0.alignment = .center
            }

            return StyleXML(base: base, ["a": link, "h3": header, "alt": note])
        }
        
        func makeUIView(context: Context) -> CustomTextView {
            let textView = CustomTextView(textViewStore: textViewStore)
            textView.backgroundColor = .clear
            textView.textContainerInset = .zero
            textView.isEditable = false
            textView.isScrollEnabled = false
            textView.textContainer.lineFragmentPadding = 0
            
            return textView
        }

        func updateUIView(_ uiView: CustomTextView, context: Context) {
            uiView.attributedText = buildAttributedString()
            uiView.maxLayoutWidth = maxLayoutWidth
        }
        
        private func buildAttributedString() -> NSAttributedString {
            let attributedText = NSMutableAttributedString()
            for paragraph in paragraphs {
                switch paragraph.type {
                case .text:
                    attributedText.append(buildTextParagraph(paragraph.texts))
                case .img:
                    attributedText.append(buildImageParagraph(url: paragraph.url!, texts: paragraph.texts))
                }
                
                attributedText.append(NSAttributedString(string: "\n\n"))
            }
            
            return attributedText
        }
        
        private func buildImageParagraph(url: String, texts: [News.TextContent]) -> AttributedString {
            let richString = """
            <img url="\(url)" />
            <alt>\(texts.richString)</alt>
            """
            return richString.set(style: Self.defaultStyle)
        }
        
        private func buildTextParagraph(_ texts: [News.TextContent]) -> AttributedString {
            return texts.richString.set(style: Self.defaultStyle)
        }
    }
    
    final class CustomTextView: UITextView {
        let textViewStore: TextViewStore
        
        init(textViewStore: TextViewStore) {
            self.textViewStore = textViewStore
            super.init(frame: .zero, textContainer: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        var maxLayoutWidth: CGFloat = 0 {
            didSet {
                guard maxLayoutWidth != oldValue else { return }
                invalidateIntrinsicContentSize()
            }
        }
        
        override var contentSize: CGSize {
            didSet {
                textViewStore.setHeight(contentSize.height)
            }
        }
        
        override var intrinsicContentSize: CGSize {
            guard maxLayoutWidth > 0 else {
                return super.intrinsicContentSize
            }
            
            return sizeThatFits(
                CGSize(width: maxLayoutWidth, height: .greatestFiniteMagnitude)
            )
        }
    }
    
    final class TextViewStore: ObservableObject {
        @Published private(set) var height: CGFloat?
        
        func didUpdateTextView(_ uiView: CustomTextView) {
            self.height = uiView.intrinsicContentSize.height
        }
        
        func setHeight(_ value: CGFloat) {
            self.height = value
        }
    }
}


