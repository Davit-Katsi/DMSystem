--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

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
-- Name: enum_DriverProfiles_availability; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_DriverProfiles_availability" AS ENUM (
    'Available',
    'On-Duty',
    'Offline'
);


ALTER TYPE public."enum_DriverProfiles_availability" OWNER TO postgres;

--
-- Name: enum_DriverProfiles_employment_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_DriverProfiles_employment_status" AS ENUM (
    'Business',
    'Individual'
);


ALTER TYPE public."enum_DriverProfiles_employment_status" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: DriverProfiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."DriverProfiles" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    phone_number character varying(255) NOT NULL,
    email character varying(255),
    address text,
    license_number character varying(255) NOT NULL,
    license_expiration timestamp with time zone NOT NULL,
    employment_status public."enum_DriverProfiles_employment_status" NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "SSN" character varying(255),
    "EIN" character varying(255),
    unit_number character varying(4),
    individual_name character varying(255),
    individual_address character varying(255),
    company_name character varying(255),
    company_address character varying(255),
    availability public."enum_DriverProfiles_availability" DEFAULT 'Offline'::public."enum_DriverProfiles_availability" NOT NULL,
    zip_code character varying(10)
);


ALTER TABLE public."DriverProfiles" OWNER TO postgres;

--
-- Name: DriverProfiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."DriverProfiles_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."DriverProfiles_id_seq" OWNER TO postgres;

--
-- Name: DriverProfiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."DriverProfiles_id_seq" OWNED BY public."DriverProfiles".id;


--
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    role character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- Name: Users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Users_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Users_id_seq" OWNER TO postgres;

--
-- Name: Users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Users_id_seq" OWNED BY public."Users".id;


--
-- Name: Vehicles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Vehicles" (
    id integer NOT NULL,
    make character varying(255) NOT NULL,
    model character varying(255) NOT NULL,
    type character varying(255),
    trunk_width double precision,
    trunk_length double precision,
    trunk_height double precision,
    capacity_ton double precision,
    capacity_m3 double precision,
    license_plate character varying(255) NOT NULL,
    insurance_details text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "driverProfileId" integer
);


ALTER TABLE public."Vehicles" OWNER TO postgres;

--
-- Name: Vehicles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Vehicles_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Vehicles_id_seq" OWNER TO postgres;

--
-- Name: Vehicles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Vehicles_id_seq" OWNED BY public."Vehicles".id;


--
-- Name: DriverProfiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles" ALTER COLUMN id SET DEFAULT nextval('public."DriverProfiles_id_seq"'::regclass);


--
-- Name: Users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users" ALTER COLUMN id SET DEFAULT nextval('public."Users_id_seq"'::regclass);


--
-- Name: Vehicles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Vehicles" ALTER COLUMN id SET DEFAULT nextval('public."Vehicles_id_seq"'::regclass);


