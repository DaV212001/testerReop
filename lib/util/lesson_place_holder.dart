



String laravelDescription = '''
Laravel is a PHP web application framework designed for web artisans. Here are some key points about Laravel:

1. Expressive and Elegant Syntax:
   - Laravel provides an expressive and elegant syntax, allowing developers to create web applications without getting bogged down by small details.
   - Clean code is emphasized, making it enjoyable for developers to write and maintain.

2. Model-View-Controller (MVC) Architecture:
   - Laravel follows the MVC architectural pattern.
   - It separates application logic into three components:
     - Model: Represents the data and business logic.
     - View: Handles presentation and user interface.
     - Controller: Manages user input and interacts with the model and view.

3. Common Features:
   - Laravel includes built-in solutions for common web application features:
     - Authentication: Easily set up user authentication and authorization.
     - Eloquent ORM: A powerful and expressive database query builder.
     - Database Migrations: Manage database schema changes.
     - Validation: Validate user input data.
     - Notifications & Mail: Send emails and notifications.
     - File Storage: Handle file uploads and storage.
     - Job Queues: Manage background tasks.
     - Task Scheduling: Automate recurring tasks.
     - Testing: Laravel provides a robust testing experience.

4. Flexible Frontend Options:
   - Laravel can be paired with various frontend technologies:
     - Livewire: Build full-stack applications in PHP using Laravel and Livewire.
     - Inertia: Create monolithic React or Vue-driven frontends alongside Laravel.
     - Next.js: Use Laravel as a backend API for Next.js applications.

5. Additional Tools and Packages:
   - Laravel offers a rich ecosystem of packages:
     - Laravel Octane: Supercharges application performance.
     - Laravel Vapor: Serverless deployment platform powered by AWS Lambda.
     - Laravel Forge: Simplifies server management.
     - Breeze: Lightweight starter kit for new applications.
     - Cashier: Subscription management for Stripe or Paddle.
     - Dusk: Automated browser testing.
     - Echo: Listens for WebSocket events.
     - Envoyer: Zero-downtime deployment.
     - Herd: Fast local development experience (macOS).

Laravel empowers developers to build modern PHP web applications efficiently and elegantly. Whether you're a seasoned developer or just starting out, Laravel provides a delightful development experience. 🚀

Learn more about Laravel in the official documentation: Laravel Documentation
''';


Map<String, dynamic> lessonData = {
  "success": true,
  "message": "Data get successfully",
  "data": {
    "id": 1,
    "image": "https://th.bing.com/th/id/OIP.RmnSs_BYHekF1vmqonuRQgHaEN?rs=1&pid=ImgDetMain",
    "title": "Introducing Laravel",
    "description": laravelDescription,
    "subcategory_id": "1",
    "level_id": "1",
    "created_at": null,
    "updated_at": null,
    "subcategory": {
      "id": 1,
      "image": "Image",
      "name": "Laravel",
      "category_id": "1",
      "created_at": null,
      "updated_at": null
    },
    "level": {
      "id": 1,
      "name": "Level 1",
      "created_at": null,
      "updated_at": null
    }
  }
};