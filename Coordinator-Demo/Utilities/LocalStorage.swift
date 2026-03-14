//
//  LocalStorage.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import Foundation

final class LocalStorage {
    static let shared = LocalStorage()
    private let defaults = UserDefaults.standard

    private enum Keys {
        static let onboardingComplete = "onboarding_complete"
    }

    func shouldShowOnboarding() -> Bool {
        !defaults.bool(forKey: Keys.onboardingComplete)
    }

    func setOnboardingStatus(isComplete: Bool) {
        defaults.set(isComplete, forKey: Keys.onboardingComplete)
    }

    /// Reset for testing — call this to re-trigger onboarding
    func resetOnboarding() {
        defaults.removeObject(forKey: Keys.onboardingComplete)
    }
}
