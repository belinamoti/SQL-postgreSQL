-- kill other connections
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'my_e_learning' AND pid <> pg_backend_pid();
-- (re)create the database
DROP DATABASE IF EXISTS my_e_learning;
CREATE DATABASE my_e_learning;
-- connect via psql
\c my_e_learning

-- database configuration
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET default_tablespace = '';
SET default_with_oids = false;


CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password VARCHAR(32) NOT NULL UNIQUE
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name TEXT NOT NULL UNIQUE,
    course_level TEXT NOT NULL,
    description TEXT,
    price NUMERIC NOT NULL

);

CREATE TABLE enrollments (
    user_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    date DATE,
    PRIMARY KEY(user_id, course_id)
);

CREATE TABLE contacts (
    contact_id SERIAL PRIMARY KEY,
    address TEXT NOT NULL,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    zip_code TEXT,
    phone TEXT NOT NULL UNIQUE,
    user_id INTEGER NOT NULL UNIQUE

);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    amount NUMERIC NOT NULL,
    date DATE,
    user_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL
);

CREATE TABLE lessons (
    lesson_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    course_id INT
);

CREATE TABLE quizzes (
    quiz_id SERIAL PRIMARY KEY,
    title TEXT,
    quiz TEXT NOT NULL,
    course_id INT
);

CREATE TABLE discussions (
    discussion_id SERIAL PRIMARY KEY,
    title TEXT,
    content TEXT NOT NULL,
    user_id INT NOT NULL,
    course_id INT

);

ALTER TABLE enrollments
ADD CONSTRAINT fk_enrollments_users
FOREIGN KEY (user_id)
REFERENCES users(user_id);

ALTER TABLE enrollments
ADD CONSTRAINT fk_enrollments_courses
FOREIGN KEY (course_id)
REFERENCES courses(course_id);

ALTER TABLE contacts
ADD CONSTRAINT fk_contacts_users
FOREIGN KEY (user_id)
REFERENCES courses(user_id);

ALTER TABLE payments
ADD CONSTRAINT fk_payments_users
FOREIGN KEY (user_id)
REFERENCES users(user_id);

ALTER TABLE payments
ADD CONSTRAINT fk_payments_courses
FOREIGN KEY (course_id)
REFERENCES courses(course_id);

ALTER TABLE lessons
ADD CONSTRAINT fk_lessons_courses
FOREIGN KEY (course_id)
REFERENCES courses(course_id);

ALTER TABLE quizzes
ADD CONSTRAINT fk_quizzes_courses
FOREIGN KEY (course_id)
REFERENCES courses(course_id);


ALTER TABLE discussions
ADD CONSTRAINT fk_discussions_users
FOREIGN KEY (user_id)
REFERENCES users(user_id);

ALTER TABLE discussions
ADD CONSTRAINT fk_discussions_courses
FOREIGN KEY (course_id)
REFERENCES courses(course_id);


INSERT INTO users (first_name, last_name, email, password)
VALUES ('leo', 'davis', 'davis@gmail.com', 'jhskjdfhjsa$'),
('kei', 'loes', 'loeskei@bmail.com', 'kdsksjds$'),
('teil', 'laio', 'kdur@bmail.com', 'poeieud$'),
('feiuyr', 'derye', 'lewop@gmail.com', 'oudert$'),
('zeoirp', 'aweer', 'awert@gmail.com', 'swere$'),
('qiosa', 'dawro', 'gert@gmail.com', 'fert$');

INSERT INTO courses (course_name, course_level, description, price)
VALUES ('Python for Beginners', 'Beginner', 'Python is a computer programming language often used to build websites and software', 20.60),
('JavaScript for Beginners', 'Beginner', 'JavaScript (JS) is a lightweight, interpreted, or just-in-time compiled programming language with first-class functions.', 18.20),
('React', 'Advanced', 'React is a declarative, efficient, and flexible JavaScript library for building user interfaces.', 45.60),
('Flask', 'Intermediate', 'Flask is a micro web framework written in Python', 24.55),
('SQL', 'Advanced', 'SQL stands for Structured Query Language which is basically a language used by databases.', 32.60);


INSERT INTO enrollments (user_id, course_id, date)
VALUES (3, 4, '2022-08-13'),
(5, 2, '2023-05-23'),
(1, 3, '2021-09-06'),
(6, 1, '2023-05-23');

INSERT INTO contacts (address, city, state, zip_code, phone, user_id)
VALUES ('2344 malyae rd', 'columbus', 'OH', '43213', '614-966-8888', 3 ),
('634 yaefr road', 'cincinati', 'OH', '42213', '614-996-7788', 2 ),
('34 laeger street', 'dallas', 'TX', '44332', '614-999-3800', 5 );

INSERT INTO payments (amount, date, user_id, course_id)
VALUES (20.43, '2020-04-21', 2, 5),
(19.43, '2019-07-11', 4, 1),
(19.43, '2023-06-13', 2, 1),
(14.43, '2019-05-19', 3, 3);

INSERT INTO lessons (title, content, course_id)
VALUES ('Recursion', 'Recursion readings', 2),
('Creating tables', 'Creating table readings', 5),
('OOP', 'OOP readings', 1);

INSERT INTO quizzes (title, quiz, course_id)
VALUES ('Recursion Quiz', 'Questions', 2),
('Tables Quiz', 'Questions', 5),
('OOP quiz', 'Questions', 1);

INSERT INTO discussions (title, discuss, user_id, course_id)
VALUES ('Why do we use recursion?', 'users feedback', 6, 2),
('Which data type is used for price?', 'users feedback', 3, 5),
('Explain OOP in Python.', 'users feedback', 4, 1);




-- -- We can pull students that are enrolled in a course with their names and the course they are taking like this

-- SELECT u.first_name, u.last_name, c.course_name FROM users u
-- JOIN enrollments e ON u.user_id = e.user_id
-- JOIN courses c ON c.course_id = e.course_id;


-- --  We can search for payment of a specific student by first name showing the course name and the amount for each course

-- SELECT u.first_name, p.amount, c.course_name FROM users u
-- JOIN payments p ON u.user_id = p.user_id
-- JOIN courses c ON p.course_id = c.course_id
-- WHERE u.first_name = 'kei'
-- ORDER BY amount ASC;
