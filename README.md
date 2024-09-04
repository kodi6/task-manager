
# Task Management Web Application

## Overview

This is a simplified task management web application SaaS built using Elixir and the Phoenix Framework. It allows users to create, update, delete, and list tasks. Each task includes a title, description, due date, and status. The application supports multiple users, each with their own set of tasks.

## Architecture and Design Decisions

### Architecture Overview

- **User Management:** Manages user creation and management with the `TaskManager.Accounts` module.
- **Task Management:** Handles tasks through the `TaskManager.Tasks` module and SQLite database.
- **API Layer:** Exposes RESTful endpoints using `UserController` and `TaskController`.
- **Database:** Utilizes SQLite for storing user and task data.
- **Functional Programming:** Employs immutability and pure functions for clean and maintainable code.
- **Concurrency:** Leverages Phoenix’s concurrency features to manage multiple requests efficiently.
- **Error Handling:** Includes robust error handling and logging to ensure stability and assist with debugging.
- **Testing:** Uses `ExUnit` for unit and integration tests to verify application functionality.

### Design Decisions

- **Elixir and Phoenix:** Selected for their scalability and efficient handling of concurrent users.
- **SQLite:** Chosen for its simplicity and ease of setup, ideal for smaller-scale applications.
- **Functional Programming:** Ensures predictability and maintenance by avoiding side effects.
- **RESTful API:** Provides a standard method for interacting with the application.
- **Phoenix Concurrency:** Manages multiple simultaneous requests efficiently with lightweight processes.
- **Error Handling and Logging:** Maintains application stability and aids in debugging with detailed error management.
- **Testing:** Ensures correctness and early issue detection with comprehensive testing.

## Setup and Usage

### Prerequisites

-**Elixir:** Ensure Elixir is installed. Download from [elixir-lang.org](https://elixir-lang.org/install.html).
 -**Phoenix Framework:** Install the Phoenix mix archive if not already installed:
  ```
 mix archive.install hex phx_new
```
### Clone the Repository

```
git@github.com:kodi6/task-manager.git
```

### Install Dependencies

```
mix deps.get
```
### Set Up the Database

```
mix ecto.create
mix ecto.migrate

```
### Start the Phoenix Server

```
mix phx.server
```
### Using Postman for API Testing

Let's start testing our endpoints.
1. Create a New User:

- Method: POST
- URL: http://localhost:4000/api/users                          
- Body: (form-date) you can also give in raw jason format.
- Body:
Key: user[name], Value: John Doe
Key: user[email], Value: john@example.com

- Output:
```			{
				"data": {
					"id": "6ab16ea0-f23a-4b64-86ee-2dbfa3561da1",
					"name": "John Doe",
					"email": "john@example.com"
				}
			}
```
- Save the "id".

2. Create a New Task:

- Method: POST
- URL: http://localhost:4000/api/users/:user_id/tasks
- Body Type: form-data
- Body:
Key: task[title], Value: Sample Task
Key: task[description], Value: This is a sample task.
Key: task[due_date], Value: 2024-12-31
Key: task[status], Value: To Do
Key: task[user_id], Value: 6ab16ea0-f23a-4b64-86ee-2dbfa3561da1 #### use saved id

- Output:
```			{
				"data": {
					"id": "ebac4c2b-a23d-4c70-bbef-e52288786501",
					"status": "To Do",
					"description": "This is a sample task.",
					"title": "Sample Task",
					"due_date": "2024-12-31",
					"user_id": "6ab16ea0-f23a-4b64-86ee-2dbfa3561da1"
				}
			}
```
- Repeat this step to create more tasks.

3.Retrieve All Tasks for a User:

- Method: GET
- URL: http://localhost:4000/api/users/:user_id/tasks #### use saved id

- Output:
```				{
					"data": [
						{
							"id": "ebac4c2b-a23d-4c70-bbef-e52288786501",
							"status": "To Do",
							"description": "This is a sample task 1.",
							"title": "Sample Task",
							"due_date": "2024-12-31",
							"user_id": "6ab16ea0-f23a-4b64-86ee-2dbfa3561da1"
						},
						{
							"id": "07832ffd-197b-4d19-9e48-31c2686ef949",
							"status": "To Do",
							"description": "This is a sample task 2.",
							"title": "Sample Task",
							"due_date": "2024-12-31",
							"user_id": "6ab16ea0-f23a-4b64-86ee-2dbfa3561da1"
						}
					]
				}
```
4. Retrieve a Specific Task:

- Method: GET
- URL: http://localhost:4000/api/users/:user_id/tasks/:task_id

- Output:
```				{
					"data": {
						"id": "07832ffd-197b-4d19-9e48-31c2686ef949",
						"status": "To Do",
						"description": "This is a sample task 2.",
						"title": "Sample Task",
						"due_date": "2024-12-31",
						"user_id": "6ab16ea0-f23a-4b64-86ee-2dbfa3561da1"
					}
				}
```

5.Update a Specific Task:

- Method: PUT
- URL: http://localhost:4000/api/users/:user_id/tasks/:task_id
- Body Type: form-data
- Body:
Key: task[title], Value: Updated Task
Key: task[description], Value: This task has been updated.
Key: task[due_date], Value: 2024-12-31
Key: task[status], Value: In Progress

- Output:
```				{
					"data": {
						"id": "07832ffd-197b-4d19-9e48-31c2686ef949",
						"status": "In Progress",
						"description": "This task has been updated.",
						"title": "Updated Task",
						"due_date": "2024-12-31",
						"user_id": "6ab16ea0-f23a-4b64-86ee-2dbfa3561da1"
					}
				}
```
6. Delete a Specific Task:

- Method: DELETE
- URL: http://localhost:4000/api/users/:user_id/tasks/:task_id

- Output:
 You will be shown 204 No Content for the successful deletion.

### Run Tests

```
mix test
```



