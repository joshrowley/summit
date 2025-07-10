# Summit

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

2. **Set the authorized email**
   
   The application restricts registration to a specific email address for security. Set the `AUTHORIZED_EMAIL` environment variable to your authorized email address:
   
   ```bash
   export AUTHORIZED_EMAIL="your@email.com"
   ```
   
   You can add this to your shell profile or a `.env` file if using a tool like dotenv.

3. **Install Ruby dependencies**
   ```bash
   bundle install
   ```

4. **Install JavaScript dependencies**
   ```bash
   pnpm install
   ```

5. **Set up the database**
   ```bash
   rails db:create
   rails db:migrate
   ```

6. **Start the development server**
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

**Note**: Registration is restricted to the email address specified in the `AUTHORIZED_EMAIL` environment variable. If not set, it defaults to `authorized@example.com`.

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

See [LICENSE](LICENSE) for details. This project is provided for personal and educational purposes only. Commercial use is prohibited without explicit permission from the author.

## Support

For support or questions, please contact the development team or create an issue in the repository.

---

Built with ❤️ using Rails 8 and modern web technologies.
