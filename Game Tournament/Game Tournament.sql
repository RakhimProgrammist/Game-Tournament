CREATE TABLE games (
    game_id SERIAL PRIMARY KEY,
    game_name VARCHAR(100) UNIQUE NOT NULL,
    developer VARCHAR(100) NOT NULL,
    min_age_rating INT NOT NULL CHECK (min_age_rating >= 0),
    is_active BOOLEAN DEFAULT true
);

CREATE TABLE tournaments (
    tournament_id SERIAL PRIMARY KEY,
    tournament_name VARCHAR(150) UNIQUE NOT NULL,
    game_id INT NOT NULL REFERENCES games(game_id),
    start_date DATE NOT NULL CHECK (start_date >= '2026-01-01') DEFAULT CURRENT_DATE,
    prize_pool NUMERIC(12,2) NOT NULL CHECK (prize_pool >= 0) DEFAULT 0
);

CREATE TABLE teams (
    team_id SERIAL PRIMARY KEY,
    team_name VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE NOT NULL CHECK (registration_date >= '2026-01-01') DEFAULT CURRENT_DATE,
    ranking_points INT NOT NULL CHECK (ranking_points >= 0) DEFAULT 0,
    is_disqualified BOOLEAN DEFAULT false
);

CREATE TABLE tournament_participations (
    participation_id SERIAL PRIMARY KEY,
    tournament_id INT NOT NULL REFERENCES tournaments(tournament_id),
    team_id INT NOT NULL REFERENCES teams(team_id),
    entry_fee_paid NUMERIC(8,2) NOT NULL CHECK (entry_fee_paid >= 0) DEFAULT 0,
    sign_up_date DATE NOT NULL CHECK (sign_up_date >= '2026-01-01') DEFAULT CURRENT_DATE
);


INSERT INTO games (game_name, developer, min_age_rating) VALUES
('Valorant', 'Riot Games', 16),
('Counter-Strike 2', 'Valve', 17),
('Rocket League', 'Psyonix', 0),
('Dota 2', 'Valve', 13);

INSERT INTO tournaments (tournament_name, game_id, start_date, prize_pool) VALUES
('Valorant Champions 2026', 1, '2026-08-01', 2500000.00),
('CS2 Major Atyrau 2026', 2, '2026-05-15', 1250000.00),
('RLCS World Championship 2026', 3, '2026-09-10', 500000.00),
('The International 2026', 4, '2026-10-05', 15000000.00);

INSERT INTO teams (team_name, registration_date, ranking_points) VALUES
('Team Liquid', '2026-01-10', 1500),
('Fnatic', '2026-01-15', 1450),
('Sentinels', '2026-02-01', 1200),
('Natus Vincere', '2026-01-20', 1380);

INSERT INTO tournament_participations (tournament_id, team_id, entry_fee_paid, sign_up_date) VALUES
(1, 1, 500.00, '2026-03-01'),
(1, 3, 500.00, '2026-03-05'),
(2, 4, 1000.00, '2026-02-28'),
(4, 1, 0.00, '2026-04-10');