CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_followers(
  id INTEGER PRIMARY KEY,
  follower_id INTEGER NOT NULL,
  followed_question_id INTEGER NOT NULL,
  FOREIGN KEY (follower_id) REFERENCES users(id),
  FOREIGN KEY (followed_question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body VARCHAR NOT NULL,
  subject_question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (subject_question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);



INSERT INTO
  users (fname, lname)
VALUES
  ("Auster", "Chen"),
  ("Andrew", "Strachan");

INSERT INTO
  questions (title, body, user_id)
VALUES
  ( "What's the temperature today?", "I don't know how to check the weather.",
    (SELECT id FROM users WHERE fname = 'Auster') ),
  ( "Is today fun?", "I thought today was fun, what about you guys",
    (SELECT id FROM users WHERE fname = 'Auster') ),
  ( "What's 1+1", "I can't use my calculator",
    (SELECT id FROM users WHERE fname = 'Auster') ),
  ( "Can you do my homework for me?", "I don't like homework.",
    (SELECT id FROM users WHERE fname = 'Auster') ),
  ("What are you doing today?", "There's no body here",
    (SELECT id FROM users WHERE fname = 'Andrew') );
    
INSERT INTO
  question_followers(follower_id, followed_question_id)
VALUES
  ( (SELECT id FROM users WHERE fname = 'Andrew'), 
  (SELECT questions.id 
  FROM questions 
  JOIN users
  ON questions.user_id = users.id
  WHERE users.fname = 'Auster'
  LIMIT 1) ),
  ( (SELECT id FROM users WHERE fname = 'Andrew'), 
  (SELECT questions.id 
  FROM questions 
  JOIN users
  ON questions.user_id = users.id
  WHERE users.fname = 'Andrew'
  LIMIT 1) ),
  ( (SELECT id FROM users WHERE fname = 'Auster'), 
  (SELECT questions.id 
  FROM questions 
  JOIN users
  ON questions.user_id = users.id
  WHERE users.fname = 'Andrew'
  LIMIT 1) );
    
INSERT INTO 
  replies(body, subject_question_id, user_id, parent_reply_id)
VALUES
  ('Google it.', 
  (SELECT questions.id 
  FROM questions 
  JOIN users
  ON questions.user_id = users.id
  WHERE users.fname = 'Auster'
  LIMIT 1), 
  (SELECT id
  FROM users
  WHERE fname = 'Andrew'), NULL),
  ("That's not helpful",
    (SELECT questions.id 
  FROM questions 
  JOIN users
  ON questions.user_id = users.id
  WHERE users.fname = 'Auster'
  LIMIT 1),
  (SELECT id
  FROM users
  WHERE fname = 'Auster'), 1  
  );
    
INSERT INTO 
  question_likes(user_id, question_id)
VALUES 
  ( (SELECT id
  FROM users
  WHERE fname = 'Andrew'),
  
  (SELECT questions.id 
  FROM questions 
  JOIN users
  ON questions.user_id = users.id
  WHERE users.fname = 'Auster'
  LIMIT 1) ),
  
  ( (SELECT id
  FROM users
  WHERE fname = 'Andrew'),
  
  (SELECT questions.id 
  FROM questions 
  JOIN users
  ON questions.user_id = users.id
  WHERE users.fname = 'Andrew'
  LIMIT 1) ),
  
  ( (SELECT id
  FROM users
  WHERE fname = 'Auster'),
  
  (SELECT questions.id 
  FROM questions 
  JOIN users
  ON questions.user_id = users.id
  WHERE users.fname = 'Andrew'
  LIMIT 1) ),
  
  ( (SELECT id
  FROM users
  WHERE fname = 'Auster'), 3 ),
  ( (SELECT id
  FROM users
  WHERE fname = 'Auster'), 4 );
    