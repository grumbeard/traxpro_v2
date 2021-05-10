# TRAXPRO (v2)
## Issue tracking web application for Construction and Facilities Management industries

**Goal**: Design and build a RESTful web app for efficient tracking and reporting of issues across multiple projects / buildings
- MVP ([Traxpro v1](https://github.com/grumbeard/traxpro)) presented at first ever [Le Wagon Singapore](https://www.lewagon.com/singapore) showcase event (2019)

**Live Link**: 👉 http://traxpro2.herokuapp.com

## About Traxpro
The idea for Traxpro began with `@teanj`'s personal frustration with available solutions for issue tracking in the Construction industry. Issues were often not reported in a standardize manner, often having unclear descriptions of the problem and site location. This was exacerbated by language barriers experienced between subcontractors, workers, and project managers.

Our team of 3 aspiring developers (`@teanj`, `@justafterdark` and `@grumbeard`) sought to create a new app from scratch that would meet the following objectives
- Complete MVP within 2 weeks
- Minimize custom input by pre-defining issue categories and sub-categories which can simply be selected 
- Minimize potentially unclear descriptive text by visually excapsulating location information (via pins placed directly on building floor plans)
- Allow Issue Reporter to track and update status of issue resolution
- Allow direct communication within the context of the issue, between Issue Reporter and appointed Issue Resolvers

### Key Features
- Project Owners can create projects, upload building plans, and appoint a pool of subcontractors to manage all issues associated with the project
- Issue Reporter can report issues and assign specific Issue Resolvers to them
- Once Issue Reporters have verified satisfactory resolution of an issue, they can mark an issue as resolved
- Issues can be filtered by whether they are Open / Pending / Completed
- Issue Reporters may pin issues directly on uploaded floor plans to automatically capture location information with zero text input
- Issue Reporters may view all issues pinned on a particular floor plan in 'Map View' and navigate directly to the pin of concern
- Issue Reporters and Issue Resolvers can chat via a messaging interface within the context of a single issue (provide more details / progress updates / photos)

## Technologies
Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.
- **Framework**: Ruby on Rails
- **Database**: PostgreSQL
- **Frontend**: HTML, CSS / SCSS, Bootstrap, JavaScript ES6, AJAX, Cloudinary
- **Authentication**: Devise (gem)
- **Project management**: Trello

## Screenshots
### Login and Project Creation
![image](https://user-images.githubusercontent.com/51464365/117615074-cf3f2000-b19b-11eb-8501-dea67293bf95.png)

### Reporting an Issue
![image](https://user-images.githubusercontent.com/51464365/117615118-debe6900-b19b-11eb-85aa-ae9e2c95579a.png)

### Viewing Issue Details and Interacting with Subcontractor
![image](https://user-images.githubusercontent.com/51464365/117615196-f5fd5680-b19b-11eb-9abb-b6a4ee122592.png)


