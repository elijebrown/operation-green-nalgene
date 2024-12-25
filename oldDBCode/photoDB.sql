-- Create the countries table
CREATE TABLE countries (
    country_name TEXT UNIQUE,
    country_code TEXT UNIQUE,
    id SERIAL PRIMARY KEY
);

-- Create the provinces table
CREATE TABLE provinces (
    id SERIAL PRIMARY KEY
    country_name TEXT NOT NULL,
    province_name TEXT NOT NULL,
    province_code TEXT NOT NULL,
    FOREIGN KEY (country_name) REFERENCES countries(country_name)
);

-- Create the cities table
CREATE TABLE cities (
    province_name TEXT NOT NULL,
    city_name TEXT NOT NULL,
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (province_name) REFERENCES provinces(province_name)
);

-- Create the photos table
CREATE TABLE photos (
    id SERIAL PRIMARY KEY,
    city_id SERIAL NOT NULL,
    photo_filepath TEXT UNIQUE NOT NULL,
    date DATE,
    caption TEXT,
    FOREIGN KEY (city_id) REFERENCES cities(id)
);

-- Create the trips table
CREATE TABLE trips (
    id SERIAL PRIMARY KEY,
    trip_name TEXT NOT NULL,
    trip_date DATE,
    trip_text TEXT
);

-- Create the trip_location table
CREATE TABLE trip_location (
    trip_id SERIAL NOT NULL,
    city_id SERIAL NOT NULL,
    PRIMARY KEY (trip_id, city_id),
    FOREIGN KEY (trip_id) REFERENCES trips(id),
    FOREIGN KEY (city_id) REFERENCES cities(id)
);

-- Create the memories table
CREATE TABLE memories (
    memory_id SERIAL PRIMARY KEY,
    trip_id SERIAL NOT NULL,
    memory_text TEXT NOT NULL,
    FOREIGN KEY (trip_id) REFERENCES trips(id)
);

-- Create the memory_photo table
CREATE TABLE memory_photo (
    memory_id SERIAL NOT NULL,
    photo_id SERIAL NOT NULL,
    PRIMARY KEY (memory_id, photo_id),
    FOREIGN KEY (memory_id) REFERENCES memories(memory_id),
    FOREIGN KEY (photo_id) REFERENCES photos(id)
);

