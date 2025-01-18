--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.2 (Debian 17.2-1.pgdg120+1)

-- Started on 2025-01-18 17:19:24 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 3079 OID 18766)
-- Name: pg_ivm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_ivm WITH SCHEMA pg_catalog;


--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION pg_ivm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_ivm IS 'incremental view maintenance on PostgreSQL';
--
-- TOC entry 14 (class 2615 OID 18600)
-- Name: paradedb; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA paradedb;


--
-- TOC entry 17 (class 2615 OID 20366)
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA tiger;


--
-- TOC entry 18 (class 2615 OID 20622)
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA tiger_data;


--
-- TOC entry 16 (class 2615 OID 20184)
-- Name: topology; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA topology;


--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 16
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- TOC entry 8 (class 3079 OID 20354)
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 8
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- TOC entry 3 (class 3079 OID 18740)
-- Name: pg_analytics; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_analytics WITH SCHEMA public;


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION pg_analytics; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_analytics IS 'pg_analytics: Postgres for analytics, powered by DuckDB';


--
-- TOC entry 2 (class 3079 OID 18601)
-- Name: pg_search; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_search WITH SCHEMA paradedb;


--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pg_search; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_search IS 'pg_search: Full text search for PostgreSQL using BM25';


--
-- TOC entry 6 (class 3079 OID 19112)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- TOC entry 9 (class 3079 OID 20367)
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 9
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- TOC entry 7 (class 3079 OID 20185)
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 7
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


--
-- TOC entry 5 (class 3079 OID 18784)
-- Name: vector; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA public;


--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION vector; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION vector IS 'vector data type and ivfflat and hnsw access methods';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 298 (class 1259 OID 21031)
-- Name: cities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cities (
    id integer NOT NULL,
    province_id integer NOT NULL,
    city_name text NOT NULL
);


--
-- TOC entry 297 (class 1259 OID 21030)
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 297
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- TOC entry 294 (class 1259 OID 21004)
-- Name: countries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.countries (
    id integer NOT NULL,
    country_name text,
    country_code text
);


--
-- TOC entry 293 (class 1259 OID 21003)
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.countries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 293
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;


--
-- TOC entry 305 (class 1259 OID 21085)
-- Name: memories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.memories (
    id integer NOT NULL,
    trip_id integer NOT NULL,
    memory_text text,
    memory_title text
);


--
-- TOC entry 304 (class 1259 OID 21084)
-- Name: memories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.memories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 304
-- Name: memories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.memories_id_seq OWNED BY public.memories.id;


--
-- TOC entry 306 (class 1259 OID 21098)
-- Name: memory_photo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.memory_photo (
    memory_id integer NOT NULL,
    photo_id integer NOT NULL
);


--
-- TOC entry 300 (class 1259 OID 21045)
-- Name: photos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.photos (
    id integer NOT NULL,
    city_id integer,
    photo_filepath text NOT NULL,
    date date,
    caption text
);


--
-- TOC entry 299 (class 1259 OID 21044)
-- Name: photos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.photos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 299
-- Name: photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.photos_id_seq OWNED BY public.photos.id;


--
-- TOC entry 296 (class 1259 OID 21017)
-- Name: provinces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.provinces (
    id integer NOT NULL,
    country_id integer NOT NULL,
    province_name text NOT NULL,
    province_code text NOT NULL
);


--
-- TOC entry 295 (class 1259 OID 21016)
-- Name: provinces_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.provinces_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 295
-- Name: provinces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.provinces_id_seq OWNED BY public.provinces.id;


--
-- TOC entry 303 (class 1259 OID 21069)
-- Name: trip_location; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trip_location (
    trip_id integer NOT NULL,
    city_id integer NOT NULL
);


--
-- TOC entry 307 (class 1259 OID 21124)
-- Name: trip_photos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trip_photos (
    trip_id integer NOT NULL,
    photo_id integer NOT NULL
);


--
-- TOC entry 302 (class 1259 OID 21061)
-- Name: trips; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trips (
    id integer NOT NULL,
    trip_date date,
    trip_text text,
    trip_name text
);


--
-- TOC entry 301 (class 1259 OID 21060)
-- Name: trips_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.trips_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 301
-- Name: trips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.trips_id_seq OWNED BY public.trips.id;


