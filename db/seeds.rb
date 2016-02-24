sql_query = <<-SQLQUERY
DROP TABLE IF EXISTS players;

CREATE TABLE players (
  id          BIGSERIAL PRIMARY KEY,
  name        VARCHAR(255),
  team        VARCHAR(255),
  games       VARCHAR(255),
  category    VARCHAR(255),
  description VARCHAR(255),
  year        VARCHAR(255),
  source      VARCHAR(255),
  repeat      VARCHAR(255)  DEFAULT 'No'
);

COPY players ("name", "team", "games", "category", "description", "year", "source")
  FROM '#{Rails.root}/nfl-suspensions-data.csv'
  DELIMITER ','
  CSV HEADER;

UPDATE players
  SET repeat = 'Yes',
      category = REPLACE(category, ', repeated offense', '')
  WHERE category ILIKE '%repeated%';

UPDATE players
  SET description = 'Not Provided'
  WHERE description IS NULL;

SQLQUERY

ActiveRecord::Base.connection.execute(sql_query)
