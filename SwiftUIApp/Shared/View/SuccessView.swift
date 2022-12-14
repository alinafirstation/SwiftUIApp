//
//  SuccessView.swift
//  SwiftUIApp (iOS)
//
//  Created by Admin on 09.09.2022.
//

import SwiftUI
import Combine

struct SuccessView: View {
  @ObservedObject private(set) var viewModel: SuccessViewModel

  var body: some View {
    VStack {
      Text("You have successfully registered!")
        .font(.title3)
        .padding()
      Spacer()
    }
    .navigationTitle("Success")
    .navigationBarItems(
      trailing: Button(action: {
        viewModel.close()
      }) {
        Text("Done")
      }
    )
  }
}

struct SuccessView_Previews: PreviewProvider {
  static var previews: some View {
    SuccessView(viewModel: SuccessViewModel())
  }
}