--
-- TOC entry 4888 (class 2604 OID 21034)
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- TOC entry 4886 (class 2604 OID 21007)
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);


--
-- TOC entry 4891 (class 2604 OID 21088)
-- Name: memories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.memories ALTER COLUMN id SET DEFAULT nextval('public.memories_id_seq'::regclass);


--
-- TOC entry 4889 (class 2604 OID 21048)
-- Name: photos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.photos ALTER COLUMN id SET DEFAULT nextval('public.photos_id_seq'::regclass);


--
-- TOC entry 4887 (class 2604 OID 21020)
-- Name: provinces id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provinces ALTER COLUMN id SET DEFAULT nextval('public.provinces_id_seq'::regclass);


--
-- TOC entry 4890 (class 2604 OID 21064)
-- Name: trips id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trips ALTER COLUMN id SET DEFAULT nextval('public.trips_id_seq'::regclass);


--
-- TOC entry 4868 (class 0 OID 18768)
-- Dependencies: 230
-- Data for Name: pg_ivm_immv; Type: TABLE DATA; Schema: pg_catalog; Owner: -
--

COPY pg_catalog.pg_ivm_immv (immvrelid, viewdef, ispopulated) FROM stdin;
\.


--
-- TOC entry 5107 (class 0 OID 21031)
-- Dependencies: 298
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cities (id, province_id, city_name) FROM stdin;
1	1	Canmore
2	1	Banff
3	2	Whistler
4	12	Munich
5	37	Lisbon
6	34	Faro
7	34	Tavira
8	107	Mendoza
9	95	Buenos Aires
10	110	Bariloche
11	133	Santiago De Chile
12	141	Panamá
13	1	Drumheller
14	1	Calgary
15	1	Lethbridge
16	10	Saskatoon
17	10	Maple Creek
\.


