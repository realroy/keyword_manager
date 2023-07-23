# Keyword Manager

## Requirements

- Ruby 3.2.2
- Redis
- Postgres 14+
- Chrome

## Installation

1. Install [foreman](https://github.com/ddollar/foreman)

```sh
gem install foreman
```

2. Install gems

```sh
bundle install
```

3. Copy .env.sample and rename to .env

```sh
cp .env.sample .env
```

4. (Optional) Update variable in env

5. Create Database and migrate

```sh
rails db:create db:migrate
```

## Checklist

### Web UI

- [x] Sign in. **(/users/sign_in)**
- [x] Sign up. **(/users/sign_up)**
- [x] Upload a keyword file. **(/keywords/upload)**
- [x] View list of keywords. **(/keywords)**
- [x] View the search result information for each keyword. **(/keywords/:id)**
- [x] Search across all reports. **(/keywords?q=)**

### API (optional) auth with JWT

- [x] Sign in **([POST] /api/users/sign_in)**
- [x] Get the list of keywords. **([GET] /api/keywords)**
- [x] Upload a keyword file. **([PUT] /api/keywords/upload)**
- [x] Get the search result information for each keyword. **([GET] /api/keywords/:id)**

### Technical Requirements

- [x] Use Ruby on Rails (7.x.x).
- [x] Use PostgreSQL.
- [x] For the interface, front-end frameworks such as Bootstrap, Tailwind or Foundation can be used. Use SASS as the CSS preprocessor.
      Extra points will be provided to the neatness of the frontend. **(Tailwind)**
- [x] Use Git during the development process. Push to a public repository on Github or Gitlab. Make regular commits and merge code using pull requests **(Github)**
- [x] Write tests using your framework of choice. **(Rspec and Capybara)**
