//
//  PetCardView.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 17.05.2023.
//

import SwiftUI

struct PetCardView: View {
    let viewModel: HomeViewModel
    @State private var isTapped: Bool = false

    var body: some View {
        VStack {
            HStack {
                Image("style.off")
                    .frame(alignment: .center)

                VStack(alignment: .leading) {

                    Text("pett")
                        // .foregroundColor(serviceTypeForegroundColor(selected: isTapped))
                       // .font(.tertiaryText.lowEmphasis)
                        .lineLimit(.petNameLines)

                    Text("pet.serviceName")
                       // .foregroundColor(serviceNameForegroundColor(selected: isTapped))
                        .multilineTextAlignment(.leading)
                        .lineLimit(.petNameLines)
                       // .font(isTile ? .primaryText.highEmphasis : .secondaryText.mediumEmphasis)
                        .padding(.vertical, 4)

                    Text("pet.priceDescription")
                        // .foregroundColor(priceForegroundColor(selected: isTapped))
                       // .font(.secondaryText.highEmphasis)
                }
                .padding(.leading, 16)

                Spacer(minLength: 16)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isTapped = true
            // viewModel.openPetDetails(with: pet.id)
        }
        .onChange(of: isTapped, perform: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isTapped = false
            }
        })
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        // .clipRoundCorners()
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