--
-- TOC entry 5103 (class 0 OID 21004)
-- Dependencies: 294
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.countries (id, country_name, country_code) FROM stdin;
1	Afghanistan	AF
2	Aland Islands	AX
3	Albania	AL
4	Algeria	DZ
5	American Samoa	AS
6	Andorra	AD
7	Angola	AO
8	Anguilla	AI
9	Antarctica	AQ
10	Antigua and Barbuda	AG
11	Argentina	AR
12	Armenia	AM
13	Aruba	AW
14	Australia	AU
15	Austria	AT
16	Azerbaijan	AZ
17	Bahamas	BS
18	Bahrain	BH
19	Bangladesh	BD
20	Barbados	BB
21	Belarus	BY
22	Belgium	BE
23	Belize	BZ
24	Benin	BJ
25	Bermuda	BM
26	Bhutan	BT
27	Bolivia	BO
28	Bonaire, Sint Eustatius and Saba	BQ
29	Bosnia and Herzegovina	BA
30	Botswana	BW
31	Bouvet Island	BV
32	Brazil	BR
33	British Indian Ocean Territory	IO
34	Brunei Darussalam	BN
35	Bulgaria	BG
36	Burkina Faso	BF
37	Burundi	BI
38	Cambodia	KH
39	Cameroon	CM
40	Canada	CA
41	Cape Verde	CV
42	Cayman Islands	KY
43	Central African Republic	CF
44	Chad	TD
45	Chile	CL
46	China	CN
47	Christmas Island	CX
48	Cocos (Keeling) Islands	CC
49	Colombia	CO
50	Comoros	KM
51	Congo	CG
52	Congo, Democratic Republic of the Congo	CD
53	Cook Islands	CK
54	Costa Rica	CR
55	Cote D'Ivoire	CI
56	Croatia	HR
57	Cuba	CU
58	Curacao	CW
59	Cyprus	CY
60	Czech Republic	CZ
61	Denmark	DK
62	Djibouti	DJ
63	Dominica	DM
64	Dominican Republic	DO
65	Ecuador	EC
66	Egypt	EG
67	El Salvador	SV
68	Equatorial Guinea	GQ
69	Eritrea	ER
70	Estonia	EE
71	Ethiopia	ET
72	Falkland Islands (Malvinas)	FK
73	Faroe Islands	FO
74	Fiji	FJ
75	Finland	FI
76	France	FR
77	French Guiana	GF
78	French Polynesia	PF
79	French Southern Territories	TF
80	Gabon	GA
81	Gambia	GM
82	Georgia	GE
83	Germany	DE
84	Ghana	GH
85	Gibraltar	GI
86	Greece	GR
87	Greenland	GL
88	Grenada	GD
89	Guadeloupe	GP
90	Guam	GU
91	Guatemala	GT
92	Guernsey	GG
93	Guinea	GN
94	Guinea-Bissau	GW
95	Guyana	GY
96	Haiti	HT
97	Heard Island and Mcdonald Islands	HM
98	Holy See (Vatican City State)	VA
99	Honduras	HN
100	Hong Kong	HK
101	Hungary	HU
102	Iceland	IS
103	India	IN
104	Indonesia	ID
105	Iran, Islamic Republic of	IR
106	Iraq	IQ
107	Ireland	IE
108	Isle of Man	IM
109	Israel	IL
110	Italy	IT
111	Jamaica	JM
112	Japan	JP
113	Jersey	JE
114	Jordan	JO
115	Kazakhstan	KZ
116	Kenya	KE
117	Kiribati	KI
118	Korea, Democratic People's Republic of	KP
119	Korea, Republic of	KR
120	Kosovo	XK
121	Kuwait	KW
122	Kyrgyzstan	KG
123	Lao People's Democratic Republic	LA
124	Latvia	LV
125	Lebanon	LB
126	Lesotho	LS
127	Liberia	LR
128	Libyan Arab Jamahiriya	LY
129	Liechtenstein	LI
130	Lithuania	LT
131	Luxembourg	LU
132	Macao	MO
133	Macedonia, the Former Yugoslav Republic of	MK
134	Madagascar	MG
135	Malawi	MW
136	Malaysia	MY
137	Maldives	MV
138	Mali	ML
139	Malta	MT
140	Marshall Islands	MH
141	Martinique	MQ
142	Mauritania	MR
143	Mauritius	MU
144	Mayotte	YT
145	Mexico	MX
146	Micronesia, Federated States of	FM
147	Moldova, Republic of	MD
148	Monaco	MC
149	Mongolia	MN
150	Montenegro	ME
151	Montserrat	MS
152	Morocco	MA
153	Mozambique	MZ
154	Myanmar	MM
155	Namibia	NA
156	Nauru	NR
157	Nepal	NP
158	Netherlands	NL
159	Netherlands Antilles	AN
160	New Caledonia	NC
161	New Zealand	NZ
162	Nicaragua	NI
163	Niger	NE
164	Nigeria	NG
165	Niue	NU
166	Norfolk Island	NF
167	Northern Mariana Islands	MP
168	Norway	NO
169	Oman	OM
170	Pakistan	PK
171	Palau	PW
172	Palestinian Territory, Occupied	PS
173	Panama	PA
174	Papua New Guinea	PG
175	Paraguay	PY
176	Peru	PE
177	Philippines	PH
178	Pitcairn	PN
179	Poland	PL
180	Portugal	PT
181	Puerto Rico	PR
182	Qatar	QA
183	Reunion	RE
184	Romania	RO
185	Russian Federation	RU
186	Rwanda	RW
187	Saint Barthelemy	BL
188	Saint Helena	SH
189	Saint Kitts and Nevis	KN
190	Saint Lucia	LC
191	Saint Martin	MF
192	Saint Pierre and Miquelon	PM
193	Saint Vincent and the Grenadines	VC
194	Samoa	WS
195	San Marino	SM
196	Sao Tome and Principe	ST
197	Saudi Arabia	SA
198	Senegal	SN
199	Serbia	RS
200	Serbia and Montenegro	CS
201	Seychelles	SC
202	Sierra Leone	SL
203	Singapore	SG
204	Sint Maarten	SX
205	Slovakia	SK
206	Slovenia	SI
207	Solomon Islands	SB
208	Somalia	SO
209	South Africa	ZA
210	South Georgia and the South Sandwich Islands	GS
211	South Sudan	SS
212	Spain	ES
213	Sri Lanka	LK
214	Sudan	SD
215	Suriname	SR
216	Svalbard and Jan Mayen	SJ
217	Swaziland	SZ
218	Sweden	SE
219	Switzerland	CH
220	Syrian Arab Republic	SY
221	Taiwan, Province of China	TW
222	Tajikistan	TJ
223	Tanzania, United Republic of	TZ
224	Thailand	TH
225	Timor-Leste	TL
226	Togo	TG
227	Tokelau	TK
228	Tonga	TO
229	Trinidad and Tobago	TT
230	Tunisia	TN
231	Turkey	TR
232	Turkmenistan	TM
233	Turks and Caicos Islands	TC
234	Tuvalu	TV
235	Uganda	UG
236	Ukraine	UA
237	United Arab Emirates	AE
238	United Kingdom	GB
239	United States	US
240	United States Minor Outlying Islands	UM
241	Uruguay	UY
242	Uzbekistan	UZ
243	Vanuatu	VU
244	Venezuela	VE
245	Viet Nam	VN
246	Virgin Islands, British	VG
247	Virgin Islands, U.s.	VI
248	Wallis and Futuna	WF
249	Western Sahara	EH
250	Yemen	YE
251	Zambia	ZM
252	Zimbabwe	ZW
\.


