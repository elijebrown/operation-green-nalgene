

-- Create the countries table
CREATE TABLE countries (
    id SERIAL PRIMARY KEY, 
    country_name TEXT UNIQUE,
    country_code TEXT UNIQUE
);

-- Create the provinces table
CREATE TABLE provinces (
    id SERIAL PRIMARY KEY,  
    country_id int not NULL, 
    province_name text not NULL,
    province_code TEXT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES countries(id)
);

-- Create the cities table
CREATE TABLE cities (
    id SERIAL PRIMARY KEY, 
    province_id int not null, 
    city_name TEXT NOT NULL,
    FOREIGN KEY (province_id) REFERENCES provinces(id)
);

-- Create the photos table
CREATE TABLE photos (
    id SERIAL PRIMARY KEY,
    city_id int, 
    photo_filepath TEXT UNIQUE NOT NULL,
    date DATE,
    caption TEXT,
    FOREIGN KEY (city_id) REFERENCES cities(id) 
);

-- Create the trips table
CREATE TABLE trips (
    id SERIAL PRIMARY KEY, 
    trip_name TEXT,
    trip_date DATE,
    trip_text TEXT
);

-- Create the trip_location table
CREATE TABLE trip_location (
    trip_id int NOT NULL, 
    city_id int NOT NULL, 
    PRIMARY KEY (trip_id, city_id),
    FOREIGN KEY (trip_id) REFERENCES trips(id),
    FOREIGN KEY (city_id) REFERENCES cities(id)
);

-- Create the memories table
CREATE TABLE memories (
    id SERIAL PRIMARY KEY, 
    trip_id INT NOT NULL,  
    memory_text TEXT,
    memory_name TEXT
    FOREIGN KEY (trip_id) REFERENCES trips(id)
);

-- Create the memory_photo table
CREATE TABLE memory_photo (
    memory_id INT NOT NULL,  
    photo_id INT NOT NULL,  
    PRIMARY KEY (memory_id, photo_id),
    FOREIGN KEY (memory_id) REFERENCES memories(id),
    FOREIGN KEY (photo_id) REFERENCES photos(id)
);

CREATE TABLE trip_photos (
    trip_id INT NOT NULL,
    photo_id INT NOT NULL,
    PRIMARY KEY (trip_id, photo_id),
    FOREIGN KEY (trip_id) REFERENCES trips(id),
    FOREIGN KEY (photo_id) REFERENCES photos(id)
);

