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

  let createViewModel = PassthroughSubject<Void, Never>()

  private var cancellables = Set<AnyCancellable>()

  var isValid: Bool {
    !name.isEmpty && !surname.isEmpty
  }

  init() {
    bind()
  }

  func createUser() {
    createdUser = User(name: name, surname: surname, admin: adminRole)
  }

  private func bind() {
    $createdUser
      .compactMap { $0 }
      .sink { [weak self] _ in
        self?.createViewModel.send()
      }
      .store(in: &cancellables)
  }
}
