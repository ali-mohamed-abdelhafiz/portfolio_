<div align="center">
  <img src="assets/profile.jpg" width="150" height="150" style="border-radius: 50%;">
  <h1>Ali Mohamed - Flutter Developer Portfolio</h1>
  <p>A professional, highly modular, and fully responsive portfolio application built with Flutter.</p>

  <div>
    <a href="https://www.linkedin.com/in/ali-mohamed-950215286/"><img src="https://img.shields.io/badge/LinkedIn-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"></a>
    <a href="https://github.com/AliMoo-space"><img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"></a>
    <a href="https://wa.me/201551713043"><img src="https://img.shields.io/badge/WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white" alt="WhatsApp"></a>
    <a href="https://drive.google.com/drive/folders/1axHapRU2vwj_838B8KlsThV3VgEh1oTa?usp=sharing"><img src="https://img.shields.io/badge/CV-Google_Drive-4285F4?style=for-the-badge&logo=google-drive&logoColor=white" alt="Download CV"></a>
  </div>
</div>

---

## 🚀 Overview

Hi, I'm **Ali Mohamed**, a passionate Flutter Developer. 
I am actively seeking new opportunities where I can contribute, grow, and deliver high-quality results. I am available for both remote and on-site positions and committed to continuous improvement.

This repository contains my personal portfolio website, engineered to showcase my skills, projects, and professional background. It serves not just as a resume, but as a testament to my coding standards, utilizing a clean and scalable **Lightweight Feature-Based Architecture**, proper state management with **Cubit**, and robust API handling via **Dio**.

## ✨ Key Features

- **Fully Responsive UI**: Adapts flawlessly to Mobile, Tablet, and Desktop environments using structural constraints.
- **Dynamic Projects Fetching**: Integrates with the GitHub API to fetch and display the latest repositories directly on the site.
- **Dark & Light Mode**: Clean theme toggling mechanism mapped directly into the UI state.
- **Beautiful Animations**: Smooth entrance, hover effects, typewriting text, and crisp typography using `flutter_animate` and `animated_text_kit`.
- **Form Validation**: Fully operational contact form with validation logic prior to submission.
- **Modern Developer Aesthetic**: Tailored and polished look, designed to feel extremely premium.

## 🏗 Architecture & Design Patterns

I chose a **Lightweight Feature-Based Architecture** tailored for maximum maintainability while keeping the boilerplate minimal. 
The app categorizes concerns neatly (Core, Presentation, Data) allowing the codebase to be easily digestible for recruiters and other developers.

- **`core/`**: Houses app-wide resources, including network clients (`DioClient`), theme tokens (`AppTheme`), and dependency injection setups (`get_it`).
- **`features/portfolio/`**: Encapsulates the entire domain of the portfolio:
  - **`data/`**: Models and Repositories handling the GitHub API data.
  - **`presentation/`**: Organized UI split into `screens` (HomePage), `sections` (Hero, About, Skills, Projects, Contact), reusable `widgets` (NavBar), and Business Logic Components (`cubit`).

## 🧠 State Management: Cubit (`flutter_bloc`)

State management is handled via **Cubit**.
By strictly separating business logic from UI, screens remain cleanly focused on rendering. Cubit maps deterministic state transitions accurately (e.g., `ProjectsLoading` -> `ProjectsLoaded`), guaranteeing a scalable and robust testing path.

## 🛠 Tech Stack

- **Framework**: Flutter 3.x
- **State Management**: `flutter_bloc`
- **Network Client**: `dio`
- **Dependency Injection**: `get_it`
- **Animations**: `flutter_animate`, `animated_text_kit`
- **Persisted Storage**: `shared_preferences` (theme preferences)
- **Responsive Sizing**: `flutter_screenutil`
- **Icons**: `font_awesome_flutter`, `cupertino_icons`

## 📁 Folder Structure

```
lib/
├── core/
│   ├── api/          # Dio network client and config
│   ├── di/           # Service Locator (get_it) setup
│   └── theme/        # AppTheme defining tokens and ThemeCubit
└── features/
    └── portfolio/
        ├── data/     # ProjectModel and ProjectsRepository (GitHub API)
        └── presentation/
            ├── cubit/     # Portfolio state handling
            ├── screens/   # Main layouts
            ├── sections/  # Logical pages (Hero, About, Skills, Projects, Contact)
            └── widgets/   # Interactive elements (Navbar, Cards, Buttons)
```

## 🔧 Getting Started

1. Ensure you have the [Flutter SDK](https://flutter.dev/docs/get-started/install) installed.
2. Clone this repository:
   ```bash
   git clone https://github.com/AliMoo-space/portfolio.git
   ```
3. Navigate to the project directory:
   ```bash
   cd portfolio
   ```
4. Fetch the dependencies:
   ```bash
   flutter pub get
   ```
5. Run the project:
   ```bash
   flutter run
   ```

## 📬 Contact Me

Feel free to reach out if you're looking for a dedicated Flutter Developer or just want to connect!

- **WhatsApp**: [+20 155 171 3043](https://wa.me/201551713043)
- **LinkedIn**: [Ali Mohamed](https://www.linkedin.com/in/ali-mohamed-950215286/)
- **Email/Contact**: Reachable through the portfolio's contact form.
