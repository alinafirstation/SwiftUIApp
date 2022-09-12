//
//  UserListView.swift
//  SwiftUIApp (iOS)
//
//  Created by Admin on 09.09.2022.
//

import SwiftUI

struct UserListView: View {
  @StateObject private var viewModel = UserListViewModel()

  var body: some View {
    NavigationView {
      ScrollView {
        LazyVStack(spacing: 0) {
          ForEach(viewModel.admins + viewModel.users) { user in
            UserItem(user: user)
          }
        }
        .cornerRadius(16)
      }
      .navigationBarItems(trailing:
                            Button(action: {
        viewModel.actionSheetOpen.toggle()
      }) {
        Image(systemName: "plus")
      }
                            .actionSheet(isPresented: $viewModel.actionSheetOpen) {
        actionSheet
      }
      )
      .background(
        navigation
      )
      .navigationTitle("Common list")
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }

  private var navigation: some View {
    EmptyView()
      .sheet(item: $viewModel.route) { route in
        NavigationView {
          switch route {
          case let .createUser(viewModel): CreateUserView(viewModel: viewModel)
          case let .createAdmin(viewModel): CreateAdminView(viewModel: viewModel)
          }
        }
      }
  }

  private var actionSheet: ActionSheet {
    ActionSheet(title: Text("Select:"), buttons: [
      .default(Text("User"), action: {
        viewModel.createUserViewModel()
      }),
      .default(Text("Admin"), action: {
        viewModel.createAdminViewModel()
      }),
      .cancel()
    ])
  }
}

struct UserListView_Previews: PreviewProvider {
  static var previews: some View {
    UserListView()
  }
}
