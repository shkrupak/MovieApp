
MovieApp

MovieApp is a simple iOS application that allows users to search for movies, view their details, and save favorites. The app uses The Movie Database (TMDb) API to fetch movie information and provides offline support through CoreData.

----------------------------------------------------


Features:

Home Page: Displays a list of popular movies.

Search Page: Users can search movies by title and view recently searched titles.

Detail Page: Shows detailed information about a selected movie, including title, release date, poster image, and overview.

Favorites Page: Users can save movies to a favorites list for later reference.

Offline Support: Previously fetched movie data is persisted using CoreData and available even when offline.

Pagination: Search results are paginated for improved performance.


----------------------------------------------------


Third-Party Libraries

SDWebImage
: Used for image caching.

Note: Run pod install to install the library before building the project.


----------------------------------------------------


Technical Implementation

CoreData: Used to persist movies and favorite lists. Data is loaded from CoreData when the app starts in offline mode.

Pagination: Implemented in the search view to efficiently load large datasets.

Favorites: Users can mark movies as favorites, which are also persisted using CoreData.


----------------------------------------------------

Folder Structure

MovieApp
├── Application          # AppDelegate, SceneDelegate, and app configuration
├── Helper               # Helper classes
├── MoviesAppiOS         # All feature modules
│   ├── Home
│   │   ├── Controller
│   │   ├── Model
│   │   ├── Service
│   │   ├── View
│   │   └── ViewModel
│   ├── Favorite
│   ├── MovieDetail
│   └── Search
├── Networking           # API constants and related files
├── Resources            # App resources (colors, fonts, info.plist)
└── Utilities            # Manager classes (CoreDataManager, NetworkManager)


----------------------------------------------------

Challenges

One of the main challenges in this project was working with CoreData. I had limited prior experience with it, which could have been a hurdle. However, I enjoy exploring new technologies and learning as I go. By researching documentation and following tutorials, I was able to quickly understand and implement CoreData effectively.


----------------------------------------------------



Project Decisions

Offline Mode: CoreData was chosen to persist data for offline access.

Image Caching: SDWebImage ensures smooth image loading and reduces network usage.

Pagination: Implemented to handle large search results efficiently.

MVVM Architecture: Used for better separation of concerns and maintainable code.


----------------------------------------------------


How to Build and Run

1. Clone the repository:

git clone <repository-url>


2. Navigate to the project directory:

cd MovieApp


3. Install dependencies using CocoaPods:

pod install


4. Open MovieApp.xcworkspace in Xcode.

5. Build and run the project on a simulator or device.


----------------------------------------------------


