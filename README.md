url to use:
list all categories(array: categories) http://10.140.46.33:3000/api/categories/ | GET
list all books inside a category(array: books) http://10.140.46.33:3000/api/categories/:id | GET
show book information(array: book) http://10.140.46.33:3000/api/categories/:category_id/books/:book_id | GET
list all users(array: users) http://10.140.46.33:3000/api/users | GET
show user information(array: user) http://10.140.46.33:3000/api/users/:id | GET
get the last subscribtion of a book(array: subscribtion) http://localhost:3000/api/categories/1/books/1/subscribtions | GET
create a subscribtion(array: subscribtion) http://localhost:3000/api/categories/1/books/1/subscribtions | POST
create a book that belongs to specific category: http://10.140.46.33:3000/api/categories/:id/books | POST
