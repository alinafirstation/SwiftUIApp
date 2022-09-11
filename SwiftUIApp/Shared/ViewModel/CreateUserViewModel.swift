//
//  CreateUserViewModel.swift
//  SwiftUIApp (iOS)
//
//  Created by Admin on 07.09.2022.
//

import Foundation
import SwiftUI
import Combine

class CreateUserViewModel: ObservableObject, Identifiable {
  var id: Int = 1

  @Published var name = ""
  @Published var surname = ""
  @Published var adminRole = ""

  @Published private(set) var createdUser: User?
  @Published var successViewModel: SuccessViewModel?

  private var cancellables = Set<AnyCancellable>()

  var isValid: Bool {
    !name.isEmpty && !surname.isEmpty
  }

  func createUser() {
    createdUser = User(name: name, surname: surname, admin: adminRole)
  }
}
