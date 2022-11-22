//
//  Task.swift
//  Routeens
//
//  Created by Selene on 11/2/22.
//

import Foundation

struct Task: Identifiable, Codable {
   var id = UUID()
   var name: String
   var pending: Bool
}