--
-- Data for Name: DriverProfiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."DriverProfiles" (id, name, phone_number, email, address, license_number, license_expiration, employment_status, "createdAt", "updatedAt", "SSN", "EIN", unit_number, individual_name, individual_address, company_name, company_address, availability, zip_code) FROM stdin;
1	Jane Smith	564-654-6524	jane.smith@example.com	456 Elm St, City, State	B7654321	2026-06-30 04:00:00+04	Business	2025-02-02 13:34:26.029+04	2025-02-06 23:57:53.066+04	\N	56-4231321	1234	\N	\N	LLC Two	456 Elm St, City, State	On-Duty	61321
25	Jarmain Foden	546-543-2132	jar@yahoo.com	310 3rd Ave, New York, NY 10010, USA		2025-03-04 04:00:00+04	Business	2025-02-05 21:40:55.487+04	2025-02-07 00:48:51.733+04	\N	65-1321321	2316			LLC NoNO	16 Washington Mews, New York, NY 10003, USA	On-Duty	41042
23	Hove Legger	895-321-2224	dashash@yahoo.com	610 E 20th St, New York, NY 10009, USA		2025-08-28 04:00:00+04	Business	2025-02-05 16:45:43.262+04	2025-02-07 00:49:02.706+04	\N	21-3215646	8915			LLC One Step	Rubin Residence Hall, New York, NY 10003, USA	On-Duty	21234
22	Phil Collins	562-313-2132	collins@yahoo.com	371 7th Ave, New York, NY 10001		2025-09-25 04:00:00+04	Individual	2025-02-05 00:12:19.908+04	2025-02-07 00:49:07.114+04	561-32-1321	\N	8234	\N	\N	\N	\N	On-Duty	33020
24	William Defoe Spears	651-321-3213	will@yahoo.com	70 Washington Square South, New York, NY 10012, United States		2025-03-01 04:00:00+04	Individual	2025-02-05 21:39:29.753+04	2025-02-16 01:34:21.763+04	213-54-6132	\N	8945	William Defoe Spears	70 Washington Square South, New York, NY 10012, United States			Available	49512
26	Nicolo Puicolo	897-513-2125	nickpic@gmail.com	50 W 4th St, New York, NY 10012, USA		2025-02-24 04:00:00+04	Business	2025-02-05 21:43:29.882+04	2025-02-16 01:39:58.534+04	\N	54-1321321	8965			LLC nicpic	22 Washington Square N, New York, NY 10011, USA	Available	30252
9	Davit Kaikatsishvili	562-312-1321	davitkaikatsishvili@gmail.com	Apt 31, 18 S. Tsintsadze Street	5432135642	2025-02-26 04:00:00+04	Individual	2025-02-02 16:38:48.595+04	2025-02-15 22:44:48.024+04	555-55-5555		5623	Davit Kaikatsishvili	Apt 31, 18 S. Tsintsadze Street	\N	\N	Available	49301
21	Ivane Peradze	212-456-7890	ivane@gmail.com	838 Broadway, New York, NY 10003, USA		2025-02-26 04:00:00+04	Individual	2025-02-04 23:59:31.955+04	2025-02-16 03:04:51.339+04	652-31-3211	\N	5231	Ivane Peradze	838 Broadway, New York, NY 10003, USA	\N	\N	Available	33324
20	Gia Guruli	599-859-4455	giaguruli@gmail.com	Apt 31, 18 S. Tsintsadze Street	652132156213	2025-01-30 04:00:00+04	Individual	2025-02-02 19:05:54.206+04	2025-02-16 01:30:40.763+04	894-23-1321	\N	8951	Gia Guruli	Apt 31, 18 S. Tsintsadze Street	\N	\N	On-Duty	30052
28	Mike Brown	489-795-6432	mikemike@dodo.com	157 East Road, 56487 GA		2025-02-15 04:00:00+04	Individual	2025-02-16 15:15:08.05+04	2025-02-16 20:17:19.544+04	897-56-4231	\N	5879	Mike Brown	157 East Road			On-Duty	49301
27	Mark Bullberg	512-486-4775	mark@gmail.com	40 W 4th St, New York, NY 10012, USA		2025-03-27 04:00:00+04	Individual	2025-02-05 22:07:23.408+04	2025-02-16 20:17:27.665+04	231-56-4875	\N	2155	Mark Bullberg	40 W 4th St, New York, NY 10012, USA			On-Duty	49546
19	Gia Guruli	961-231-3211	giaguruli@gmail.com	Apt 31, 18 S. Tsintsadze Street	652132156213	2025-02-27 04:00:00+04	Business	2025-02-02 19:05:34.735+04	2025-02-18 03:05:54.223+04	\N	56-1321564	1258	\N	\N	LLC HuHu	Apt 31, 18 S. Tsintsadze Street	Available	11212
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Users" (id, username, email, role, "createdAt", "updatedAt", password) FROM stdin;
5	davidk	davitkaikatsishvili@gmail.com	recruiter	2025-02-03 23:49:21.76+04	2025-02-03 23:49:21.76+04	$2b$10$DUeqPXy4OwsL8dKbsjBI8Od7HzTa1bAKmjQPbMYA2oHHOZEYiULaO
6	vazha	aimarket02052020@gmail.com	dispatcher	2025-02-03 23:49:51+04	2025-02-03 23:49:51+04	$2b$10$i7WjkTt7JNZybggmC4O9.OVNp0ZZwGEnJbBvaKC98VD7Igrjr63aS
7	shota	kaikatsishvilidavit@gmail.com	recruiter	2025-02-03 23:51:45.096+04	2025-02-03 23:52:23.416+04	$2b$10$Rizn1xNBhS/A4kCFJDmSxeQoAbW7Y3ezacPncwXdogaWv7F7YWlSe
20	Zira	qeti.vibliani@gmail.com	admin	2025-02-04 01:24:37.381+04	2025-02-04 01:24:37.381+04	$2b$10$FlVLDSW7Gki3yk4Df7gX.Oxuai7TGZrTd49Umcoy.GZSmZI4g4Jl2
23	Qeti	mariamgigineishvili23@gmail.com	recruiter	2025-02-04 01:44:22.743+04	2025-02-04 01:44:22.743+04	$2b$10$/4LxfwggEt0EuS2UrXEUk.PTs1u2C43eRk2FE3qQg2wn/0vm9SV0y
2	adminUser	admin@example.com	admin	2025-02-03 02:01:50.575+04	2025-02-04 20:23:06.828+04	$2b$10$eHevryk6Ep0Y/PTp2jzU9uRGrkUi0uW42/1fs4vPMeWQV8v.LRspu
24	Davit Kaikatsishvili	david.k@bk.ru	admin	2025-02-15 22:15:16.037+04	2025-02-15 22:16:12.878+04	$2b$10$QCZ13H5K70RZ5fhqsyQebuLJIBOUy477wlL8xDbHT54ohbH3XVPCG
\.


