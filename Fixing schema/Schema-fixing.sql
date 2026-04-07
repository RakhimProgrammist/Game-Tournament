ALTER TABLE Members
    ALTER COLUMN username SET NOT NULL,
    ADD CONSTRAINT members_username_unique UNIQUE (username),
    ALTER COLUMN email SET NOT NULL,
    ADD CONSTRAINT members_email_unique UNIQUE (email),
    ALTER COLUMN is_active SET DEFAULT true;

ALTER TABLE Books
    ALTER COLUMN author SET NOT NULL,
    ADD CONSTRAINT books_year_pub_check CHECK (year_pub >= 0);

ALTER TABLE Books 
    ADD COLUMN condition TEXT NOT NULL DEFAULT 'good';

ALTER TABLE Books 
    ALTER COLUMN condition TYPE VARCHAR(30);

ALTER TABLE Books
    ADD CONSTRAINT books_owner_fk FOREIGN KEY (owner_id) REFERENCES Members(id);

ALTER TABLE Exchanges
    ALTER COLUMN exchange_date SET NOT NULL,
    ADD CONSTRAINT exch_start_date_check CHECK (exchange_date >= '2026-01-01'),
    ADD CONSTRAINT exch_return_date_check CHECK (return_date >= '2026-01-01');

ALTER TABLE Exchanges 
    ADD COLUMN status VARCHAR(20) DEFAULT 'pending';

ALTER TABLE Exchanges
    ADD CONSTRAINT exchanges_book_fk FOREIGN KEY (book_id) REFERENCES Books(id),
    ADD CONSTRAINT exchanges_borrower_fk FOREIGN KEY (borrower_id) REFERENCES Members(id);

ALTER TABLE Reviews
    ALTER COLUMN review_text SET NOT NULL,
    ADD CONSTRAINT reviews_rating_check CHECK (rating BETWEEN 1 AND 5);

ALTER TABLE Reviews
    ADD CONSTRAINT reviews_book_fk FOREIGN KEY (book_id) REFERENCES Books(id),
    ADD CONSTRAINT reviews_member_fk FOREIGN KEY (member_id) REFERENCES Members(id);

ALTER TABLE Reviews DROP CONSTRAINT reviews_book_fk;

ALTER TABLE Reviews 
    ADD CONSTRAINT reviews_book_fk FOREIGN KEY (book_id) REFERENCES Books(id);

INSERT INTO Members (username, email, joined_date) VALUES 
('alice_reader', 'alice@email.com', '2026-02-15'),
('bob_books', 'bob@email.com', '2026-03-10'),
('charlie_lit', 'charlie@email.com', '2026-04-01');

INSERT INTO Books (title, author, year_pub, owner_id) VALUES 
('The Hobbit', 'J.R.R. Tolkien', 1937, 1),
('Dune', 'Frank Herbert', 1965, 2),
('Foundation', 'Isaac Asimov', 1951, 3);

INSERT INTO Exchanges (book_id, borrower_id, exchange_date, return_date) VALUES 
(1, 2, '2026-04-02', '2026-04-16'),
(2, 3, '2026-04-03', '2026-04-17'),
(3, 1, '2026-04-05', NULL);

INSERT INTO Reviews (book_id, member_id, rating, review_text, created_at) VALUES 
(1, 2, 5, 'An absolute classic! Could not put it down.', '2026-04-16'),
(2, 3, 4, 'Great world-building, a bit slow at the start.', '2026-04-17'),
(3, 1, 5, 'The scale of this story is incredible.', '2026-04-20');
