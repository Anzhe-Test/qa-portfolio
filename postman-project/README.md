Project Overview
This project demonstrates API testing using **Postman** and the **Swagger Petstore REST API**.
The collection contains positive and negative API tests with automated assertions written in Postman.

 API Under Test
**Swagger Petstore API**

Base URL:
`https://petstore.swagger.io/v2`

API documentation:
https://petstore.swagger.io/

Tools
* Postman
* REST API
* JSON
* JavaScript for Postman test scripts
* OpenAPI / Swagger

Testing Scope
The collection covers:
* GET request testing
* POST request testing
* PUT request testing
* HTTP status code validation
* Response structure validation
* Required field validation
* Negative testing
* Request headers
* JSON request and response bodies

Tests
 1. GET — Find Available Pets
**Endpoint:**
`GET /findByStatus?status=available`
The test verifies:
* HTTP status code is `200`
* Response is an array
* Response contains at least one pet
* Each pet contains the fields:
  * `id`
  * `name`
  * `photoUrls`
  * `status`

 2. POST — Create Pet with Missing Data
**Endpoint:**
`POST /`
The request contains only an `id` and is used as a negative test.
The test verifies that the API returns HTTP status code `400`.

 3. PUT — Update Pet
**Endpoint:**
`PUT /`
The request updates a pet using:
* `id`
* `name`
* `status`
The request uses the header:
`Content-Type: application/json`
The test verifies:
* HTTP status code is `200`
* Returned pet ID is `12121`
* Pet name is `UpdatedPetName`
* Pet status is `sold`

n4. PUT — Negative Test: Missing Required Name
**Endpoint:**
`PUT /`
The request intentionally omits the `name` field.
The test expects the API to reject the request with HTTP status code `400` or `422`.
This test is based on the `name` field being defined as required in the Pet model in the OpenAPI specification.

 Automated Tests
The Postman collection contains JavaScript test scripts that automatically validate:

* HTTP status codes
* Response data type
* Presence of required response fields
* Response content
* Updated resource values
* Negative test expectations



## Notes
This project was created for QA learning and portfolio purposes.
The API is a public demo API, so its data and behavior may change over time.
