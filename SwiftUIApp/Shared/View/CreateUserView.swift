//
//  CreateUserView.swift
//  SwiftUIApp (iOS)
//
//  Created by Admin on 09.09.2022.
//

import SwiftUI

struct CreateUserView: View {
  @ObservedObject private(set) var viewModel: CreateUserViewModel
  @Environment(\.presentationMode) private var presentationMode

  var body: some View {
    Form {
      CommonFormSection(viewModel: viewModel)
    }
    .onReceive(viewModel.$isDone) {
      guard $0 else { return }

      presentationMode.wrappedValue.dismiss()
    }
    .padding()
    .navigationTitle("User's registration")
  }
}

struct CreateUserView_Previews: PreviewProvider {
  static var previews: some View {
    CreateUserView(viewModel: CreateUserViewModel())
  }
}
