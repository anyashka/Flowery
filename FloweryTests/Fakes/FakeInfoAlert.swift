//
//  FakeInfoAlert.swift
//  FloweryTests
//

import UIKit

@testable import Flowery

final class FakeInfoAlert: InfoAlert {

    var simulatedCompletion: (() -> Void)?
    var lastReceivedInfo: [String?] = []

    func show(
        on viewController: UIViewController,
        title: String,
        message: String?,
        buttonTitle: String,
        acceptanceCompletion: (() -> Void)?) {
        lastReceivedInfo = [title, message]
        simulatedCompletion = acceptanceCompletion
    }

    func simulateAcceptance() {
        simulatedCompletion?()
    }
}
