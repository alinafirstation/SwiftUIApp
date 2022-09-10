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
    case successResponse(SuccessViewModel)
  }

  @Published private(set) var users = [User(name: "Alina", surname: "Cherepanova")]
  @Published private(set) var admins = [User(name: "Dima", surname: "Doroshchuk", admin: "Admin")]
  @Published var actionSheetOpen = false
  @Published var route: Route?
  @Published var successViewModel: SuccessViewModel?

  private var cancellables = Set<AnyCancellable>()

  func addNewUser(_ user: User) {
    users.append(user)
  }

  func addNewAdmin(_ user: User) {
    admins.append(user)
  }

  func createUserViewModel() {
    //TODO: Question - Корректно ли здесь использовать dropFirst (если используем PassthroughSubject) ? Если убрать dropFirst - не происходит добавление пользователей, если оставить - кнопка Sign Up срабатывает со второго раза (то же самое в методе createAdminViewModel())
    let viewModel = CreateUserViewModel()
    viewModel.createViewModel
      .dropFirst()
      .sink { [weak self] in
        if let user = viewModel.createdUser {
          self?.addNewUser(user)
        }
        self?.createSuccessViewModel()
      }
      .store(in: &cancellables)

    route = .createUser(viewModel)
  }

  func createAdminViewModel() {
    let viewModel = CreateUserViewModel()
    viewModel.createViewModel
      .dropFirst()
      .sink { [weak self] in
        if let user = viewModel.createdUser {
          self?.addNewAdmin(user)
        }
        self?.createSuccessViewModel()
      }
      .store(in: &cancellables)

    route = .createAdmin(viewModel)
  }

  func createSuccessViewModel() {
    let viewModel = SuccessViewModel()
    viewModel.onDoneTapped
      .sink { [weak self] in
        self?.route = nil
      }
      .store(in: &cancellables)

    route = .successResponse(viewModel)
  }
}
