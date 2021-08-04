-- POSTGRESQL SCRIPT

CREATE TABLE USERS (
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  avatar VARCHAR,
  email VARCHAR NOT NULL,
  password VARCHAR NOT NULL,
  remember_token VARCHAR,
  verified BOOLEAN,
  verified_at TIMESTAMP,
  last_connection TIMESTAMP,
  created_at TIMESTAMP DEFAULT current_timestamp,
  updated_at TIMESTAMP DEFAULT current_timestamp
);

CREATE TYPE friend_request_status AS ENUM ('pending', 'acepted', 'rejected', 'canceled');
CREATE TABLE friends (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  friend_id INTEGER NOT NULL,
  secutiry_token VARCHAR,
  status friend_request_status DEFAULT 'pending',
  acepted_at TIMESTAMP,
  rejected_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT current_timestamp,
  updated_at TIMESTAMP DEFAULT current_timestamp,

  CONSTRAINT fk_user
    FOREIGN KEY(user_id) 
      REFERENCES users(id),
  CONSTRAINT fk_friend
    FOREIGN KEY(friend_id) 
      REFERENCES users(id)
);

CREATE TABLE password_resets (
  user_id INTEGER NOT NULL,
  token VARCHAR NOT NULL,
  used BOOLEAN DEFAULT FALSE,
  used_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT current_timestamp,

  CONSTRAINT fk_user
    FOREIGN KEY(user_id) 
      REFERENCES users(id)
);

CREATE TYPE room_type AS ENUM ('personal', 'group');
CREATE TABLE rooms (
  id SERIAL PRIMARY KEY,
  sec_tok VARCHAR,
  name VARCHAR,
  type room_type DEFAULT 'personal',
  created_at TIMESTAMP DEFAULT current_timestamp,
  updated_at TIMESTAMP DEFAULT current_timestamp
);

CREATE TYPE member_role AS ENUM ('admin', 'member');
CREATE TABLE members (
  room_id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  silent BOOLEAN DEFAULT FALSE,
  blocked BOOLEAN DEFAULT FALSE,
  role member_role DEFAULT 'member',
  silent_at TIMESTAMP,
  blocked_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT current_timestamp,
  updated_at TIMESTAMP DEFAULT current_timestamp,

  CONSTRAINT fk_user
    FOREIGN KEY(user_id) 
      REFERENCES users(id)
);

CREATE TYPE reception_status AS ENUM ('sending', 'sended', 'recieved', 'seen');
CREATE TYPE message_status AS ENUM ('original', 'hidden', 'modified', 'deleted');
CREATE TABLE messages (
  id SERIAL PRIMARY KEY,
  room_id INTEGER NOT NULL,
  sender_id INTEGER NOT NULL,
  message VARCHAR(5000) NOT NULL,
  reception reception_status DEFAULT 'sending',
  status message_status DEFAULT 'original',
  created_at TIMESTAMP DEFAULT current_timestamp,
  updated_at TIMESTAMP DEFAULT current_timestamp,

  CONSTRAINT fk_user
    FOREIGN KEY(sender_id) 
      REFERENCES users(id),
  CONSTRAINT fk_room
    FOREIGN KEY(room_id) 
      REFERENCES rooms(id)
);

select * from pg_collection;