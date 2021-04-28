# Table of contents
- [DevOps Course](#DevOps-Course)
- [Node.js Weight Tracker](#Node.js-Weight-Tracker)


# DevOps Course
* DevOps course consist on "WeightTracker" app (https://github.com/reverentgeek/node-weight-tracker), which used to demonstrate common DevOps tools, such as:
	* Azure Platform
	* Terraform for IaC
	* Jenkins for pipelines creation
	* Ansible for configuration management
* Those tools can be found in the "DevOps_Tools" directory, in addition to a ReadMe files, which elaborate about the usage of the tools.
* The repository of "WeightTracker" app was copied to this repository for gaining the ability to edit and add DevOps essential files (such as "Jenkinsfile"). 


# Node.js Weight Tracker

![Demo](docs/build-weight-tracker-app-demo.gif)

This sample application demonstrates the following technologies.

* [hapi](https://hapi.dev) - a wonderful Node.js application framework
* [PostgreSQL](https://www.postgresql.org/) - a popular relational database
* [Postgres](https://github.com/porsager/postgres) - a new PostgreSQL client for Node.js
* [Vue.js](https://vuejs.org/) - a popular front-end library
* [Bulma](https://bulma.io/) - a great CSS framework based on Flexbox
* [EJS](https://ejs.co/) - a great template library for server-side HTML templates

**Requirements:**

* [Node.js](https://nodejs.org/) 12.x or higher
* [PostgreSQL](https://www.postgresql.org/) (can be installed locally using Docker)
* [Free Okta developer account](https://developer.okta.com/) for account registration, login

## Install and Configuration

1. Clone or download source files
2. Run `npm install` to install dependencies
3. If you don't already have PostgreSQL, set up using Docker
4. Create a [free Okta developer account](https://developer.okta.com/) and add a web application for this app
5. Copy `.env.sample` to `.env` and change the `OKTA_*` values to your application
6. Initialize the PostgreSQL database by running `npm run initdb`
7. Run `npm run dev` to start Node.js

The associated blog post goes into more detail on how to set up PostgreSQL with Docker and how to configure your Okta account.