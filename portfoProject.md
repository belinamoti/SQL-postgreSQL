

Entities:

User
Course
Lesson
Quiz
Payment
Discussion
Enroll
Relationships:

User has many courses (through enrollments)
Course has many lessons
Course has many quizzes
User has many payments (for courses)
Course has many discussions
User has many enrollments (to courses)
Course has many enrollments (from users)
Attributes for each entity:

User: id, name, email, password, dashboard (progress)
Course: id, title, description, level, price, instructor
Lesson: id, title, video (URL), course_id
Quiz: id, title, questions (list), answers (list), course_id
Payment: id, amount, user_id, course_id
Discussion: id, title, content, course_id, user_id
Enroll: id, user_id, course_id
Primary Keys:

User: id
Course: id
Lesson: id
Quiz: id
Payment: id
Discussion: id
Enroll: id
Foreign Keys:

User: id (in enrollments)
Course: id (in lessons, quizzes, and discussions)
Lesson: course_id (refers to Course primary key)
Quiz: course_id (refers to Course primary key)
Payment: user_id, course_id (refers to User and Course primary keys)
Discussion: course_id, user_id (refers to Course and User primary keys)
Enroll: user_id (refers to User primary key), course_id (refers to Course primary key)
