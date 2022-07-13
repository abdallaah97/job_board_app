<div id="top"></div>
<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://www.zenhr.com/ar/about">
    <img src="https://s3.amazonaws.com/akhtaboot_public/zenhrsolutions/zenhr-solutions.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">job board</h3>

  <p align="center">
    Manage job posts by admin and allow job seekers to apply on posts
    <br />
    <br />
    <a href="https://job-board-test-zen-hr.herokuapp.com/api-docs/index.html">View Swagger Demo</a>
  </p>
</div>

<!-- ABOUT THE PROJECT -->
## About the techniques used

* Use sqlite3 database in development and test environments.
* Use PostgreSQL database in production environment (Heroku not suppor sqlite3).

* Use JWT to authorize users.
* Use cancancan to manage users roles.

* Use swagger to auto document APIs.


<!-- GETTING STARTED -->
## Getting Started Online

You can start with the APIs that published online in heroku from 
<a href="https://job-board-test-zen-hr.herokuapp.com/api-docs/index.html"> here</a>.

## Getting Started Locally

You can run app and use the APIs locally after follow few steps.

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/abdallaah97/job_board_app.git
   ```
2. Install Bundles
   ```sh
   bundle install
   ```
3. Install database
   ```sh
   rails db:migrate
   rails db:migrate rails_env=test
   ```
4. Seed data (To add admin user)
    ```sh
    rails db:seed
    rails db:seed rails_env=test
    ```
5. Run the project
    ```sh
    rails server
    ```
### Swagger
Go to the link to open swagger document: http://localhost:3000/api-docs/index.html

## Bonus tasks
* Implement search for Jobs by title or creation date
* Add Expiry date to the job post so it won't apper to the job seeker after a specific date
* Send emails to the user (Job Seeker) once the application is seen (but need to the email credentials).
