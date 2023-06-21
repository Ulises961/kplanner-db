CREATE DATABASE kplanner WITH ENCODING 'UTF8';
CREATE USER kplanner WITH ENCRYPTED PASSWORD 'kadmin6&3';
GRANT ALL PRIVILEGES ON ALL TABLES    IN SCHEMA public TO kplanner;
GRANT ALL PRIVILEGES ON ALL SEQUENCES    IN SCHEMA public TO kplanner;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS    IN SCHEMA public TO kplanner;

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Ubuntu 15.3-1.pgdg22.04+1)
-- Dumped by pg_dump version 15.3 (Ubuntu 15.3-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: itemcategorytype; Type: TYPE; Schema: public; Owner: kplanner
--

CREATE TYPE public.itemcategorytype AS ENUM (
    'FIRST_AID',
    'CAMPING',
    'REPAIR',
    'TRAVEL',
    'GENERIC'
);


ALTER TYPE public.itemcategorytype OWNER TO kplanner;

--
-- Name: pointtype; Type: TYPE; Schema: public; Owner: kplanner
--

CREATE TYPE public.pointtype AS ENUM (
    'STOP',
    'POSITION',
    'INTEREST'
);


ALTER TYPE public.pointtype OWNER TO kplanner;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: day; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.day (
    id integer NOT NULL,
    day_number integer,
    itinerary_id integer,
    date date
);


ALTER TABLE public.day OWNER TO kplanner;

--
-- Name: day_id_seq; Type: SEQUENCE; Schema: public; Owner: kplanner
--

CREATE SEQUENCE public.day_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.day_id_seq OWNER TO kplanner;

--
-- Name: day_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kplanner
--

ALTER SEQUENCE public.day_id_seq OWNED BY public.day.id;


--
-- Name: image; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.image (
    id integer NOT NULL,
    size numeric,
    name character varying(255),
    location character varying(255)
);


ALTER TABLE public.image OWNER TO kplanner;

--
-- Name: image_id_seq; Type: SEQUENCE; Schema: public; Owner: kplanner
--

CREATE SEQUENCE public.image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_id_seq OWNER TO kplanner;

--
-- Name: image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kplanner
--

ALTER SEQUENCE public.image_id_seq OWNED BY public.image.id;


--
-- Name: inventory; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.inventory (
    id integer NOT NULL,
    trip_id integer
);


ALTER TABLE public.inventory OWNER TO kplanner;

--
-- Name: inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: kplanner
--

CREATE SEQUENCE public.inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_id_seq OWNER TO kplanner;

--
-- Name: inventory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kplanner
--

ALTER SEQUENCE public.inventory_id_seq OWNED BY public.inventory.id;


--
-- Name: inventory_items; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.inventory_items (
    inventory_id integer,
    item_id integer
);


ALTER TABLE public.inventory_items OWNER TO kplanner;

--
-- Name: item; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.item (
    id integer NOT NULL,
    category public.itemcategorytype,
    checked boolean,
    name character varying(255)
);


ALTER TABLE public.item OWNER TO kplanner;

--
-- Name: item_id_seq; Type: SEQUENCE; Schema: public; Owner: kplanner
--

CREATE SEQUENCE public.item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_id_seq OWNER TO kplanner;

--
-- Name: item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kplanner
--

ALTER SEQUENCE public.item_id_seq OWNED BY public.item.id;


--
-- Name: itinerary; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.itinerary (
    id integer NOT NULL,
    is_public boolean,
    total_miles numeric,
    expected_total_miles numeric,
    trip_id integer NOT NULL
);


ALTER TABLE public.itinerary OWNER TO kplanner;

--
-- Name: itinerary_id_seq; Type: SEQUENCE; Schema: public; Owner: kplanner
--

CREATE SEQUENCE public.itinerary_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.itinerary_id_seq OWNER TO kplanner;

--
-- Name: itinerary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kplanner
--

ALTER SEQUENCE public.itinerary_id_seq OWNED BY public.itinerary.id;


--
-- Name: log; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.log (
    id integer NOT NULL,
    hours numeric,
    avg_sea numeric,
    user_id integer
);


ALTER TABLE public.log OWNER TO kplanner;

--
-- Name: log_id_seq; Type: SEQUENCE; Schema: public; Owner: kplanner
--

CREATE SEQUENCE public.log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.log_id_seq OWNER TO kplanner;

--
-- Name: log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kplanner
--

ALTER SEQUENCE public.log_id_seq OWNED BY public.log.id;


--
-- Name: point; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.point (
    id integer NOT NULL,
    gps numeric,
    notes text,
    type public.pointtype,
    day_id integer,
    previous_id integer,
    next_id integer,
    reference_id integer
);


ALTER TABLE public.point OWNER TO kplanner;

--
-- Name: point_has_image; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.point_has_image (
    image_id integer NOT NULL,
    point_id integer NOT NULL
);


ALTER TABLE public.point_has_image OWNER TO kplanner;

--
-- Name: point_id_seq; Type: SEQUENCE; Schema: public; Owner: kplanner
--

CREATE SEQUENCE public.point_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.point_id_seq OWNER TO kplanner;

--
-- Name: point_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kplanner
--

ALTER SEQUENCE public.point_id_seq OWNED BY public.point.id;


--
-- Name: sea; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.sea (
    day_id integer NOT NULL,
    moon_phase character varying(255),
    high_tide time without time zone,
    low_tide time without time zone
);


ALTER TABLE public.sea OWNER TO kplanner;

--
-- Name: sea_state; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.sea_state (
    day_id integer NOT NULL,
    "time" time without time zone NOT NULL,
    wave_height numeric,
    wave_direction numeric,
    swell_direction numeric,
    swell_period numeric
);


ALTER TABLE public.sea_state OWNER TO kplanner;

--
-- Name: trip; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.trip (
    id integer NOT NULL
);


ALTER TABLE public.trip OWNER TO kplanner;

--
-- Name: trip_id_seq; Type: SEQUENCE; Schema: public; Owner: kplanner
--

CREATE SEQUENCE public.trip_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trip_id_seq OWNER TO kplanner;

--
-- Name: trip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kplanner
--

ALTER SEQUENCE public.trip_id_seq OWNED BY public.trip.id;


--
-- Name: user_endorses_log; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.user_endorses_log (
    log_id integer NOT NULL,
    endorsers integer
);


ALTER TABLE public.user_endorses_log OWNER TO kplanner;

--
-- Name: user_has_profile_picture; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.user_has_profile_picture (
    user_id integer NOT NULL,
    "image_id " integer
);


ALTER TABLE public.user_has_profile_picture OWNER TO kplanner;

--
-- Name: user_has_trip; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.user_has_trip (
    user_id integer,
    trip_id integer
);


ALTER TABLE public.user_has_trip OWNER TO kplanner;

--
-- Name: users; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.users (
    id integer NOT NULL,
    public_id character varying(255) NOT NULL,
    mail character varying(255) NOT NULL,
    pwd character varying(255) NOT NULL,
    phone character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    surname character varying(255)
);


ALTER TABLE public.users OWNER TO kplanner;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: kplanner
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO kplanner;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kplanner
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: weather; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.weather (
    day_id integer NOT NULL,
    model character varying(255)
);


ALTER TABLE public.weather OWNER TO kplanner;

--
-- Name: weather_state; Type: TABLE; Schema: public; Owner: kplanner
--

CREATE TABLE public.weather_state (
    day_id integer NOT NULL,
    "time" time without time zone NOT NULL,
    temperature numeric,
    precipitation numeric,
    wind_direction numeric,
    wind_force numeric,
    cloud character varying(255)
);


ALTER TABLE public.weather_state OWNER TO kplanner;

--
-- Name: day id; Type: DEFAULT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.day ALTER COLUMN id SET DEFAULT nextval('public.day_id_seq'::regclass);


--
-- Name: image id; Type: DEFAULT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.image ALTER COLUMN id SET DEFAULT nextval('public.image_id_seq'::regclass);


--
-- Name: inventory id; Type: DEFAULT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.inventory ALTER COLUMN id SET DEFAULT nextval('public.inventory_id_seq'::regclass);


--
-- Name: item id; Type: DEFAULT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.item ALTER COLUMN id SET DEFAULT nextval('public.item_id_seq'::regclass);


--
-- Name: itinerary id; Type: DEFAULT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.itinerary ALTER COLUMN id SET DEFAULT nextval('public.itinerary_id_seq'::regclass);


--
-- Name: log id; Type: DEFAULT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.log ALTER COLUMN id SET DEFAULT nextval('public.log_id_seq'::regclass);


--
-- Name: point id; Type: DEFAULT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.point ALTER COLUMN id SET DEFAULT nextval('public.point_id_seq'::regclass);


--
-- Name: trip id; Type: DEFAULT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.trip ALTER COLUMN id SET DEFAULT nextval('public.trip_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: day; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.day (id, day_number, itinerary_id, date) FROM stdin;
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.image (id, size, name, location) FROM stdin;
\.


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.inventory (id, trip_id) FROM stdin;
\.


--
-- Data for Name: inventory_items; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.inventory_items (inventory_id, item_id) FROM stdin;
\.


--
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.item (id, category, checked, name) FROM stdin;
\.


--
-- Data for Name: itinerary; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.itinerary (id, is_public, total_miles, expected_total_miles, trip_id) FROM stdin;
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.log (id, hours, avg_sea, user_id) FROM stdin;
\.


--
-- Data for Name: point; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.point (id, gps, notes, type, day_id, previous_id, next_id, reference_id) FROM stdin;
\.


--
-- Data for Name: point_has_image; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.point_has_image (image_id, point_id) FROM stdin;
\.


--
-- Data for Name: sea; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.sea (day_id, moon_phase, high_tide, low_tide) FROM stdin;
\.


--
-- Data for Name: sea_state; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.sea_state (day_id, "time", wave_height, wave_direction, swell_direction, swell_period) FROM stdin;
\.


--
-- Data for Name: trip; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.trip (id) FROM stdin;
\.


--
-- Data for Name: user_endorses_log; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.user_endorses_log (log_id, endorsers) FROM stdin;
\.


--
-- Data for Name: user_has_profile_picture; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.user_has_profile_picture (user_id, "image_id ") FROM stdin;
\.


--
-- Data for Name: user_has_trip; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.user_has_trip (user_id, trip_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.users (id, public_id, mail, pwd, phone, name, surname) FROM stdin;
\.


--
-- Data for Name: weather; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.weather (day_id, model) FROM stdin;
\.


--
-- Data for Name: weather_state; Type: TABLE DATA; Schema: public; Owner: kplanner
--

COPY public.weather_state (day_id, "time", temperature, precipitation, wind_direction, wind_force, cloud) FROM stdin;
\.


--
-- Name: day_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kplanner
--

SELECT pg_catalog.setval('public.day_id_seq', 1, false);


--
-- Name: image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kplanner
--

SELECT pg_catalog.setval('public.image_id_seq', 1, false);


--
-- Name: inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kplanner
--

SELECT pg_catalog.setval('public.inventory_id_seq', 1, false);


--
-- Name: item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kplanner
--

SELECT pg_catalog.setval('public.item_id_seq', 1, false);


--
-- Name: itinerary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kplanner
--

SELECT pg_catalog.setval('public.itinerary_id_seq', 1, false);


--
-- Name: log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kplanner
--

SELECT pg_catalog.setval('public.log_id_seq', 1, false);


--
-- Name: point_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kplanner
--

SELECT pg_catalog.setval('public.point_id_seq', 1, false);


--
-- Name: trip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kplanner
--

SELECT pg_catalog.setval('public.trip_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kplanner
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: day day_day_number_itinerary_id_date_key; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.day
    ADD CONSTRAINT day_day_number_itinerary_id_date_key UNIQUE (day_number, itinerary_id, date);


--
-- Name: day day_pkey; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.day
    ADD CONSTRAINT day_pkey PRIMARY KEY (id);


--
-- Name: image image_pkey; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (id);


--
-- Name: item item_pkey; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (id);


--
-- Name: itinerary itinerary_pkey; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.itinerary
    ADD CONSTRAINT itinerary_pkey PRIMARY KEY (id);


--
-- Name: log log_pkey; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.log
    ADD CONSTRAINT log_pkey PRIMARY KEY (id);


--
-- Name: point_has_image point_has_image_pkey; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.point_has_image
    ADD CONSTRAINT point_has_image_pkey PRIMARY KEY (image_id, point_id);


--
-- Name: point point_pkey; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.point
    ADD CONSTRAINT point_pkey PRIMARY KEY (id);


--
-- Name: sea sea_pkey; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.sea
    ADD CONSTRAINT sea_pkey PRIMARY KEY (day_id);


--
-- Name: sea_state sea_state_pkey; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.sea_state
    ADD CONSTRAINT sea_state_pkey PRIMARY KEY (day_id, "time");


--
-- Name: trip trip_pkey; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_pkey PRIMARY KEY (id);


--
-- Name: user_endorses_log user_endorses_log_pkey; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.user_endorses_log
    ADD CONSTRAINT user_endorses_log_pkey PRIMARY KEY (log_id);


--
-- Name: user_has_profile_picture user_has_profile_picture_pkey; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.user_has_profile_picture
    ADD CONSTRAINT user_has_profile_picture_pkey PRIMARY KEY (user_id);


--
-- Name: users users_mail_key; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_mail_key UNIQUE (mail);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_public_id_key; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_public_id_key UNIQUE (public_id);


--
-- Name: weather weather_pkey; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.weather
    ADD CONSTRAINT weather_pkey PRIMARY KEY (day_id);


--
-- Name: weather_state weather_state_pkey; Type: CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.weather_state
    ADD CONSTRAINT weather_state_pkey PRIMARY KEY (day_id, "time");


--
-- Name: point day_foreign_key_in_point; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.point
    ADD CONSTRAINT day_foreign_key_in_point FOREIGN KEY (day_id) REFERENCES public.day(id);


--
-- Name: sea day_foreign_key_in_sea; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.sea
    ADD CONSTRAINT day_foreign_key_in_sea FOREIGN KEY (day_id) REFERENCES public.day(id);


--
-- Name: weather day_foreign_key_in_weather; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.weather
    ADD CONSTRAINT day_foreign_key_in_weather FOREIGN KEY (day_id) REFERENCES public.day(id);


--
-- Name: day day_itinerary_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.day
    ADD CONSTRAINT day_itinerary_id_fkey FOREIGN KEY (itinerary_id) REFERENCES public.itinerary(id);


--
-- Name: inventory_items inventory_items_inventory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.inventory_items
    ADD CONSTRAINT inventory_items_inventory_id_fkey FOREIGN KEY (inventory_id) REFERENCES public.inventory(id);


--
-- Name: inventory_items inventory_items_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.inventory_items
    ADD CONSTRAINT inventory_items_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item(id);


--
-- Name: inventory inventory_trip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trip(id);


--
-- Name: itinerary itinerary_trip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.itinerary
    ADD CONSTRAINT itinerary_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trip(id);


--
-- Name: log log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.log
    ADD CONSTRAINT log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: point_has_image point_has_image_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.point_has_image
    ADD CONSTRAINT point_has_image_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.image(id);


--
-- Name: point_has_image point_has_image_point_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.point_has_image
    ADD CONSTRAINT point_has_image_point_id_fkey FOREIGN KEY (point_id) REFERENCES public.point(id);


--
-- Name: point point_next_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.point
    ADD CONSTRAINT point_next_id_fkey FOREIGN KEY (next_id) REFERENCES public.point(id);


--
-- Name: point point_previous_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.point
    ADD CONSTRAINT point_previous_id_fkey FOREIGN KEY (previous_id) REFERENCES public.point(id);


--
-- Name: point point_reference_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.point
    ADD CONSTRAINT point_reference_id_fkey FOREIGN KEY (reference_id) REFERENCES public.point(id);


--
-- Name: sea_state sea_day_foreign_key_in_sea_state; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.sea_state
    ADD CONSTRAINT sea_day_foreign_key_in_sea_state FOREIGN KEY (day_id) REFERENCES public.sea(day_id);


--
-- Name: user_endorses_log user_endorses_log_endorsers_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.user_endorses_log
    ADD CONSTRAINT user_endorses_log_endorsers_fkey FOREIGN KEY (endorsers) REFERENCES public.users(id);


--
-- Name: user_endorses_log user_endorses_log_log_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.user_endorses_log
    ADD CONSTRAINT user_endorses_log_log_id_fkey FOREIGN KEY (log_id) REFERENCES public.log(id);


--
-- Name: user_has_profile_picture user_has_profile_picture_image_id _fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.user_has_profile_picture
    ADD CONSTRAINT "user_has_profile_picture_image_id _fkey" FOREIGN KEY ("image_id ") REFERENCES public.image(id);


--
-- Name: user_has_profile_picture user_has_profile_picture_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.user_has_profile_picture
    ADD CONSTRAINT user_has_profile_picture_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_has_trip user_has_trip_trip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.user_has_trip
    ADD CONSTRAINT user_has_trip_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trip(id);


--
-- Name: user_has_trip user_has_trip_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.user_has_trip
    ADD CONSTRAINT user_has_trip_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: weather_state weather_day_foreign_keys_in_weather_state; Type: FK CONSTRAINT; Schema: public; Owner: kplanner
--

ALTER TABLE ONLY public.weather_state
    ADD CONSTRAINT weather_day_foreign_keys_in_weather_state FOREIGN KEY (day_id) REFERENCES public.weather(day_id);


--
-- Name: TABLE day; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.day TO kplanner;


--
-- Name: SEQUENCE day_id_seq; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON SEQUENCE public.day_id_seq TO kplanner;


--
-- Name: TABLE image; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.image TO kplanner;


--
-- Name: SEQUENCE image_id_seq; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON SEQUENCE public.image_id_seq TO kplanner;


--
-- Name: TABLE inventory; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.inventory TO kplanner;


--
-- Name: SEQUENCE inventory_id_seq; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON SEQUENCE public.inventory_id_seq TO kplanner;


--
-- Name: TABLE inventory_items; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.inventory_items TO kplanner;


--
-- Name: TABLE item; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.item TO kplanner;


--
-- Name: SEQUENCE item_id_seq; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON SEQUENCE public.item_id_seq TO kplanner;


--
-- Name: TABLE itinerary; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.itinerary TO kplanner;


--
-- Name: SEQUENCE itinerary_id_seq; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON SEQUENCE public.itinerary_id_seq TO kplanner;


--
-- Name: TABLE log; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.log TO kplanner;


--
-- Name: SEQUENCE log_id_seq; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON SEQUENCE public.log_id_seq TO kplanner;


--
-- Name: TABLE point; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.point TO kplanner;


--
-- Name: TABLE point_has_image; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.point_has_image TO kplanner;


--
-- Name: SEQUENCE point_id_seq; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON SEQUENCE public.point_id_seq TO kplanner;


--
-- Name: TABLE sea; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.sea TO kplanner;


--
-- Name: TABLE sea_state; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.sea_state TO kplanner;


--
-- Name: TABLE trip; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.trip TO kplanner;


--
-- Name: SEQUENCE trip_id_seq; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON SEQUENCE public.trip_id_seq TO kplanner;


--
-- Name: TABLE user_endorses_log; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.user_endorses_log TO kplanner;


--
-- Name: TABLE user_has_profile_picture; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.user_has_profile_picture TO kplanner;


--
-- Name: TABLE user_has_trip; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.user_has_trip TO kplanner;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.users TO kplanner;


--
-- Name: SEQUENCE users_id_seq; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON SEQUENCE public.users_id_seq TO kplanner;


--
-- Name: TABLE weather; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.weather TO kplanner;


--
-- Name: TABLE weather_state; Type: ACL; Schema: public; Owner: kplanner
--

GRANT ALL ON TABLE public.weather_state TO kplanner;


--
-- PostgreSQL database dump complete
--

