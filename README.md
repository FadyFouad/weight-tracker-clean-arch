# Weight Tracker Demo

# Clean architecture 
Riverpod approaches & Bloc $ Sqflite $ getit

This app is built using the Clean Architecture design pattern, utilizing the following technologies:

- Bloc &  Riverpod for state management.
- Firebase for user authentication and database storage
- SQFlite for local storage of weight entries when no Internet Connection.


# Clean Architecture in Flutter

Clean Architecture is a software design pattern that separates the concerns of your application into layers. It helps to create a maintainable, testable, and scalable codebase.

## Implementation

In Flutter, Clean Architecture can be implemented using the following:
- **Bloc** for state management
- **Dependency Injection** for managing dependencies
- **Repositories** for accessing data from different sources

### Layers
- **Presentation** - This layer contains the views and widgets that the user interacts with. It communicates with the **Bloc** layer for any changes in state.
- **Bloc** - This layer contains the business logic and communicates with the **Repository** layer for data.
- **Repository** - This layer is responsible for accessing data from different sources such as **Firebase**, **SQLite**, or **REST API**.

Advantages
- Separation of Concerns - Each layer has a specific responsibility and is independent of the others.
- Easy to Test - Each layer can be tested separately and mocking dependencies is easier.
- Scalable - As the application grows, new features can be added without affecting the existing code.

If you have any questions or feedback, please contact us at [fady.fouad.a@gmail.com](fady.fouad.a@gmail.com).


![alt text](https://github.com/FadyFouad/weight_tracker_task/blob/main/screenshots/1.jpeg?raw=true)
![alt text](https://github.com/FadyFouad/weight_tracker_task/blob/main/screenshots/2.jpeg?raw=true)
![alt text](https://github.com/FadyFouad/weight_tracker_task/blob/main/screenshots/3.mp4?raw=true)
![alt text](https://github.com/FadyFouad/weight_tracker_task/blob/main/screenshots/4.png?raw=true)
![alt text](https://github.com/FadyFouad/weight_tracker_task/blob/main/screenshots/5.png?raw=true)
