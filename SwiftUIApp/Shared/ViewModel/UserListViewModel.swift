//
//  UserListViewModel.swift
//  SwiftUIApp (iOS)
//
//  Created by Admin on 09.09.2022.
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

  @Published private(set) var users = [User(name: "Alina", surname: "Cherepanova")]
  @Published private(set) var admins = [User(name: "Dima", surname: "Doroshchuk", admin: "Admin")]
  @Published var actionSheetOpen = false
  @Published var route: Route?
  private var cancellables = Set<AnyCancellable>()

  func addNewUser(_ user: User) {
    users.append(user)
  }

  func addNewAdmin(_ user: User) {
    admins.append(user)
  }

  func createAdminViewModel() {
    let viewModel = CreateUserViewModel()
    viewModel.closeScenario
      .sink { [weak self] in
        if let user = viewModel.createdUser {
          self?.addNewAdmin(user)
        }
        self?.route = nil
      }
      .store(in: &cancellables)

    route = .createAdmin(viewModel)
  }

  func createUserViewModel() {
    let viewModel = CreateUserViewModel()
    viewModel.closeScenario
      .sink { [weak self] in
        if let user = viewModel.createdUser {
          self?.addNewUser(user)
        }
        self?.route = nil
      }
      .store(in: &cancellables)

    route = .createUser(viewModel)
  }
}