--
-- Data for Name: Vehicles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Vehicles" (id, make, model, type, trunk_width, trunk_length, trunk_height, capacity_ton, capacity_m3, license_plate, insurance_details, "createdAt", "updatedAt", "driverProfileId") FROM stdin;
9	Volvo	C5	Pickup	4	5	2	10	8	5045-50321-5445	Healtyh	2025-02-02 19:05:54.207+04	2025-02-02 19:05:54.207+04	20
10	BWM	M5	Pickup	2	3	3	2	2	561321321	Private	2025-02-04 23:59:31.98+04	2025-02-04 23:59:31.98+04	21
11	Alfa Romeo	Julia	Box Truck	4	4	3	3	3	2313-52120	JohnDeer	2025-02-05 00:12:19.91+04	2025-02-05 00:12:19.91+04	22
1	Volvo	FH16	Truck	2.5	7.5	3	20	50	XYZ-1234	Insured with ABC Insurance	2025-02-02 13:34:26.076+04	2025-02-02 13:34:26.076+04	1
2	Volvo	C5	Truck	1	4	2	4	3	5045-50321-5445	Private	2025-02-02 16:38:48.603+04	2025-02-02 16:38:48.603+04	9
12	Mercedes Benz	K10	Box Truck	2	3	2	54	215	5644ABK	Aloha	2025-02-05 16:45:43.277+04	2025-02-05 16:45:43.277+04	23
13	BWM	Longer	Truck	2	7.5	2	5	42	5644ABK	Noland	2025-02-05 21:39:29.762+04	2025-02-05 21:39:29.762+04	24
14	Volvo	FH16	Pickup	4	3	2	5	75	5635132-54	Not Private	2025-02-05 21:40:55.49+04	2025-02-05 21:40:55.49+04	25
15	Alfa Romeo	C5	Truck	1	3	2	2	4	5644ABK	Medicare	2025-02-05 21:43:29.884+04	2025-02-05 21:43:29.884+04	26
16	Volvo	K10	Pickup	1	5	3	3	54	5045-50321-5445	NONO	2025-02-05 22:07:23.416+04	2025-02-05 22:07:23.416+04	27
17	BWM	Longer	Pickup	2	3	3	8	25	XYZ-1234	AASS	2025-02-16 15:15:08.146+04	2025-02-16 15:15:08.146+04	28
8	Volvo	C5	Pickup	4	5	2	5	10	5045-50321-5445	Healtyh	2025-02-02 19:05:34.737+04	2025-02-18 03:05:54.253+04	19
\.


--
-- Name: DriverProfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."DriverProfiles_id_seq"', 28, true);


--
-- Name: Users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Users_id_seq"', 24, true);


--
-- Name: Vehicles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Vehicles_id_seq"', 17, true);


