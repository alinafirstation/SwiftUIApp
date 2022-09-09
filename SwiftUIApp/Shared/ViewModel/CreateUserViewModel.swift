//
//  CreateUserViewModel.swift
//  SwiftUIApp (iOS)
//
//  Created by Admin on 09.09.2022.
//

import SwiftUI
import Combine

class CreateUserViewModel: ObservableObject, Identifiable {
  var id: Int = 1

  @Published var name = ""
  @Published var surname = ""
  @Published var adminRole = ""

  @Published private(set) var createdUser: User?
  @Published var successViewModel: SuccessViewModel?

  let closeScenario = PassthroughSubject<Void, Never>()

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
      .map { [weak self] _ in
        self?.createdSuccessViewModel
      }
      .sink { [weak self] in
        self?.successViewModel = $0
      }
      .store(in: &cancellables)
  }

  private var createdSuccessViewModel: SuccessViewModel {
    let viewModel = SuccessViewModel()
    viewModel.onDoneTapped
      .sink { [weak self] in
        self?.closeScenario.send()
      }
      .store(in: &cancellables)

    return viewModel
  }
}
