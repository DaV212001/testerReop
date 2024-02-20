# MSS Programming Learning App

## Project Description

- The Programming Learning System aims to provide an engaging and effective platform for users to programming languages through structured courses, quizzes, and certifications. The system manages user accounts, learning sessions, course content, and verifications.

## Table of Contents

- [Git and Pull Request](#git-and-pull-request)
- [Naming Conventions](#naming-conventions)
- [Folder Structure](#folder-structure)
- [Project Resources](#project-resources)
- [Other Resources](#other-resources)

## Git and Pull Request

In this project we will try to make our git messages and pull requests standardized and easy to manage . Please follow these guides when making changes to the codebase:
This project uses git flow for version control. Please make sure that all of your work is done in a feature branch off of development. When you're ready to merge your changes back into development,

`**Notice:** Never try to send a pull request to the main branch because the only time we are going to merge a pull request is after we accomplish phase one (v1.0.0) of the website so try to send a pull request to the development branch`

- I have provided a pull request template in the .github file for you to use when sending a pull request add a description and screen shot for the feature you have work on along side with the Trello card ID.
- There is a sample document to use when git commiting and we will be using the industry level commit messaging technique named: [Convectional Commit](https://www.conventionalcommits.org/en) try to follow that guideline or the file in the root named **GIT_MESSAGE_TEMPLAE.md**

### Naming Conventions

- **Files:**
    - Use snake_case for naming files.
      `**home_screen.dart**`

- **Classes:**
    - Use PascalCase for naming files.
      `**HomeScreen**`

### Folder Structure
#### config/
    Contains configurations for the application preferences settings, and themes.

#### controller/
    Manages controllers responsible for handling business logic and data flow within the application.

#### layout/
    Holds layout components responsible for defining the structure and appearance of different screens or sections within the application.

    auth/
        Contains layout components related to authentication screens, such as headers and footers for sign-in and sign-up screens.

    home/
        Includes layout components related to the home section of the application, such as navigation bars and post lists.

    profile
        Contains layout components related to user profiles and account settings screens, such as profile headers and settings forms.

#### model/
    Defines data models used throughout the application to represent entities such as posts, users, or settings.

#### screen/
    Manages screen components responsible for defining the user interface and behavior of different screens within the application.
    auth/
        Contains screens related to authentication, such as sign-in and sign-up screens.
    home/
        Includes screens related to the home section of the application.
    profile/
        Contains screens related to user profiles and account settings.

#### service/
    Handles service-related functionalities, including network requests, data fetching, and authentication.

#### util/
    Provides utility functions and helper classes used across the application for common tasks such as managing constants, defining routes, and assisting with UI operations.

#### widget/
    Contains reusable widget components that can be used across different screens or sections within the application without requiring individual folders.



## Project Resources

- **Basic Flutter:**
    - https://www.youtube.com/playlist?list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ
- **GetX :**
    - https://blog.logrocket.com/ultimate-guide-getx-state-management-flutter/
    - https://www.youtube.com/watch?v=XDWT1RXwQQQ&list=PL26uY6-lIzqkmvpNr9gMCrIvl8k5Mqrhs
    - https://github.com/Mashood97/Flutter-Getx-Projects/tree/master
    - https://pub.dev/packages/get
    - https://chornthorn.github.io/getx-docs/

- **Other Resources:**
  - 
