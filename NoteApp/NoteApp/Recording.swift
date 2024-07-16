//
//  Recording.swift
//  NoteApp
//
//  Created by Ali Haidar on 15/07/24.
//

import Foundation

struct Recording : Equatable {
    let id = UUID()
    let fileURL : URL
    let createdAt : Date
    var isPlaying : Bool
    
}
