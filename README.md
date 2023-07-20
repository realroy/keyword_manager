# README

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