--
-- TOC entry 5114 (class 0 OID 21085)
-- Dependencies: 305
-- Data for Name: memories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.memories (id, trip_id, memory_text, memory_title) FROM stdin;
\.


--
-- TOC entry 5115 (class 0 OID 21098)
-- Dependencies: 306
-- Data for Name: memory_photo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.memory_photo (memory_id, photo_id) FROM stdin;
\.


--
-- TOC entry 5109 (class 0 OID 21045)
-- Dependencies: 300
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.photos (id, city_id, photo_filepath, date, caption) FROM stdin;
1	17	img001.JPEG	2024-09-04	\N
2	17	img002.JPEG	2024-09-04	\N
3	13	img003.JPEG	2024-08-31	\N
4	13	img004.JPEG	2024-08-31	\N
5	13	img005.JPEG	2024-08-31	\N
6	10	img006.JPEG	2024-04-23	\N
7	10	img007.JPEG	2024-04-23	\N
8	10	img008.JPEG	2024-04-23	\N
9	16	img009.JPEG	2024-08-31	\N
10	16	img010.JPEG	2024-08-31	\N
11	16	img011.JPEG	2024-08-31	\N
12	1	img012.JPEG	2023-06-21	\N
13	1	img013.JPEG	2023-06-21	\N
14	1	img014.JPEG	2023-06-21	\N
15	1	img015.JPEG	2023-06-21	\N
16	1	img016.JPEG	2023-06-21	\N
17	2	img017.JPEG	2023-06-21	\N
18	2	img018.JPEG	2023-06-21	\N
19	9	img019.JPEG	2024-04-27	\N
20	8	img020.JPEG	2024-04-17	\N
21	8	img022.JPEG	2024-04-17	\N
22	8	img021.JPEG	2024-04-17	\N
23	8	img023.JPEG	2024-04-17	\N
24	8	img024.JPEG	2024-04-17	\N
25	8	img025.JPEG	2024-04-17	\N
26	8	img026.JPEG	2024-04-17	\N
27	8	img027.JPEG	2024-04-17	\N
28	11	img028.JPEG	2024-04-17	\N
29	10	img029.JPEG	2024-04-23	\N
30	10	img030.JPEG	2024-04-23	\N
31	10	img031.JPEG	2024-04-23	\N
32	10	img032.JPEG	2024-04-22	\N
33	10	img033.JPEG	2024-04-22	\N
34	10	img034.JPEG	2024-04-22	\N
35	8	img035.JPEG	2024-04-19	\N
36	10	img036.JPEG	2024-04-23	\N
37	5	img037.JPEG	2024-02-25	\N
38	5	img038.JPEG	2024-02-25	\N
39	5	img039.JPEG	2024-02-25	\N
40	7	img040.JPEG	2024-02-23	\N
41	7	img041.JPEG	2024-02-23	\N
42	7	img042.JPEG	2024-02-23	\N
43	7	img043.JPEG	2024-02-23	\N
44	7	img044.JPEG	2024-02-23	\N
\.


