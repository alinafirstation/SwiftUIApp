//
//  UserListViewModel.swift
//  SwiftUIApp (iOS)
//
//  Created by Admin on 07.09.2022.
//

import Foundation
import Combine

class UserListViewModel: ObservableObject {
  enum Route: Identifiable {
    var id: UUID {
      UUID()
    }
    case createUser(CreateUserViewModel)
    case createAdmin(CreateUserViewModel)
  }

  private(set) var users = [User(name: "Alina", surname: "Cherepanova")]
  private(set) var admins = [User(name: "Dima", surname: "Doroshchuk", admin: "Admin")]
  @Published var actionSheetOpen = false
  @Published var route: Route?

  private var cancellables = Set<AnyCancellable>()

  func createUserViewModel() {
    let viewModel = CreateUserViewModel()
    viewModel.$createdUser
      .compactMap { $0 }
      .sink { [weak self] user in
        self?.users.append(user)
      }.store(in: &cancellables)

    route = .createUser(viewModel)
  }

  func createAdminViewModel() {
    let viewModel = CreateUserViewModel()
    viewModel.$createdUser
      .compactMap { $0 }
      .sink { [weak self] user in
        self?.admins.append(user)
      }.store(in: &cancellables)

    route = .createAdmin(viewModel)
  }
}
