//
//  Film.swift
//  Demo
//
//  Created by Jingfu Li on 2025/3/11.
//

class Film: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var posterURL: String = ""
    @Persisted var title: String = ""
    @Persisted var rating: Float = 0
}