--
-- TOC entry 5105 (class 0 OID 21017)
-- Dependencies: 296
-- Data for Name: provinces; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.provinces (id, country_id, province_name, province_code) FROM stdin;
1	40	Alberta	AB
2	40	British Columbia	BC
3	40	Manitoba	MB
4	40	New Brunswick	NB
5	40	Newfoundland and Labrador	NL
6	40	Nova Scotia	NS
7	40	Ontario	ON
8	40	Prince Edward Island	PE
9	40	Quebec	QC
10	40	Saskatchewan	SK
11	83	Baden-Württemberg	BW
12	83	Bavaria	BY
13	83	Berlin	BE
14	83	Brandenburg	BB
15	83	Bremen	HB
16	83	Hamburg	HH
17	83	Hesse	HE
18	83	Lower Saxony	NI
19	83	Mecklenburg-Vorpommern	MV
20	83	North Rhine-Westphalia	NW
21	83	Rhineland-Palatinate	RP
22	83	Saarland	SL
23	83	Saxony	SN
24	83	Saxony-Anhalt	ST
25	83	Schleswig-Holstein	SH
26	83	Thuringia	TH
27	180	Aveiro	AV
28	180	Beja	BG
29	180	Braga	BR
30	180	Bragança	BA
31	180	Castelo Branco	CB
32	180	Coimbra	CO
33	180	Évora	EV
34	180	Faro	FO
35	180	Guarda	GU
36	180	Leiria	LE
37	180	Lisbon	LS
38	180	Madeira	MA
39	180	Portalegre	PG
40	180	Porto	PO
41	180	Santarém	SA
42	180	Setúbal	SU
43	180	Viana do Castelo	VC
44	180	Vila Real	VR
45	239	Alabama	AL
46	239	Alaska	AK
47	239	Arizona	AZ
48	239	Arkansas	AR
49	239	California	CA
50	239	Colorado	CO
51	239	Connecticut	CT
52	239	Delaware	DE
53	239	Florida	FL
54	239	Georgia	GA
55	239	Hawaii	HI
56	239	Idaho	ID
57	239	Illinois	IL
58	239	Indiana	IN
59	239	Iowa	IA
60	239	Kansas	KS
61	239	Kentucky	KY
62	239	Louisiana	LA
63	239	Maine	ME
64	239	Maryland	MD
65	239	Massachusetts	MA
66	239	Michigan	MI
67	239	Minnesota	MN
68	239	Mississippi	MS
69	239	Missouri	MO
70	239	Montana	MT
71	239	Nebraska	NE
72	239	Nevada	NV
73	239	New Hampshire	NH
74	239	New Jersey	NJ
75	239	New Mexico	NM
76	239	New York	NY
77	239	North Carolina	NC
78	239	North Dakota	ND
79	239	Ohio	OH
80	239	Oklahoma	OK
81	239	Oregon	OR
82	239	Pennsylvania	PA
83	239	Rhode Island	RI
84	239	South Carolina	SC
85	239	South Dakota	SD
86	239	Tennessee	TN
87	239	Texas	TX
88	239	Utah	UT
89	239	Vermont	VT
90	239	Virginia	VA
91	239	Washington	WA
92	239	West Virginia	WV
93	239	Wisconsin	WI
94	239	Wyoming	WY
95	11	Buenos Aires	B
96	11	Catamarca	K
97	11	Chaco	H
98	11	Chubut	U
99	11	CABA (Ciudad Autónoma de Buenos Aires)	CABA
100	11	Córdoba	X
101	11	Corrientes	W
102	11	Entre Ríos	E
103	11	Formosa	P
104	11	Jujuy	Y
105	11	La Pampa	L
106	11	La Rioja	F
107	11	Mendoza	M
108	11	Misiones	N
109	11	Neuquén	Q
110	11	Río Negro	R
111	11	Salta	A
112	11	San Juan	J
113	11	San Luis	D
114	11	Santa Cruz	Z
115	11	Santa Fe	S
116	11	Santiago del Estero	G
117	11	Tierra del Fuego	V
118	11	Tucumán	T
119	45	Arica y Parinacota	AP
120	45	Antofagasta	AN
121	45	Atacama	AT
122	45	Coquimbo	CO
123	45	Valparaíso	V
124	45	O'Higgins	OH
125	45	Maule	ML
126	45	Ñuble	NB
127	45	Biobío	BI
128	45	La Araucanía	LA
129	45	Los Ríos	LR
130	45	Los Lagos	LL
131	45	Aysén del General Carlos Ibáñez del Campo	AI
132	45	Magallanes y de la Antártica Chilena	MA
133	45	Metropolitana de Santiago	RM
134	45	Los Lagos	LL
135	173	Bocas del Toro	01
136	173	Coclé	02
137	173	Colón	03
138	173	Chiriquí	04
139	173	Herrera	05
140	173	Los Santos	06
141	173	Panamá	07
142	173	Veraguas	08
143	173	Darién	09
144	173	Emberá	10
\.


