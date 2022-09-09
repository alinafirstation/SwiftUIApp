//
//  UserItem.swift
//  SwiftUIApp (iOS)
//
//  Created by Admin on 09.09.2022.
//

import SwiftUI

struct UserItem: View {
  @State private(set) var user: User

  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(user.name)
        Text(user.surname)
      }
      Spacer()
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .padding(.vertical, 0.5)
  }
}

struct UserItem_Previews: PreviewProvider {
  static var previews: some View {
    UserItem(user: User(name: "Dima", surname: "Doroshchuk"))
  }
}