--
-- Name: DriverProfiles DriverProfiles_EIN_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key1" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key10" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key100; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key100" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key101; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key101" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key102; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key102" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key103; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key103" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key104; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key104" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key105; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key105" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key106; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key106" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key107; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key107" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key108; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key108" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key109; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key109" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key11" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key12" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key13" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key14" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key15" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key16" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key17" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key18" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key19" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key2" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key20" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key21" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key22" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key23" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key24" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key25" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key26" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key27" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key28" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key29" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key3" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key30" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key31" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key32" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key33" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key34" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key35" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key36" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key37" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key38" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key39" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key4" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key40" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key41" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key42" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key43" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key44" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key45" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key46" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key47" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key48" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key49" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key5" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key50" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key51" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key52" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key53" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key54" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key55" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key56" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key57" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key58" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key59" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key6" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key60" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key61" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key62" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key63" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key64" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key65" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key66" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key67" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key68" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key69" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key7" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key70" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key71" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key72" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key73" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key74" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key75" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key76" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key77; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key77" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key78; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key78" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key79" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key8" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key80" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key81" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key82" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key83; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key83" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key84" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key85; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key85" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key86; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key86" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key87; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key87" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key88; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key88" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key89; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key89" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key9" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key90" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key91" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key92" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key93" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key94; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key94" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key95; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key95" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key96; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key96" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key97" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key98" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_EIN_key99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key99" UNIQUE ("EIN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key1" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key10" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key100; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key100" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key101; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key101" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key102; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key102" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key103; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key103" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key104; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key104" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key105; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key105" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key106; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key106" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key107; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key107" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key108; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key108" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key109; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key109" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key11" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key12" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key13" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key14" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key15" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key16" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key17" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key18" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key19" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key2" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key20" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key21" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key22" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key23" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key24" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key25" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key26" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key27" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key28" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key29" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key3" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key30" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key31" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key32" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key33" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key34" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key35" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key36" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key37" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key38" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key39" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key4" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key40" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key41" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key42" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key43" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key44" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key45" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key46" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key47" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key48" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key49" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key5" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key50" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key51" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key52" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key53" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key54" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key55" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key56" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key57" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key58" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key59" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key6" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key60" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key61" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key62" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key63" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key64" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key65" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key66" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key67" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key68" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key69" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key7" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key70" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key71" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key72" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key73" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key74" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key75" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key76" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key77; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key77" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key78; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key78" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key79" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key8" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key80" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key81" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key82" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key83; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key83" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key84" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key85; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key85" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key86; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key86" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key87; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key87" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key88; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key88" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key89; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key89" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key9" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key90" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key91" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key92" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key93" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key94; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key94" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key95; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key95" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key96; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key96" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key97" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key98" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_SSN_key99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key99" UNIQUE ("SSN");


--
-- Name: DriverProfiles DriverProfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_pkey" PRIMARY KEY (id);


--
-- Name: Users Users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key" UNIQUE (email);


--
-- Name: Users Users_email_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key1" UNIQUE (email);


--
-- Name: Users Users_email_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key10" UNIQUE (email);


--
-- Name: Users Users_email_key100; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key100" UNIQUE (email);


--
-- Name: Users Users_email_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key11" UNIQUE (email);


--
-- Name: Users Users_email_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key12" UNIQUE (email);


--
-- Name: Users Users_email_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key13" UNIQUE (email);


--
-- Name: Users Users_email_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key14" UNIQUE (email);


--
-- Name: Users Users_email_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key15" UNIQUE (email);


--
-- Name: Users Users_email_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key16" UNIQUE (email);


--
-- Name: Users Users_email_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key17" UNIQUE (email);


--
-- Name: Users Users_email_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key18" UNIQUE (email);


--
-- Name: Users Users_email_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key19" UNIQUE (email);


--
-- Name: Users Users_email_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key2" UNIQUE (email);


--
-- Name: Users Users_email_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key20" UNIQUE (email);


--
-- Name: Users Users_email_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key21" UNIQUE (email);


--
-- Name: Users Users_email_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key22" UNIQUE (email);


--
-- Name: Users Users_email_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key23" UNIQUE (email);


--
-- Name: Users Users_email_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key24" UNIQUE (email);


--
-- Name: Users Users_email_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key25" UNIQUE (email);


--
-- Name: Users Users_email_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key26" UNIQUE (email);


--
-- Name: Users Users_email_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key27" UNIQUE (email);


--
-- Name: Users Users_email_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key28" UNIQUE (email);


--
-- Name: Users Users_email_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key29" UNIQUE (email);


--
-- Name: Users Users_email_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key3" UNIQUE (email);


--
-- Name: Users Users_email_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key30" UNIQUE (email);


--
-- Name: Users Users_email_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key31" UNIQUE (email);


--
-- Name: Users Users_email_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key32" UNIQUE (email);


--
-- Name: Users Users_email_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key33" UNIQUE (email);


--
-- Name: Users Users_email_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key34" UNIQUE (email);


--
-- Name: Users Users_email_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key35" UNIQUE (email);


--
-- Name: Users Users_email_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key36" UNIQUE (email);


--
-- Name: Users Users_email_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key37" UNIQUE (email);


--
-- Name: Users Users_email_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key38" UNIQUE (email);


--
-- Name: Users Users_email_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key39" UNIQUE (email);


--
-- Name: Users Users_email_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key4" UNIQUE (email);


--
-- Name: Users Users_email_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key40" UNIQUE (email);


--
-- Name: Users Users_email_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key41" UNIQUE (email);


--
-- Name: Users Users_email_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key42" UNIQUE (email);


--
-- Name: Users Users_email_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key43" UNIQUE (email);


--
-- Name: Users Users_email_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key44" UNIQUE (email);


--
-- Name: Users Users_email_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key45" UNIQUE (email);


--
-- Name: Users Users_email_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key46" UNIQUE (email);


