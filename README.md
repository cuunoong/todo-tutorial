# Todo App Flutter with Supabase and FCA-CLI

🎥 **Watch the Full Tutorial on YouTube:**  
[![Watch on YouTube](https://img.youtube.com/vi/hCmsU81MlwA/maxresdefault.jpg)](https://youtu.be/hCmsU81MlwA)

Tutorial project for building a **Todo App** using **Supabase** and **FCA-CLI** with a **Clean Architecture** approach.

## Features

-   **Clean Architecture** structure using FCA-CLI.
-   **Supabase** integration for database CRUD operations.
-   Simple, scalable, and professional codebase.

## Prerequisites

1. [FCA-CLI](https://www.npmjs.com/package/fca-cli)
2. [Supabase](https://supabase.com/docs) account and API keys.
3. Flutter SDK and NPM installed on your machine.

## Getting Started

### Step 1: Clone the Repository

```bash
git clone https://github.com/cuunoong/todo-tutorial
cd todo-tutorial
```

### Step 2: Install Dependencies

Run the following command to get all dependencies:

```bash
flutter pub get
```

### Step 3: Set Up Supabase

1. Create a project in Supabase.
2. Set up your database schema for the Todo app.
3. Copy your API keys and set them in your `lib/core/dependencies/dependencies_main.dart` file.

```dart
    await Supabase.initialize(
        url: "YOUR_SUPABASE_URL",
        anonKey: "YOUR_SUPABAES_ANON_KEY",
    );
```

### Step 4: Run the App

Run the app on your emulator or physical device:

```bash
flutter run
```

## Resources

-   [FCA-CLI](https://www.npmjs.com/package/fca-cli)
-   [Supabase Documentation](https://supabase.com/docs)

## Support

For questions or requests, feel free to reach out via email: [arif19iskandar@gmail.com](mailto:arif19iskandar@gmail.com).

## Social Media

-   TikTok: [@cuunoong](https://tiktok.com/@cuunoong)
-   Instagram: [@cuunoong](https://instagram.com/cuunoong)

## Contributing

Feel free to fork the repository and submit a pull request for improvements.

## License

This project is licensed under the [MIT License](LICENSE).

---

Thank you for checking out this project! Don’t forget to **star** the repo if you find it useful.
