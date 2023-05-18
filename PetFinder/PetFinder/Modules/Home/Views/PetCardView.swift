//
//  PetCardView.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 17.05.2023.
//

import SwiftUI

struct PetCardView: View {
    let viewModel: HomeViewModel
    let pet: Animal

    @State private var isTapped: Bool = false

    var body: some View {
        VStack {
            HStack {
                Image("style.off")
                    .frame(alignment: .center)

                VStack(alignment: .leading) {

                    Text(pet.name ?? "")
                        .lineLimit(.petNameLines)

                    Text(pet.age ?? "")
                        .multilineTextAlignment(.leading)
                        .lineLimit(.petNameLines)
                        .padding(.vertical, 4)

                    Text(pet.gender)
                }
                .padding(.leading, 16)

                Spacer(minLength: 16)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isTapped = true
        }
        .onChange(of: isTapped, perform: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isTapped = false
            }
        })
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
    }
}

// MARK: - Colors



// MARK: - DIMENSIONS

private extension Int {
    static let petNameLines: Int = 2
    static let parentCategoryLines: Int = 1
}

// MARK: - LOCALIZATION

private extension String {
    static let othersName = ""
}
