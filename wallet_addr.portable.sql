-- Portable SQL seed for the wallets dataset
-- Cross-dialect focus: PostgreSQL-safe defaults with standard SQL types.
-- This file provides schema plus representative seed rows.
-- For the full native dump, use wallet_addr.mysql.sql with MySQL/MariaDB.

BEGIN;

DROP TABLE IF EXISTS wallet_addr;

CREATE TABLE wallet_addr (
    customer_id INTEGER,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(50),
    address VARCHAR(50),
    city VARCHAR(50),
    country VARCHAR(50),
    postal_code VARCHAR(50),
    date_of_creation DATE,
    bitcoin_addr VARCHAR(50),
    btc NUMERIC(12,7)
);

INSERT INTO wallet_addr (
    customer_id, first_name, last_name, email, phone_number, address,
    city, country, postal_code, date_of_creation, bitcoin_addr, btc
) VALUES
(1, 'Estele', 'Tetlow', 'etetlow0@jimdo.com', '4867030320', '5 Atwood Lane', 'Claresholm', 'Canada', 'V2T', '2019-09-07', '17NJQnn1S94wXt7ozDGhwZByGuAoDzV4c8', 15930.9595457),
(2, 'Tillie', 'Poundford', 'tpoundford1@biblegateway.com', '2227544292', '056 Sheridan Pass', 'Ishigaki', 'Japan', '937-0814', '2009-09-24', '14wUWK7vUuaZeGTbJL1YnTDU9h8x3YXdpQ', 16420.2469855),
(3, 'Dougy', 'Ludvigsen', 'dludvigsen2@chronoengine.com', '5486882790', '8081 Hoffman Center', 'Ukhta', 'Russia', '169309', '2013-10-20', '188x2Z94jCENL2WnNdYSYjeweUXiVSTpNF', 14047.6285442),
(4, 'Ulrika', 'Sacher', 'usacher3@bravesites.com', '8294771383', '959 Rusk Trail', 'Tumxuk', 'China', NULL, '2015-01-09', '17d2v7YWUqCyioQiL7gm3C1insynhYr5PG', 4351.1989136),
(5, 'Alwin', 'Franzonello', 'afranzonello4@mozilla.org', '4781435213', '6 Oriole Road', 'Pirane', 'Argentina', '3606', '2011-03-17', '1Ja5CH9vMPinyf8YKV8JHMwanNPFtVcryn', 14811.9828137),
(6, 'Renie', 'Blackaller', 'rblackaller5@livejournal.com', '8947504521', '2 Killdeer Trail', 'Tulung', 'Indonesia', NULL, '2009-03-16', '1NPutQtSGYFxw6qdgVjcJag2DnmE9Y1aUR', 7121.9849530),
(7, 'Jedidiah', 'Fischer', 'jfischer6@businessinsider.com', '9822367790', '6761 Donald Lane', 'Tirtopuro', 'Indonesia', NULL, '2022-12-08', '1P8Mqt1RxYqU6RJm8aL1VLLL5pYC2vwen3', 8020.7692047),
(8, 'Ynes', 'MacDonald', 'ymacdonald7@mozilla.org', '6004799205', '69145 Orin Park', 'Bogorame', 'Indonesia', NULL, '2018-10-07', '17P4R3zgKYS9EzKta4z6gQhtkEdPWq46sY', 13079.4301936),
(9, 'Tynan', 'Goodwill', 'tgoodwill8@xrea.com', '6424321213', '81 Sutherland Lane', 'Kasukabe', 'Japan', '344-0061', '2021-05-05', '1JxcLu41Q8nUxxRJLKKUS7DSpZhd2WgFHb', 1535.1321584),
(10, 'Merilee', 'Crawcour', 'mcrawcour9@nasa.gov', '4074689527', '6265 Artisan Trail', 'Antang', 'China', NULL, '2022-03-14', '1JzP2c94Uepf4PPgbYuyyjGfFkZWjqzhjD', 18002.0397499),
(11, 'Frederich', 'Tschursch', 'ftschurscha@telegraph.co.uk', '6512848604', '5 Hoepker Court', 'Qiman', 'China', NULL, '2014-04-25', '1H5U3SAfZscCkS5ZXPHMW3ww8sDSKjRVWJ', 20546.6097892),
(12, 'Nelli', 'Beernt', 'nbeerntb@npr.org', '5588705361', '644 Fairfield Place', 'Daqingshan', 'China', NULL, '2010-11-01', '14baGGAKFjcHs26zHXvzDUBHanm5vwGHVD', 11583.6544748);

COMMIT;
