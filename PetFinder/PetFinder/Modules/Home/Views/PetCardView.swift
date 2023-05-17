//
//  PetCardView.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 17.05.2023.
//

import SwiftUI

struct PetCardView: View {
    let viewModel: HomeViewModelProtocol
    @State private var isTapped: Bool = false

    var body: some View {
        VStack {
            HStack {
                ServiceImageView(url: service.imageUrl,
                                 isIcon: !service.hasImageFile,
                                 isTile: isTile,
                                 imageRenderingMode: service.imageRenderingMode)
                    .frame(alignment: .center)
                    .isVisible(!isTile)

                VStack(alignment: .leading, spacing: Semantic.dimension.spacing.none) {

                    Text(showCategoryName ? service.parentName ?? "Основные услуги" : service.serviceName)
                        .foregroundColor(serviceTypeForegroundColor(selected: isTapped))
                        .font(.tertiaryText.lowEmphasis)
                        .lineLimit(.parentCategoryLines)

                    Text(service.serviceName)
                        .foregroundColor(serviceNameForegroundColor(selected: isTapped))
                        .multilineTextAlignment(.leading)
                        .lineLimit(.serviceNameLines)
                        .font(isTile ? .primaryText.highEmphasis : .secondaryText.mediumEmphasis)
                        .padding(.vertical, Semantic.dimension.spacing.semiSmall)

                    Spacer(minLength: Semantic.dimension.spacing.small)
                        .isVisible(!isTile)

                    Text(service.priceDescription)
                        .foregroundColor(priceForegroundColor(selected: isTapped))
                        .font(.secondaryText.highEmphasis)
                }
                .padding(.leading, isTile ? Semantic.dimension.spacing.semiMedium : Semantic.dimension.spacing.none)

                Spacer(minLength: Semantic.dimension.spacing.semiMedium)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isTapped = true
            viewModel.openPetDetails(with: pet.id)
        }
        .onChange(of: isTapped, perform: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isTapped = false
            }
        })
        .frame(maxWidth: .infinity)
        .padding(.vertical, Semantic.dimension.spacing.semiMedium)
        .background(backgroundColor(selected: isTapped))
        .clipRoundCorners()
    }
}

// MARK: - Colors

extension PetCardView {

    private func serviceNameForegroundColor(selected: Bool) -> Color {
        return selected ? Semantic.Rebranding.color.basic.onBg.onAccent.value.color : Semantic.Rebranding.color.basic.onBg.primary.value.color
    }

    private func serviceTypeForegroundColor(selected: Bool) -> Color {
        return selected ? Semantic.Rebranding.color.basic.onBg.onAccent.value.color : Semantic.Rebranding.color.basic.onBg.secondary.value.color
    }

    private func priceForegroundColor(selected: Bool) -> Color {
        return selected ? Semantic.Rebranding.color.basic.onBg.onAccent.value.color : Semantic.Rebranding.color.basic.bg.accent.value.color
    }

    private func backgroundColor(selected: Bool) -> Color {

        if selected {
            return Semantic.Rebranding.color.chips?.active.value.color ?? Semantic.color.accent_main_button.value.color
        }
        return Semantic.Rebranding.color.basic.bg.foreground.value.color
    }

}

// MARK: - DIMENSIONS

private extension Int {
    static let petNameLines: Int = 2
    static let parentCategoryLines: Int = 1
}

// MARK: - LOCALIZATION

private extension String {
    static let othersName = "".localized()
}
