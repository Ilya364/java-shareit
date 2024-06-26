DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS booking;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS item_request;
DROP TABLE IF EXISTS users;

CREATE TABLE IF NOT EXISTS users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(320),
    UNIQUE(email)
);

CREATE TABLE IF NOT EXISTS item_request (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description VARCHAR(100),
    created timestamp,
    creator_id BIGINT,
    CONSTRAINT fk_request_to_users FOREIGN KEY(creator_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS item (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100),
    description VARCHAR(100),
    available BOOLEAN,
    owner_id BIGINT,
    request_id BIGINT,
    CONSTRAINT fk_items_to_users FOREIGN KEY(owner_id) REFERENCES users(id),
    CONSTRAINT fk_items_to_request FOREIGN KEY(request_id) REFERENCES item_request(id)
);

CREATE TABLE IF NOT EXISTS comment (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    text VARCHAR(100),
    item_id BIGINT,
    user_id BIGINT,
    author_name VARCHAR(100),
    created timestamp,
    CONSTRAINT fk_comment_to_item FOREIGN KEY(item_id) REFERENCES item(id),
    CONSTRAINT fk_comment_to_users FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS booking (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    start_date timestamp,
    end_date timestamp,
    item_id BIGINT,
    booker_id BIGINT,
    status VARCHAR(100),
    CONSTRAINT fk_booking_to_item FOREIGN KEY(item_id) REFERENCES item(id),
    CONSTRAINT fk_booking_to_users FOREIGN KEY(booker_id) REFERENCES users(id)
);