//
//  Photo.swift
//  InstagramLayout
//
//  Created by Andrea Stevanato on 28/01/21.
//

import UIKit

struct Photo {
    let id = UUID()
    let image: UIImage
}

extension Photo: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Photo {
    static var demoPhotos: [Photo] {
        let names = (1...12).map({ "photo\($0)" })
        return names.map({ Photo(image: UIImage(named: $0)!) })
    }
}
