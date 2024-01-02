## Goal
This is a simple ping-pong application consisting of frontend and backend. The requirement is to create runtime infrastructure and deploy the applications.

# Definition of Done
* IaC for the runtime environment that is scalable, reliabile, and easily operatable
* Build and Deploy pipeline
* Architecture Diagram
* Brief documentation with rationale for the technical decisions

# Application Detail
## Frontend
* ReactJS application 
* Node version 18.17.0
* Takes environment variable `REACT_APP_API_BASE_URL` that contains the base URL of the backend application. E.g.: `REACT_APP_API_BASE_URL=http://localhost:8080`
## Backend
* Spring Boot application
* Java version 17

# Procedure to Submit Response
1. Fork this repo
2. Add diagrams to docs/diagrams/ directory
3. Add documentation in markdown format to docs/ directory
4. Add IaC, pipeline, and other necessary codes
5. Create a pull request


