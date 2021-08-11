//
//  AsyncImage.swift
//  SwiftNews
//
//  Created by Dao Duy Duong on 11/08/2021.
//

import SwiftUI
import Combine
import AlamofireImage

let imageDownloader = ImageDownloader(
    configuration: ImageDownloader.defaultURLSessionConfiguration(),
    downloadPrioritization: .fifo,
    maximumActiveDownloads: 4,
    imageCache: AutoPurgingImageCache()
)

extension ImageDownloader {
    func image(for url: URL) -> AnyPublisher<UIImage?, Never> {
        return Future { promise in
            let urlRequest = URLRequest(url: url)
            imageDownloader.download(urlRequest, completion:  { response in
                switch response.result {
                case .success(let image):
                    promise(.success(image))
                case .failure(let error):
                    print(">>> ImageDownloader load image failed", error)
                }
            })
        }
        .eraseToAnyPublisher()
    }
}

struct AsyncImage<Placeholder: View>: View {
    
    private let placeholder: Placeholder
    private let url: URL
    
    init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
        self.url = url
        self.placeholder = placeholder()
    }
    
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
            } else {
                placeholder
            }
        }
        .onReceive(imageDownloader.image(for: url), perform: { image in
            self.image = image
        })
    }
}