--
-- TOC entry 4869 (class 0 OID 19434)
-- Dependencies: 232
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- TOC entry 5112 (class 0 OID 21069)
-- Dependencies: 303
-- Data for Name: trip_location; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.trip_location (trip_id, city_id) FROM stdin;
\.


--
-- TOC entry 5116 (class 0 OID 21124)
-- Dependencies: 307
-- Data for Name: trip_photos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.trip_photos (trip_id, photo_id) FROM stdin;
4	1
4	2
4	3
4	4
4	5
1	6
1	7
1	8
4	9
4	10
4	11
6	12
6	13
6	14
6	15
6	16
6	17
6	18
1	19
1	20
1	21
1	22
1	23
1	24
1	25
1	26
1	27
1	28
1	29
1	30
1	31
1	32
1	33
1	34
1	35
1	36
5	37
5	38
5	39
5	40
5	41
5	42
5	43
5	44
\.


--
-- TOC entry 5111 (class 0 OID 21061)
-- Dependencies: 302
-- Data for Name: trips; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.trips (id, trip_date, trip_text, trip_name) FROM stdin;
1	2024-04-15	\N	3 Weeks in Argentina
2	2023-12-27	\N	3 Weeks in Germany and Austria
3	2024-12-15	\N	3 Weeks in Germany and Austria II
4	2024-08-08	\N	Roadtrip through the Prairies
5	2024-02-17	\N	A Week in Portugal
6	2023-06-06	\N	A Week in the Rockies
\.


--
-- TOC entry 4873 (class 0 OID 20373)
-- Dependencies: 243
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: -
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- TOC entry 4874 (class 0 OID 20705)
-- Dependencies: 288
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: -
--

COPY tiger.pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- TOC entry 4875 (class 0 OID 20715)
-- Dependencies: 290
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: -
--

COPY tiger.pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- TOC entry 4876 (class 0 OID 20725)
-- Dependencies: 292
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: -
--

COPY tiger.pagc_rules (id, rule, is_custom) FROM stdin;
\.


--
-- TOC entry 4871 (class 0 OID 20187)
-- Dependencies: 237
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: -
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- TOC entry 4872 (class 0 OID 20199)
-- Dependencies: 238
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: -
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 297
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cities_id_seq', 17, true);


--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 293
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.countries_id_seq', 252, true);


--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 304
-- Name: memories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.memories_id_seq', 1, false);


--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 299
-- Name: photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.photos_id_seq', 44, true);


--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 295
-- Name: provinces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.provinces_id_seq', 144, true);


--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 301
-- Name: trips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.trips_id_seq', 6, true);


--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 236
-- Name: topology_id_seq; Type: SEQUENCE SET; Schema: topology; Owner: -
--

SELECT pg_catalog.setval('topology.topology_id_seq', 1, false);


--
-- TOC entry 4924 (class 2606 OID 21038)
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- TOC entry 4914 (class 2606 OID 21015)
-- Name: countries countries_country_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_country_code_key UNIQUE (country_code);


--
-- TOC entry 4916 (class 2606 OID 21013)
-- Name: countries countries_country_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_country_name_key UNIQUE (country_name);


--
-- TOC entry 4918 (class 2606 OID 21011)
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- TOC entry 4936 (class 2606 OID 21092)
-- Name: memories memories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.memories
    ADD CONSTRAINT memories_pkey PRIMARY KEY (id);


--
-- TOC entry 4939 (class 2606 OID 21102)
-- Name: memory_photo memory_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.memory_photo
    ADD CONSTRAINT memory_photo_pkey PRIMARY KEY (memory_id, photo_id);


--
-- TOC entry 4927 (class 2606 OID 21054)
-- Name: photos photos_photo_filepath_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_photo_filepath_key UNIQUE (photo_filepath);


--
-- TOC entry 4929 (class 2606 OID 21052)
-- Name: photos photos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_pkey PRIMARY KEY (id);


