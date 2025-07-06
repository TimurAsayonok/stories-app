//
//  ContentView.swift
//  StoriesApp
//

import SwiftUI
import StoriesAppHomePageFeature
import StoriesAppCore
import StoriesAppStoriesFeature

struct ContentView: View {
    var body: some View {
        StoriesHomePageView(
            viewModel: StoriesHomePageViewModel(
                persistenceService: StoriesPersistence(),
                service: StoriesAppHomePageFeature.ApiService(jsonLoader: LocalJSONLoader()),
                storiesApiService: StoriesAppStoriesFeature.ApiService()
            )
        )
    }
}
