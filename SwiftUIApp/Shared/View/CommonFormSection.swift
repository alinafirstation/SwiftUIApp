//
//  CommonFormSection.swift
//  SwiftUIApp (iOS)
//
//  Created by Admin on 09.09.2022.
//

import SwiftUI

struct CommonFormSection: View {
  @ObservedObject private(set) var viewModel: CreateUserViewModel

  var body: some View {
    Section(header: Text("Your information")) {
      TextField("Name", text: $viewModel.name)
      TextField("Surname", text: $viewModel.surname)

      Button("Sign up") {
        viewModel.createUser()
      }
      .font(.title2)
      .frame(maxWidth: .infinity)
      .frame(height: 50, alignment: .center)
      .background(Color.blue)
      .foregroundColor(.white)
      .cornerRadius(12)
      .opacity(viewModel.isValid ? 1 : 0.2)
      .disabled(!viewModel.isValid)
    }
    .background(successfulRegistration)
  }

  private var successfulRegistration: some View {
    let binding = Binding<Bool>(
      get: { viewModel.successViewModel != nil },
      set: { _ in viewModel.successViewModel = nil }
    )
    return NavigationLink("", isActive: binding) {
      if let viewModel = viewModel.successViewModel {
        SuccessView(viewModel: viewModel)
      }
    }
  }
}

struct CommonFormSection_Previews: PreviewProvider {
  static var previews: some View {
    Form {
      CommonFormSection(viewModel: CreateUserViewModel())
    }
  }
}
