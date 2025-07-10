# Summit

> **AI-Driven Development**
>
> This project is built as an experiment in AI-first software development. All issues, pull requests, and code changes are managed and updated using AI tools such as Cursor AI and others. The goal is to build my own personal toolbelt, focusing on rapid iteration and learning by prompting and collaborating with AI. This approach allows for fast prototyping, continuous improvement, and hands-on experience with modern AI-driven workflows.
> 
> While some changes may be tweaked by hand, the default action is to try to solve each problem at hand using an AI agent.

A personal compass for life - track your health, habits, and happiness with clarity.

## Overview

Summit is a Rails application designed to help users track and improve their personal well-being. Built with modern web technologies, it provides a clean, intuitive interface for monitoring health metrics, building positive habits, and maintaining overall happiness.

## Features

- **User Authentication**: Secure login and registration system using Devise
- **Responsive Design**: Beautiful, mobile-friendly interface built with Tailwind CSS
- **Modern UI**: Clean, minimalist design inspired by Notion and Linear
- **Mountain Theme**: Subtle mountain illustrations and warm-to-cool color gradients
- **Restricted Access**: Currently limited to authorized users for controlled rollout

## Tech Stack

- **Ruby**: 3.4.4
- **Rails**: 8.0.2
- **Database**: PostgreSQL
- **Frontend**: Tailwind CSS, JavaScript (esbuild)
- **Authentication**: Devise
- **Testing**: Rails system tests, model tests
- **Deployment**: Heroku-ready with Docker support

## Prerequisites

- Ruby 3.4.4
- Node.js (for asset compilation)
- PostgreSQL
- pnpm package manager

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/joshrowley/summit.git
   cd summit
   ```

2. **Install Ruby dependencies**
   ```bash
   bundle install
   ```

3. **Install JavaScript dependencies**
   ```bash
   pnpm install
   ```

4. **Set up the database**
   ```bash
   rails db:create
   rails db:migrate
   ```

5. **Start the development server**
   ```bash
   bin/dev
   ```

The application will be available at `http://localhost:3000`

## Development

### Running Tests

```bash
# Run all tests
rails test

# Run system tests only
rails test:system

# Run specific test files
rails test test/models/user_test.rb
```

### Asset Compilation

```bash
# Compile JavaScript assets
pnpm build

# Compile CSS assets
pnpm build:css

# Watch for changes during development
pnpm build --watch
```

### Database

```bash
# Create and migrate database
rails db:create db:migrate

# Reset database
rails db:reset

# Run seeds (if any)
rails db:seed
```

## Authentication

The application uses Devise for user authentication with the following features:

- Email-based registration and login
- Password confirmation
- Remember me functionality
- Secure password hashing with bcrypt

**Note**: Currently, user registration is restricted to a specific email address for controlled access.

## Project Structure

```
app/
├── controllers/          # Application controllers
├── models/              # ActiveRecord models
├── views/               # View templates
│   ├── devise/          # Authentication views
│   ├── layouts/         # Application layouts
│   └── pages/           # Static pages
├── assets/              # Frontend assets
│   ├── images/          # Images including favicons
│   └── stylesheets/     # CSS files
└── javascript/          # JavaScript files

config/
├── routes.rb            # Application routes
├── database.yml         # Database configuration
└── initializers/        # Rails initializers

test/
├── models/              # Model tests
├── system/              # System tests
└── controllers/         # Controller tests
```

## Deployment

### Heroku

The application is configured for Heroku deployment:

1. **Set up Heroku app**
   ```bash
   heroku create your-app-name
   ```

2. **Add buildpacks**
   ```bash
   heroku buildpacks:add heroku/ruby
   heroku buildpacks:add heroku/nodejs
   ```

3. **Set environment variables**
   ```bash
   heroku config:set RAILS_ENV=production
   heroku config:set SECRET_KEY_BASE=$(rails secret)
   ```

4. **Deploy**
   ```bash
   git push heroku main
   heroku run rails db:migrate
   ```

### Docker

A Dockerfile is included for containerized deployment:

```bash
docker build -t summit .
docker run -p 3000:3000 summit
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Testing

The application includes comprehensive test coverage:

- **Model Tests**: User validation and business logic
- **System Tests**: End-to-end user interactions
- **Controller Tests**: API endpoint functionality

Run the full test suite:
```bash
rails test:all
```

## License

This project is private and proprietary. All rights reserved.

## Support

For support or questions, please contact the development team or create an issue in the repository.

---

Built with ❤️ using Rails 8 and modern web technologies.
