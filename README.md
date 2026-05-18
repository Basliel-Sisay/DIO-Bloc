# Post App Using Bloc and Dio

<table border="1" cellspacing="0" cellpadding="8">
  <thead>
    <tr>
      <th>Name</th>
      <th>ID</th>
      <th>Section</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Basliel Sisay</td>
      <td>UGR/3563/16</td>
      <td>2</td>
    </tr>
  </tbody>
</table>

Flutter application designed to demonstrate essential CRUD (Create, Read, Update, Delete) operations using advanced state management and robust RESTful API integration. The application connects to the publicly available JSONPlaceholder API to simulate interacting with a live web server database

## Features

- Create new post entries
   
- Read/view all posts from API

- Update post titles and content
  
- Delete post listings
  
- Mock data persistence (ID 101 tracking)
  
- Real time UI list updates
  
- Input form validation
  
- Loading state indicators
  
- Error handling and reporting
  
## Technical Architecture

The project is built on a structured architecture that isolates data models, network logic, state management, and the UI components

 - Data Layer (Models): The data layer utilizes a structured Post model that maps raw incoming JSON strings into Dart objects using factory constructors (fromJson) and serializes local data back into JSON payloads via the toJson method

- Network Layer (Services): External communication is isolated within a dedicated PostService that utilizes a centralized Service class (configured with Dio) to execute asynchronous GET, POST, PUT and DELETE network requests based on strict HTTP status code validations

- State Management Layer (Bloc): Application state changes are controlled by a PostBloc component that handles unidirectional data flow. It receives explicit PostEvent triggers (such as LoadPostsEvent, CreatePostEvent, and UpdatePostEvent), processes asynchronous execution streams and emits immutable PostState changes to the user interface
  
- Presentation Layer (UI Screens): The presentation layer uses a two-screen layout consisting of a PostDashboardScreen (the main scrollable hub) and a PostFormerScreen (a dynamic, validated input form that handles both entry creation and record updates natively)