--
-- Name: Users Users_email_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key47" UNIQUE (email);


--
-- Name: Users Users_email_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key48" UNIQUE (email);


--
-- Name: Users Users_email_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key49" UNIQUE (email);


--
-- Name: Users Users_email_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key5" UNIQUE (email);


--
-- Name: Users Users_email_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key50" UNIQUE (email);


--
-- Name: Users Users_email_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key51" UNIQUE (email);


--
-- Name: Users Users_email_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key52" UNIQUE (email);


--
-- Name: Users Users_email_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key53" UNIQUE (email);


--
-- Name: Users Users_email_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key54" UNIQUE (email);


--
-- Name: Users Users_email_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key55" UNIQUE (email);


--
-- Name: Users Users_email_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key56" UNIQUE (email);


--
-- Name: Users Users_email_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key57" UNIQUE (email);


--
-- Name: Users Users_email_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key58" UNIQUE (email);


--
-- Name: Users Users_email_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key59" UNIQUE (email);


--
-- Name: Users Users_email_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key6" UNIQUE (email);


--
-- Name: Users Users_email_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key60" UNIQUE (email);


--
-- Name: Users Users_email_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key61" UNIQUE (email);


--
-- Name: Users Users_email_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key62" UNIQUE (email);


--
-- Name: Users Users_email_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key63" UNIQUE (email);


--
-- Name: Users Users_email_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key64" UNIQUE (email);


--
-- Name: Users Users_email_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key65" UNIQUE (email);


--
-- Name: Users Users_email_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key66" UNIQUE (email);


--
-- Name: Users Users_email_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key67" UNIQUE (email);


--
-- Name: Users Users_email_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key68" UNIQUE (email);


--
-- Name: Users Users_email_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key69" UNIQUE (email);


--
-- Name: Users Users_email_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key7" UNIQUE (email);


--
-- Name: Users Users_email_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key70" UNIQUE (email);


--
-- Name: Users Users_email_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key71" UNIQUE (email);


--
-- Name: Users Users_email_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key72" UNIQUE (email);


--
-- Name: Users Users_email_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key73" UNIQUE (email);


--
-- Name: Users Users_email_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key74" UNIQUE (email);


--
-- Name: Users Users_email_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key75" UNIQUE (email);


--
-- Name: Users Users_email_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key76" UNIQUE (email);


--
-- Name: Users Users_email_key77; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key77" UNIQUE (email);


--
-- Name: Users Users_email_key78; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key78" UNIQUE (email);


--
-- Name: Users Users_email_key79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key79" UNIQUE (email);


--
-- Name: Users Users_email_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key8" UNIQUE (email);


--
-- Name: Users Users_email_key80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key80" UNIQUE (email);


--
-- Name: Users Users_email_key81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key81" UNIQUE (email);


--
-- Name: Users Users_email_key82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key82" UNIQUE (email);


--
-- Name: Users Users_email_key83; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key83" UNIQUE (email);


--
-- Name: Users Users_email_key84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key84" UNIQUE (email);


--
-- Name: Users Users_email_key85; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key85" UNIQUE (email);


--
-- Name: Users Users_email_key86; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key86" UNIQUE (email);


--
-- Name: Users Users_email_key87; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key87" UNIQUE (email);


--
-- Name: Users Users_email_key88; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key88" UNIQUE (email);


--
-- Name: Users Users_email_key89; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key89" UNIQUE (email);


--
-- Name: Users Users_email_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key9" UNIQUE (email);


--
-- Name: Users Users_email_key90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key90" UNIQUE (email);


--
-- Name: Users Users_email_key91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key91" UNIQUE (email);


--
-- Name: Users Users_email_key92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key92" UNIQUE (email);


--
-- Name: Users Users_email_key93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key93" UNIQUE (email);


--
-- Name: Users Users_email_key94; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key94" UNIQUE (email);


--
-- Name: Users Users_email_key95; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key95" UNIQUE (email);


--
-- Name: Users Users_email_key96; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key96" UNIQUE (email);


--
-- Name: Users Users_email_key97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key97" UNIQUE (email);


--
-- Name: Users Users_email_key98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key98" UNIQUE (email);


--
-- Name: Users Users_email_key99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key99" UNIQUE (email);


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- Name: Vehicles Vehicles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Vehicles"
    ADD CONSTRAINT "Vehicles_pkey" PRIMARY KEY (id);


--
-- Name: Vehicles Vehicles_driverProfileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Vehicles"
    ADD CONSTRAINT "Vehicles_driverProfileId_fkey" FOREIGN KEY ("driverProfileId") REFERENCES public."DriverProfiles"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

