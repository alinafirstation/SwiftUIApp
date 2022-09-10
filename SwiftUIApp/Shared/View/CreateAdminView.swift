//
//  CreateAdminView.swift
//  SwiftUIApp (iOS)
//
//  Created by Admin on 09.09.2022.
//

import SwiftUI

struct CreateAdminView: View {
  @ObservedObject var viewModel: CreateUserViewModel

  var body: some View {
    Form {
      Section {
        TextField("Admin", text: $viewModel.adminRole)
      }
      CommonFormSection(viewModel: viewModel)
    }
    .padding()
    .navigationTitle("Admin's registration")
  }
}

struct CreateAdminView_Previews: PreviewProvider {
  static var previews: some View {
    CreateAdminView(viewModel: CreateUserViewModel())
  }
}
