# TECHNICAL DESIGN DOCUMENT

### Introduction

This document outlines the architecture and components of a production application deployed on the cloud with best practices used for
a. Secrets Management
b. Infrastructure as Cloud
c. Continuous Integration /Continuous Deployment

### Architecture Overview

The application follows a client-server architecture where Node.js backend serves as the server-side logic and data processing layer, while the React frontend acts as the client-side user interface.

The Nodejs Server is deployed on Google App Engine with Frontend being served through CDN.

### Components

#### 1. Backend (Node.js)

##### 1.1 Technologies Used

- Node.js
- Express.js
- Pino for Logging
- MongoDB
- TypeScript (for strict type-based programming)
- Jest (For testing)
- Helmet (For Header Configuration and Security against common web vulnerabilities)
- Volta (Pin Node & NPM versions)
- Honeycomb.io for observability

##### 1.2 Backend Components (TBA)

#### 2. Frontend (ReactJS)

##### 2.1 Technologies Used

- ReactJS
- Axios (for API calls)
- Material-UI (for UI components)
- TypeScript (for strict type-based programming)
- React Hooks (For State management)

##### 2.2 Frontend Components (TBA)

#### 3. Cloud Provider (Google Cloud)

##### 3.1 Services Used

- Google App Engine to deploy Backend
- CDN for Frontend
- Workforce Identity Federation to interface with Vault
- MongoDB Atlas for Database

#### 4. Secrets Management

- Utilize HashiCorp Vault for secure storage and management of
  - Mongodb Database Credentials
  - Okta Account Credentials
  - Terraform Account Credentials
  - Github Actions Credentials

#### 5. Infrastructure Management

- Manage infrastructure resources using Terraform to provision and maintain cloud resources efficiently.
- GCP resources managed using this are
  - Google App Engine versions
  - Virtual Private Clouds & Subnets
  - Firewall rules for Server, CDN

#### 6. User Management

- Customer identities on the application are managed using Okta.
  - OIDC used to handle authentication
  - React SDK to request token on client and provide it in requests to server.

#### 7. Communication

- The frontend communicates with the backend through RESTful APIs.
  API endpoints are defined in the backend for CRUD operations and other functionalities.

#### 8. Monitoring and Logging

- Logging of backend using Pino logger
- Monitoring using Google Cloud's Monitoring Solution.

### Conclusion

This technical design document demonstrates a robust and scalable solution that leverages industry-leading tools and practices. By incorporating HashiCorp Vault, Terraform, GitHub Actions, Okta, and Docker, the application can deliver a secure, efficient, and cost-effective user experience.

---

### Improvements Expected above this design

- Cost Benefits comparison for each component and reason for selection.
- Scaling using Load Balancing of Server, Database and Vault Clusters.
- Leveraging Google Security Suites like Google Cloud Armor
