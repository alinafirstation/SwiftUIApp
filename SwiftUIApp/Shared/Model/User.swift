//
//  User.swift
//  SwiftUIApp (iOS)
//
//  Created by Admin on 09.09.2022.
//

import Foundation

struct User: Identifiable {
  let id = UUID()
  var name: String
  var surname: String
  var admin: String?
}
