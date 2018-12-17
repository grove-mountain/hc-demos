CREATE DATABASE vices;
CREATE USER mario WITH password 'itsamemario';
GRANT ALL PRIVILEGES ON DATABASE vices TO mario;

\c vices mario

CREATE TABLE beer (
  brewery  varchar(40),
  beer     varchar(40),
  style    varchar(40),
  srm      integer NOT NULL,
  ibu      integer NOT NULL,
  abv       numeric
);

INSERT INTO beer VALUES
  ('Anchor', 'California Lager', 'Lager', 6, 20, 4.9),
  ('Anchor', 'Steam', 'Amber Lager', 15, 20, 4.9),
  ('Modern Times', 'Black House', 'Coffee Stout', 40, 40, 5.8),
  ('Modern Times', 'Space Ways', 'Hazy IPA', 7, 8, 6.70),
  ('Russian River', 'Pliny the Elder', 'Double IPA', 8, 60, 8.00),
  ('Founders', 'KBS', 'Imperial Coffee Stout', 40, 40, 12.3)
;

