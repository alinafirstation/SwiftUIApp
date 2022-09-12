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
  private(set) var id: Int = 1

  @Published var name = ""
  @Published var surname = ""
  @Published var adminRole = ""

  @Published private(set) var createdUser: User?
  @Published var successViewModel: SuccessViewModel?
  @Published var isDone = false

  init() {
    $createdUser
      .compactMap { $0 }
      .map { [weak self] _ in
        guard let self = self else { return nil }
        let viewModel = SuccessViewModel()
        viewModel.onDoneTapped
          .map { true }
          .assign(to: &self.$isDone)
        return viewModel
      }
      .assign(to: &$successViewModel)
  }

  var isValid: Bool {
    !name.isEmpty && !surname.isEmpty
  }

  func createUser() {
    createdUser = User(name: name, surname: surname, admin: adminRole)
  }
}
