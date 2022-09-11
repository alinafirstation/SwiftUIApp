//
//  SuccessViewModel.swift
//  SwiftUIApp (iOS)
//
//  Created by Admin on 09.09.2022.
//

import SwiftUI
import Combine

class SuccessViewModel: ObservableObject, Identifiable {
  let id = UUID()
  let onDoneTapped = PassthroughSubject<Void, Never>()

  func close() {
    onDoneTapped.send()
  }
}
