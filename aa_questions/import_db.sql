DROP TABLE if exists users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR NOT NULL,
  lname VARCHAR NOT NULL
);

DROP TABLE if exists questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR NOT NULL,
  body TEXT NOT NULL,
  author INTEGER,

  FOREIGN KEY (author) REFERENCES users(id)
);

DROP TABLE if exists question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  users_id INTEGER,
  questions_id INTEGER,

  FOREIGN KEY (users_id) REFERENCES users(id),
  FOREIGN KEY (questions_id) REFERENCES questions(id)
);

DROP TABLE if exists replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  subject INTEGER NOT NULL,
  parent INTEGER,
  author INTEGER,

  FOREIGN KEY (subject) REFERENCES questions(id),
  FOREIGN KEY (author) REFERENCES users(id),
  FOREIGN KEY (parent) REFERENCES replies(id)
);

DROP TABLE if exists question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  liker INTEGER,
  liked INTEGER,

  FOREIGN KEY (liker) REFERENCES users(id),
  FOREIGN KEY (liked) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Brandon', 'Tat'),
  ('Jules', 'Costa');

INSERT INTO
  questions (title, body, author)
VALUES
  ('SQL', 'WTF is SQL?!', (SELECT id FROM users WHERE fname = 'Jules')),
  ('Chickens', 'Why''d they cross the road?', (SELECT id FROM users WHERE fname = 'Brandon'));

INSERT INTO
  question_follows (users_id, questions_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Jules'),
    (SELECT id FROM questions WHERE author = (SELECT id FROM users WHERE fname = 'Brandon')));

INSERT INTO
  replies (body, subject, author, parent)
VALUES
  ('Interesting query...', (SELECT id FROM questions WHERE author = (SELECT id FROM users WHERE fname = 'Jules')),
    (SELECT id FROM users WHERE fname = 'Brandon'), NULL);

INSERT INTO
  question_likes (liker, liked)
VALUES
  ((SELECT id FROM users WHERE fname = 'Jules'), (SELECT id FROM questions WHERE title = 'Chickens'));