--
-- TOC entry 4922 (class 2606 OID 21024)
-- Name: provinces provinces_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT provinces_pkey PRIMARY KEY (id);


--
-- TOC entry 4934 (class 2606 OID 21073)
-- Name: trip_location trip_location_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trip_location
    ADD CONSTRAINT trip_location_pkey PRIMARY KEY (trip_id, city_id);


--
-- TOC entry 4941 (class 2606 OID 21128)
-- Name: trip_photos trip_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trip_photos
    ADD CONSTRAINT trip_photos_pkey PRIMARY KEY (trip_id, photo_id);


--
-- TOC entry 4932 (class 2606 OID 21068)
-- Name: trips trips_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_pkey PRIMARY KEY (id);


--
-- TOC entry 4925 (class 1259 OID 21121)
-- Name: ngramscities_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ngramscities_idx ON public.cities USING bm25 (id, city_name) WITH (key_field=id, text_fields='{"city_name": {"tokenizer": {"type": "ngram", "min_gram": 1, "max_gram": 3, "prefix_only": true}}}');


--
-- TOC entry 4919 (class 1259 OID 21118)
-- Name: ngramscountries_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ngramscountries_idx ON public.countries USING bm25 (id, country_name) WITH (key_field=id, text_fields='{"country_name": {"tokenizer": {"type": "ngram", "min_gram": 1, "max_gram": 3, "prefix_only": true}}}');


--
-- TOC entry 4937 (class 1259 OID 21123)
-- Name: ngramsmemories_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ngramsmemories_idx ON public.memories USING bm25 (id, memory_title) WITH (key_field=id, text_fields='{"memory_title": {"tokenizer": {"type": "ngram", "min_gram": 1, "max_gram": 3, "prefix_only": true}}}');


--
-- TOC entry 4920 (class 1259 OID 21120)
-- Name: ngramsprovinces_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ngramsprovinces_idx ON public.provinces USING bm25 (id, province_name) WITH (key_field=id, text_fields='{"province_name": {"tokenizer": {"type": "ngram", "min_gram": 1, "max_gram": 3, "prefix_only": true}}}');


--
-- TOC entry 4930 (class 1259 OID 21139)
-- Name: ngramstrips_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ngramstrips_idx ON public.trips USING bm25 (id, trip_name) WITH (key_field=id, text_fields='{"trip_name": {"tokenizer": {"type": "ngram", "min_gram": 1, "max_gram": 3, "prefix_only": false}}}');


--
-- TOC entry 4943 (class 2606 OID 21039)
-- Name: cities cities_province_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_province_id_fkey FOREIGN KEY (province_id) REFERENCES public.provinces(id);


--
-- TOC entry 4947 (class 2606 OID 21093)
-- Name: memories memories_trip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.memories
    ADD CONSTRAINT memories_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trips(id);


--
-- TOC entry 4948 (class 2606 OID 21103)
-- Name: memory_photo memory_photo_memory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.memory_photo
    ADD CONSTRAINT memory_photo_memory_id_fkey FOREIGN KEY (memory_id) REFERENCES public.memories(id);


--
-- TOC entry 4949 (class 2606 OID 21108)
-- Name: memory_photo memory_photo_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.memory_photo
    ADD CONSTRAINT memory_photo_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES public.photos(id);


--
-- TOC entry 4944 (class 2606 OID 21055)
-- Name: photos photos_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id);


--
-- TOC entry 4942 (class 2606 OID 21025)
-- Name: provinces provinces_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT provinces_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.countries(id);


--
-- TOC entry 4945 (class 2606 OID 21079)
-- Name: trip_location trip_location_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trip_location
    ADD CONSTRAINT trip_location_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id);


--
-- TOC entry 4946 (class 2606 OID 21074)
-- Name: trip_location trip_location_trip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trip_location
    ADD CONSTRAINT trip_location_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trips(id);


--
-- TOC entry 4950 (class 2606 OID 21134)
-- Name: trip_photos trip_photos_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trip_photos
    ADD CONSTRAINT trip_photos_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES public.photos(id);


--
-- TOC entry 4951 (class 2606 OID 21129)
-- Name: trip_photos trip_photos_trip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trip_photos
    ADD CONSTRAINT trip_photos_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trips(id);


-- Completed on 2025-01-18 17:19:27 UTC

--
-- PostgreSQL database dump complete
--

