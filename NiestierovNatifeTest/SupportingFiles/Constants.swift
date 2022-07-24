//
//  Constants.swift
//  NiestierovNatifeTest
//
//  Created by Denys Niestierov on 22.07.2022.
//

import Foundation

struct Constants {
    
    struct Controllers {
        static let postListViewController = "PostListViewController"
        static let postDetailsViewController = "PostDetailsViewController"
    }
    
    struct URL {
        static let postList = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
    }
    
    struct Segue {
        static let goToPostDetails = "goToPostDetails"
    }
    
    struct Cell {
        static let postTableViewCell = "PostTableViewCell"
    }
    
}
