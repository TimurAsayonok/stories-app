import Foundation
import StoriesAppModels
import StoriesAppCore

public class StoriesViewModel: ObservableObject {
    public enum Direction {
        case next, previous
    }
    
    @Published var stories: [Story] = []
    @Published var indexToPresent: Int = 0
    let user: User
    private let service: ApiServiceProtocol = ApiService()
    private var presentUser: (Direction) -> Void
    private var persistenceService: StoriesPersistence

    public init(
        user: User,
        persistenceService: StoriesPersistence,
        presentUser: @escaping (Direction) -> Void
    ) {
        self.user = user
        self.presentUser = presentUser
        self.persistenceService = persistenceService
        loadOrFetchStories()
    }
    
    func loadOrFetchStories() {
        if let persistedStories = persistenceService.loadStories(for: user.id), !persistedStories.isEmpty {
            stories = persistedStories
        } else {
            fetchStories()
        }
        getIndexToPresent()
    }

    func fetchStories() {
        let fetchedStories = service.getStrories(for: user.id)
        stories = fetchedStories
        persistenceService.persistStories(fetchedStories, for: user.id)
    }
    
    func getIndexToPresent() {
        indexToPresent = stories.firstIndex(where: { $0.isSeen == false }) ?? stories.count - 1
    }
    
    func moveToNextStory() {
        markStoryAsSeen(index: indexToPresent)
        if indexToPresent < stories.count - 1 {
            indexToPresent += 1
        } else {
            onUserChanged(to: .next)
        }
    }
    
    func moveToPreviousStory() {
        if indexToPresent > 0 {
            indexToPresent -= 1
        } else {
            onUserChanged(to: .previous)
        }
    }
    
    func markStoryAsSeen(index: Int) {
        if stories.indices.contains(index) {
            let story = stories[index]
            updateStory(story) { $0.isSeen = true }
        }
    }
    
    func toggleLike(for story: Story) {
        updateStory(story) { $0.isLiked.toggle() }
    }
    
    private func updateStory(_ story: Story, update: (inout Story) -> Void) {
        if let index = stories.firstIndex(where: { $0.id == story.id }) {
            var updatedStory = stories[index]
            update(&updatedStory)
            stories[index] = updatedStory
            persistenceService.persistStories(stories, for: user.id)
        }
    }

    private func onUserChanged(to direction: Direction) {
        presentUser(direction)
    }
}

