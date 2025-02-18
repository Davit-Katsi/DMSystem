PGDMP  %                    }            driver_management_system    17.2    17.2 ]   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    24781    driver_management_system    DATABASE     �   CREATE DATABASE driver_management_system WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Georgian_Georgia.1252';
 (   DROP DATABASE driver_management_system;
                     postgres    false            _           1247    33895     enum_DriverProfiles_availability    TYPE     q   CREATE TYPE public."enum_DriverProfiles_availability" AS ENUM (
    'Available',
    'On-Duty',
    'Offline'
);
 5   DROP TYPE public."enum_DriverProfiles_availability";
       public               postgres    false            S           1247    24783 %   enum_DriverProfiles_employment_status    TYPE     i   CREATE TYPE public."enum_DriverProfiles_employment_status" AS ENUM (
    'Business',
    'Individual'
);
 :   DROP TYPE public."enum_DriverProfiles_employment_status";
       public               postgres    false            �            1259    24788    DriverProfiles    TABLE     �  CREATE TABLE public."DriverProfiles" (
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
 $   DROP TABLE public."DriverProfiles";
       public         heap r       postgres    false    863    863    851            �            1259    24787    DriverProfiles_id_seq    SEQUENCE     �   CREATE SEQUENCE public."DriverProfiles_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."DriverProfiles_id_seq";
       public               postgres    false    218            �           0    0    DriverProfiles_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public."DriverProfiles_id_seq" OWNED BY public."DriverProfiles".id;
          public               postgres    false    217            �            1259    25125    Users    TABLE     P  CREATE TABLE public."Users" (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    role character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    password character varying(255) NOT NULL
);
    DROP TABLE public."Users";
       public         heap r       postgres    false            �            1259    25124    Users_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Users_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public."Users_id_seq";
       public               postgres    false    222            �           0    0    Users_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public."Users_id_seq" OWNED BY public."Users".id;
          public               postgres    false    221            �            1259    24803    Vehicles    TABLE     3  CREATE TABLE public."Vehicles" (
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
    DROP TABLE public."Vehicles";
       public         heap r       postgres    false            �            1259    24802    Vehicles_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Vehicles_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."Vehicles_id_seq";
       public               postgres    false    220            �           0    0    Vehicles_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public."Vehicles_id_seq" OWNED BY public."Vehicles".id;
          public               postgres    false    219            g           2604    24791    DriverProfiles id    DEFAULT     z   ALTER TABLE ONLY public."DriverProfiles" ALTER COLUMN id SET DEFAULT nextval('public."DriverProfiles_id_seq"'::regclass);
 B   ALTER TABLE public."DriverProfiles" ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    217    218    218            j           2604    25128    Users id    DEFAULT     h   ALTER TABLE ONLY public."Users" ALTER COLUMN id SET DEFAULT nextval('public."Users_id_seq"'::regclass);
 9   ALTER TABLE public."Users" ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221    222            i           2604    24806    Vehicles id    DEFAULT     n   ALTER TABLE ONLY public."Vehicles" ALTER COLUMN id SET DEFAULT nextval('public."Vehicles_id_seq"'::regclass);
 <   ALTER TABLE public."Vehicles" ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    220    219    220            �          0    24788    DriverProfiles 
   TABLE DATA             COPY public."DriverProfiles" (id, name, phone_number, email, address, license_number, license_expiration, employment_status, "createdAt", "updatedAt", "SSN", "EIN", unit_number, individual_name, individual_address, company_name, company_address, availability, zip_code) FROM stdin;
    public               postgres    false    218   B�      �          0    25125    Users 
   TABLE DATA           `   COPY public."Users" (id, username, email, role, "createdAt", "updatedAt", password) FROM stdin;
    public               postgres    false    222   ��      �          0    24803    Vehicles 
   TABLE DATA           �   COPY public."Vehicles" (id, make, model, type, trunk_width, trunk_length, trunk_height, capacity_ton, capacity_m3, license_plate, insurance_details, "createdAt", "updatedAt", "driverProfileId") FROM stdin;
    public               postgres    false    220   w�      �           0    0    DriverProfiles_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."DriverProfiles_id_seq"', 28, true);
          public               postgres    false    217            �           0    0    Users_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public."Users_id_seq"', 24, true);
          public               postgres    false    221            �           0    0    Vehicles_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Vehicles_id_seq"', 17, true);
          public               postgres    false    219            l           2606    60926 %   DriverProfiles DriverProfiles_EIN_key 
   CONSTRAINT     e   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key" UNIQUE ("EIN");
 S   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key";
       public                 postgres    false    218            n           2606    60928 &   DriverProfiles DriverProfiles_EIN_key1 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key1" UNIQUE ("EIN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key1";
       public                 postgres    false    218            p           2606    60958 '   DriverProfiles DriverProfiles_EIN_key10 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key10" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key10";
       public                 postgres    false    218            r           2606    60756 (   DriverProfiles DriverProfiles_EIN_key100 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key100" UNIQUE ("EIN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key100";
       public                 postgres    false    218            t           2606    60832 (   DriverProfiles DriverProfiles_EIN_key101 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key101" UNIQUE ("EIN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key101";
       public                 postgres    false    218            v           2606    60962 (   DriverProfiles DriverProfiles_EIN_key102 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key102" UNIQUE ("EIN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key102";
       public                 postgres    false    218            x           2606    60768 (   DriverProfiles DriverProfiles_EIN_key103 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key103" UNIQUE ("EIN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key103";
       public                 postgres    false    218            z           2606    60964 (   DriverProfiles DriverProfiles_EIN_key104 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key104" UNIQUE ("EIN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key104";
       public                 postgres    false    218            |           2606    60766 (   DriverProfiles DriverProfiles_EIN_key105 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key105" UNIQUE ("EIN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key105";
       public                 postgres    false    218            ~           2606    60966 (   DriverProfiles DriverProfiles_EIN_key106 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key106" UNIQUE ("EIN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key106";
       public                 postgres    false    218            �           2606    60750 (   DriverProfiles DriverProfiles_EIN_key107 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key107" UNIQUE ("EIN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key107";
       public                 postgres    false    218            �           2606    60960 (   DriverProfiles DriverProfiles_EIN_key108 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key108" UNIQUE ("EIN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key108";
       public                 postgres    false    218            �           2606    60748 (   DriverProfiles DriverProfiles_EIN_key109 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key109" UNIQUE ("EIN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key109";
       public                 postgres    false    218            �           2606    60924 '   DriverProfiles DriverProfiles_EIN_key11 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key11" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key11";
       public                 postgres    false    218            �           2606    60770 '   DriverProfiles DriverProfiles_EIN_key12 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key12" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key12";
       public                 postgres    false    218            �           2606    60782 '   DriverProfiles DriverProfiles_EIN_key13 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key13" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key13";
       public                 postgres    false    218            �           2606    60772 '   DriverProfiles DriverProfiles_EIN_key14 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key14" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key14";
       public                 postgres    false    218            �           2606    60818 '   DriverProfiles DriverProfiles_EIN_key15 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key15" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key15";
       public                 postgres    false    218            �           2606    60820 '   DriverProfiles DriverProfiles_EIN_key16 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key16" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key16";
       public                 postgres    false    218            �           2606    60848 '   DriverProfiles DriverProfiles_EIN_key17 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key17" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key17";
       public                 postgres    false    218            �           2606    60846 '   DriverProfiles DriverProfiles_EIN_key18 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key18" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key18";
       public                 postgres    false    218            �           2606    60840 '   DriverProfiles DriverProfiles_EIN_key19 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key19" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key19";
       public                 postgres    false    218            �           2606    60930 &   DriverProfiles DriverProfiles_EIN_key2 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key2" UNIQUE ("EIN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key2";
       public                 postgres    false    218            �           2606    60844 '   DriverProfiles DriverProfiles_EIN_key20 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key20" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key20";
       public                 postgres    false    218            �           2606    60774 '   DriverProfiles DriverProfiles_EIN_key21 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key21" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key21";
       public                 postgres    false    218            �           2606    60776 '   DriverProfiles DriverProfiles_EIN_key22 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key22" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key22";
       public                 postgres    false    218            �           2606    60814 '   DriverProfiles DriverProfiles_EIN_key23 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key23" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key23";
       public                 postgres    false    218            �           2606    60812 '   DriverProfiles DriverProfiles_EIN_key24 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key24" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key24";
       public                 postgres    false    218            �           2606    60762 '   DriverProfiles DriverProfiles_EIN_key25 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key25" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key25";
       public                 postgres    false    218            �           2606    60778 '   DriverProfiles DriverProfiles_EIN_key26 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key26" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key26";
       public                 postgres    false    218            �           2606    60760 '   DriverProfiles DriverProfiles_EIN_key27 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key27" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key27";
       public                 postgres    false    218            �           2606    60922 '   DriverProfiles DriverProfiles_EIN_key28 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key28" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key28";
       public                 postgres    false    218            �           2606    60938 '   DriverProfiles DriverProfiles_EIN_key29 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key29" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key29";
       public                 postgres    false    218            �           2606    60856 &   DriverProfiles DriverProfiles_EIN_key3 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key3" UNIQUE ("EIN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key3";
       public                 postgres    false    218            �           2606    60940 '   DriverProfiles DriverProfiles_EIN_key30 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key30" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key30";
       public                 postgres    false    218            �           2606    60894 '   DriverProfiles DriverProfiles_EIN_key31 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key31" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key31";
       public                 postgres    false    218            �           2606    60892 '   DriverProfiles DriverProfiles_EIN_key32 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key32" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key32";
       public                 postgres    false    218            �           2606    60942 '   DriverProfiles DriverProfiles_EIN_key33 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key33" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key33";
       public                 postgres    false    218            �           2606    60890 '   DriverProfiles DriverProfiles_EIN_key34 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key34" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key34";
       public                 postgres    false    218            �           2606    60882 '   DriverProfiles DriverProfiles_EIN_key35 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key35" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key35";
       public                 postgres    false    218            �           2606    60884 '   DriverProfiles DriverProfiles_EIN_key36 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key36" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key36";
       public                 postgres    false    218            �           2606    60854 '   DriverProfiles DriverProfiles_EIN_key37 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key37" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key37";
       public                 postgres    false    218            �           2606    60954 '   DriverProfiles DriverProfiles_EIN_key38 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key38" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key38";
       public                 postgres    false    218            �           2606    60900 '   DriverProfiles DriverProfiles_EIN_key39 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key39" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key39";
       public                 postgres    false    218            �           2606    60860 &   DriverProfiles DriverProfiles_EIN_key4 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key4" UNIQUE ("EIN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key4";
       public                 postgres    false    218            �           2606    60952 '   DriverProfiles DriverProfiles_EIN_key40 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key40" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key40";
       public                 postgres    false    218            �           2606    60902 '   DriverProfiles DriverProfiles_EIN_key41 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key41" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key41";
       public                 postgres    false    218            �           2606    60950 '   DriverProfiles DriverProfiles_EIN_key42 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key42" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key42";
       public                 postgres    false    218            �           2606    60904 '   DriverProfiles DriverProfiles_EIN_key43 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key43" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key43";
       public                 postgres    false    218            �           2606    60948 '   DriverProfiles DriverProfiles_EIN_key44 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key44" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key44";
       public                 postgres    false    218            �           2606    60906 '   DriverProfiles DriverProfiles_EIN_key45 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key45" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key45";
       public                 postgres    false    218            �           2606    60946 '   DriverProfiles DriverProfiles_EIN_key46 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key46" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key46";
       public                 postgres    false    218            �           2606    60888 '   DriverProfiles DriverProfiles_EIN_key47 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key47" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key47";
       public                 postgres    false    218            �           2606    60852 '   DriverProfiles DriverProfiles_EIN_key48 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key48" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key48";
       public                 postgres    false    218            �           2606    60886 '   DriverProfiles DriverProfiles_EIN_key49 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key49" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key49";
       public                 postgres    false    218            �           2606    60932 &   DriverProfiles DriverProfiles_EIN_key5 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key5" UNIQUE ("EIN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key5";
       public                 postgres    false    218            �           2606    60944 '   DriverProfiles DriverProfiles_EIN_key50 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key50" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key50";
       public                 postgres    false    218            �           2606    60800 '   DriverProfiles DriverProfiles_EIN_key51 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key51" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key51";
       public                 postgres    false    218            �           2606    60878 '   DriverProfiles DriverProfiles_EIN_key52 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key52" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key52";
       public                 postgres    false    218            �           2606    60802 '   DriverProfiles DriverProfiles_EIN_key53 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key53" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key53";
       public                 postgres    false    218            �           2606    60876 '   DriverProfiles DriverProfiles_EIN_key54 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key54" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key54";
       public                 postgres    false    218            �           2606    60804 '   DriverProfiles DriverProfiles_EIN_key55 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key55" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key55";
       public                 postgres    false    218            �           2606    60874 '   DriverProfiles DriverProfiles_EIN_key56 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key56" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key56";
       public                 postgres    false    218            �           2606    60872 '   DriverProfiles DriverProfiles_EIN_key57 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key57" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key57";
       public                 postgres    false    218            �           2606    60862 '   DriverProfiles DriverProfiles_EIN_key58 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key58" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key58";
       public                 postgres    false    218            �           2606    60870 '   DriverProfiles DriverProfiles_EIN_key59 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key59" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key59";
       public                 postgres    false    218            �           2606    60934 &   DriverProfiles DriverProfiles_EIN_key6 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key6" UNIQUE ("EIN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key6";
       public                 postgres    false    218            �           2606    60868 '   DriverProfiles DriverProfiles_EIN_key60 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key60" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key60";
       public                 postgres    false    218            �           2606    60806 '   DriverProfiles DriverProfiles_EIN_key61 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key61" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key61";
       public                 postgres    false    218            �           2606    60758 '   DriverProfiles DriverProfiles_EIN_key62 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key62" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key62";
       public                 postgres    false    218            �           2606    60808 '   DriverProfiles DriverProfiles_EIN_key63 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key63" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key63";
       public                 postgres    false    218            �           2606    60754 '   DriverProfiles DriverProfiles_EIN_key64 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key64" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key64";
       public                 postgres    false    218            �           2606    60752 '   DriverProfiles DriverProfiles_EIN_key65 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key65" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key65";
       public                 postgres    false    218            �           2606    60824 '   DriverProfiles DriverProfiles_EIN_key66 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key66" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key66";
       public                 postgres    false    218                        2606    60920 '   DriverProfiles DriverProfiles_EIN_key67 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key67" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key67";
       public                 postgres    false    218                       2606    60826 '   DriverProfiles DriverProfiles_EIN_key68 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key68" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key68";
       public                 postgres    false    218                       2606    60918 '   DriverProfiles DriverProfiles_EIN_key69 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key69" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key69";
       public                 postgres    false    218                       2606    60896 &   DriverProfiles DriverProfiles_EIN_key7 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key7" UNIQUE ("EIN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key7";
       public                 postgres    false    218                       2606    60828 '   DriverProfiles DriverProfiles_EIN_key70 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key70" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key70";
       public                 postgres    false    218            
           2606    60916 '   DriverProfiles DriverProfiles_EIN_key71 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key71" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key71";
       public                 postgres    false    218                       2606    60910 '   DriverProfiles DriverProfiles_EIN_key72 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key72" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key72";
       public                 postgres    false    218                       2606    60914 '   DriverProfiles DriverProfiles_EIN_key73 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key73" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key73";
       public                 postgres    false    218                       2606    60912 '   DriverProfiles DriverProfiles_EIN_key74 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key74" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key74";
       public                 postgres    false    218                       2606    60798 '   DriverProfiles DriverProfiles_EIN_key75 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key75" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key75";
       public                 postgres    false    218                       2606    60784 '   DriverProfiles DriverProfiles_EIN_key76 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key76" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key76";
       public                 postgres    false    218                       2606    60796 '   DriverProfiles DriverProfiles_EIN_key77 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key77" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key77";
       public                 postgres    false    218                       2606    60786 '   DriverProfiles DriverProfiles_EIN_key78 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key78" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key78";
       public                 postgres    false    218                       2606    60794 '   DriverProfiles DriverProfiles_EIN_key79 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key79" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key79";
       public                 postgres    false    218                       2606    60898 &   DriverProfiles DriverProfiles_EIN_key8 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key8" UNIQUE ("EIN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key8";
       public                 postgres    false    218                       2606    60792 '   DriverProfiles DriverProfiles_EIN_key80 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key80" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key80";
       public                 postgres    false    218                        2606    60936 '   DriverProfiles DriverProfiles_EIN_key81 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key81" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key81";
       public                 postgres    false    218            "           2606    60788 '   DriverProfiles DriverProfiles_EIN_key82 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key82" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key82";
       public                 postgres    false    218            $           2606    60790 '   DriverProfiles DriverProfiles_EIN_key83 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key83" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key83";
       public                 postgres    false    218            &           2606    60864 '   DriverProfiles DriverProfiles_EIN_key84 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key84" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key84";
       public                 postgres    false    218            (           2606    60780 '   DriverProfiles DriverProfiles_EIN_key85 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key85" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key85";
       public                 postgres    false    218            *           2606    60842 '   DriverProfiles DriverProfiles_EIN_key86 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key86" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key86";
       public                 postgres    false    218            ,           2606    60866 '   DriverProfiles DriverProfiles_EIN_key87 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key87" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key87";
       public                 postgres    false    218            .           2606    60816 '   DriverProfiles DriverProfiles_EIN_key88 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key88" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key88";
       public                 postgres    false    218            0           2606    60908 '   DriverProfiles DriverProfiles_EIN_key89 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key89" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key89";
       public                 postgres    false    218            2           2606    60956 &   DriverProfiles DriverProfiles_EIN_key9 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key9" UNIQUE ("EIN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key9";
       public                 postgres    false    218            4           2606    60830 '   DriverProfiles DriverProfiles_EIN_key90 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key90" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key90";
       public                 postgres    false    218            6           2606    60880 '   DriverProfiles DriverProfiles_EIN_key91 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key91" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key91";
       public                 postgres    false    218            8           2606    60822 '   DriverProfiles DriverProfiles_EIN_key92 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key92" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key92";
       public                 postgres    false    218            :           2606    60858 '   DriverProfiles DriverProfiles_EIN_key93 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key93" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key93";
       public                 postgres    false    218            <           2606    60850 '   DriverProfiles DriverProfiles_EIN_key94 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key94" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key94";
       public                 postgres    false    218            >           2606    60838 '   DriverProfiles DriverProfiles_EIN_key95 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key95" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key95";
       public                 postgres    false    218            @           2606    60810 '   DriverProfiles DriverProfiles_EIN_key96 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key96" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key96";
       public                 postgres    false    218            B           2606    60836 '   DriverProfiles DriverProfiles_EIN_key97 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key97" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key97";
       public                 postgres    false    218            D           2606    60764 '   DriverProfiles DriverProfiles_EIN_key98 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key98" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key98";
       public                 postgres    false    218            F           2606    60834 '   DriverProfiles DriverProfiles_EIN_key99 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_EIN_key99" UNIQUE ("EIN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_EIN_key99";
       public                 postgres    false    218            H           2606    60636 %   DriverProfiles DriverProfiles_SSN_key 
   CONSTRAINT     e   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key" UNIQUE ("SSN");
 S   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key";
       public                 postgres    false    218            J           2606    60638 &   DriverProfiles DriverProfiles_SSN_key1 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key1" UNIQUE ("SSN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key1";
       public                 postgres    false    218            L           2606    60722 '   DriverProfiles DriverProfiles_SSN_key10 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key10" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key10";
       public                 postgres    false    218            N           2606    60610 (   DriverProfiles DriverProfiles_SSN_key100 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key100" UNIQUE ("SSN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key100";
       public                 postgres    false    218            P           2606    60650 (   DriverProfiles DriverProfiles_SSN_key101 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key101" UNIQUE ("SSN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key101";
       public                 postgres    false    218            R           2606    60612 (   DriverProfiles DriverProfiles_SSN_key102 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key102" UNIQUE ("SSN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key102";
       public                 postgres    false    218            T           2606    60648 (   DriverProfiles DriverProfiles_SSN_key103 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key103" UNIQUE ("SSN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key103";
       public                 postgres    false    218            V           2606    60614 (   DriverProfiles DriverProfiles_SSN_key104 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key104" UNIQUE ("SSN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key104";
       public                 postgres    false    218            X           2606    60622 (   DriverProfiles DriverProfiles_SSN_key105 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key105" UNIQUE ("SSN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key105";
       public                 postgres    false    218            Z           2606    60616 (   DriverProfiles DriverProfiles_SSN_key106 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key106" UNIQUE ("SSN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key106";
       public                 postgres    false    218            \           2606    60620 (   DriverProfiles DriverProfiles_SSN_key107 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key107" UNIQUE ("SSN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key107";
       public                 postgres    false    218            ^           2606    60618 (   DriverProfiles DriverProfiles_SSN_key108 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key108" UNIQUE ("SSN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key108";
       public                 postgres    false    218            `           2606    60526 (   DriverProfiles DriverProfiles_SSN_key109 
   CONSTRAINT     h   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key109" UNIQUE ("SSN");
 V   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key109";
       public                 postgres    false    218            b           2606    60634 '   DriverProfiles DriverProfiles_SSN_key11 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key11" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key11";
       public                 postgres    false    218            d           2606    60724 '   DriverProfiles DriverProfiles_SSN_key12 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key12" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key12";
       public                 postgres    false    218            f           2606    60632 '   DriverProfiles DriverProfiles_SSN_key13 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key13" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key13";
       public                 postgres    false    218            h           2606    60726 '   DriverProfiles DriverProfiles_SSN_key14 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key14" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key14";
       public                 postgres    false    218            j           2606    60536 '   DriverProfiles DriverProfiles_SSN_key15 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key15" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key15";
       public                 postgres    false    218            l           2606    60538 '   DriverProfiles DriverProfiles_SSN_key16 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key16" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key16";
       public                 postgres    false    218            n           2606    60630 '   DriverProfiles DriverProfiles_SSN_key17 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key17" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key17";
       public                 postgres    false    218            p           2606    60626 '   DriverProfiles DriverProfiles_SSN_key18 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key18" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key18";
       public                 postgres    false    218            r           2606    60628 '   DriverProfiles DriverProfiles_SSN_key19 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key19" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key19";
       public                 postgres    false    218            t           2606    60640 &   DriverProfiles DriverProfiles_SSN_key2 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key2" UNIQUE ("SSN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key2";
       public                 postgres    false    218            v           2606    60534 '   DriverProfiles DriverProfiles_SSN_key20 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key20" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key20";
       public                 postgres    false    218            x           2606    60734 '   DriverProfiles DriverProfiles_SSN_key21 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key21" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key21";
       public                 postgres    false    218            z           2606    60728 '   DriverProfiles DriverProfiles_SSN_key22 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key22" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key22";
       public                 postgres    false    218            |           2606    60732 '   DriverProfiles DriverProfiles_SSN_key23 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key23" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key23";
       public                 postgres    false    218            ~           2606    60730 '   DriverProfiles DriverProfiles_SSN_key24 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key24" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key24";
       public                 postgres    false    218            �           2606    60570 '   DriverProfiles DriverProfiles_SSN_key25 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key25" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key25";
       public                 postgres    false    218            �           2606    60646 '   DriverProfiles DriverProfiles_SSN_key26 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key26" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key26";
       public                 postgres    false    218            �           2606    60568 '   DriverProfiles DriverProfiles_SSN_key27 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key27" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key27";
       public                 postgres    false    218            �           2606    60566 '   DriverProfiles DriverProfiles_SSN_key28 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key28" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key28";
       public                 postgres    false    218            �           2606    60562 '   DriverProfiles DriverProfiles_SSN_key29 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key29" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key29";
       public                 postgres    false    218            �           2606    60576 &   DriverProfiles DriverProfiles_SSN_key3 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key3" UNIQUE ("SSN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key3";
       public                 postgres    false    218            �           2606    60564 '   DriverProfiles DriverProfiles_SSN_key30 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key30" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key30";
       public                 postgres    false    218            �           2606    60718 '   DriverProfiles DriverProfiles_SSN_key31 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key31" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key31";
       public                 postgres    false    218            �           2606    60714 '   DriverProfiles DriverProfiles_SSN_key32 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key32" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key32";
       public                 postgres    false    218            �           2606    60716 '   DriverProfiles DriverProfiles_SSN_key33 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key33" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key33";
       public                 postgres    false    218            �           2606    60540 '   DriverProfiles DriverProfiles_SSN_key34 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key34" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key34";
       public                 postgres    false    218            �           2606    60582 '   DriverProfiles DriverProfiles_SSN_key35 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key35" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key35";
       public                 postgres    false    218            �           2606    60704 '   DriverProfiles DriverProfiles_SSN_key36 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key36" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key36";
       public                 postgres    false    218            �           2606    60702 '   DriverProfiles DriverProfiles_SSN_key37 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key37" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key37";
       public                 postgres    false    218            �           2606    60584 '   DriverProfiles DriverProfiles_SSN_key38 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key38" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key38";
       public                 postgres    false    218            �           2606    60586 '   DriverProfiles DriverProfiles_SSN_key39 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key39" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key39";
       public                 postgres    false    218            �           2606    60578 &   DriverProfiles DriverProfiles_SSN_key4 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key4" UNIQUE ("SSN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key4";
       public                 postgres    false    218            �           2606    60700 '   DriverProfiles DriverProfiles_SSN_key40 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key40" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key40";
       public                 postgres    false    218            �           2606    60588 '   DriverProfiles DriverProfiles_SSN_key41 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key41" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key41";
       public                 postgres    false    218            �           2606    60692 '   DriverProfiles DriverProfiles_SSN_key42 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key42" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key42";
       public                 postgres    false    218            �           2606    60590 '   DriverProfiles DriverProfiles_SSN_key43 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key43" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key43";
       public                 postgres    false    218            �           2606    60690 '   DriverProfiles DriverProfiles_SSN_key44 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key44" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key44";
       public                 postgres    false    218            �           2606    60672 '   DriverProfiles DriverProfiles_SSN_key45 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key45" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key45";
       public                 postgres    false    218            �           2606    60688 '   DriverProfiles DriverProfiles_SSN_key46 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key46" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key46";
       public                 postgres    false    218            �           2606    60678 '   DriverProfiles DriverProfiles_SSN_key47 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key47" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key47";
       public                 postgres    false    218            �           2606    60686 '   DriverProfiles DriverProfiles_SSN_key48 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key48" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key48";
       public                 postgres    false    218            �           2606    60680 '   DriverProfiles DriverProfiles_SSN_key49 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key49" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key49";
       public                 postgres    false    218            �           2606    60580 &   DriverProfiles DriverProfiles_SSN_key5 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key5" UNIQUE ("SSN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key5";
       public                 postgres    false    218            �           2606    60684 '   DriverProfiles DriverProfiles_SSN_key50 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key50" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key50";
       public                 postgres    false    218            �           2606    60682 '   DriverProfiles DriverProfiles_SSN_key51 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key51" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key51";
       public                 postgres    false    218            �           2606    60676 '   DriverProfiles DriverProfiles_SSN_key52 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key52" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key52";
       public                 postgres    false    218            �           2606    60674 '   DriverProfiles DriverProfiles_SSN_key53 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key53" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key53";
       public                 postgres    false    218            �           2606    60644 '   DriverProfiles DriverProfiles_SSN_key54 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key54" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key54";
       public                 postgres    false    218            �           2606    60642 '   DriverProfiles DriverProfiles_SSN_key55 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key55" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key55";
       public                 postgres    false    218            �           2606    60698 '   DriverProfiles DriverProfiles_SSN_key56 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key56" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key56";
       public                 postgres    false    218            �           2606    60694 '   DriverProfiles DriverProfiles_SSN_key57 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key57" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key57";
       public                 postgres    false    218            �           2606    60696 '   DriverProfiles DriverProfiles_SSN_key58 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key58" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key58";
       public                 postgres    false    218            �           2606    60572 '   DriverProfiles DriverProfiles_SSN_key59 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key59" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key59";
       public                 postgres    false    218            �           2606    60706 &   DriverProfiles DriverProfiles_SSN_key6 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key6" UNIQUE ("SSN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key6";
       public                 postgres    false    218            �           2606    60574 '   DriverProfiles DriverProfiles_SSN_key60 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key60" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key60";
       public                 postgres    false    218            �           2606    60542 '   DriverProfiles DriverProfiles_SSN_key61 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key61" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key61";
       public                 postgres    false    218            �           2606    60624 '   DriverProfiles DriverProfiles_SSN_key62 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key62" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key62";
       public                 postgres    false    218            �           2606    60544 '   DriverProfiles DriverProfiles_SSN_key63 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key63" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key63";
       public                 postgres    false    218            �           2606    60558 '   DriverProfiles DriverProfiles_SSN_key64 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key64" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key64";
       public                 postgres    false    218            �           2606    60546 '   DriverProfiles DriverProfiles_SSN_key65 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key65" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key65";
       public                 postgres    false    218            �           2606    60548 '   DriverProfiles DriverProfiles_SSN_key66 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key66" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key66";
       public                 postgres    false    218            �           2606    60556 '   DriverProfiles DriverProfiles_SSN_key67 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key67" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key67";
       public                 postgres    false    218            �           2606    60550 '   DriverProfiles DriverProfiles_SSN_key68 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key68" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key68";
       public                 postgres    false    218            �           2606    60554 '   DriverProfiles DriverProfiles_SSN_key69 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key69" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key69";
       public                 postgres    false    218            �           2606    60710 &   DriverProfiles DriverProfiles_SSN_key7 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key7" UNIQUE ("SSN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key7";
       public                 postgres    false    218            �           2606    60552 '   DriverProfiles DriverProfiles_SSN_key70 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key70" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key70";
       public                 postgres    false    218            �           2606    60532 '   DriverProfiles DriverProfiles_SSN_key71 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key71" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key71";
       public                 postgres    false    218            �           2606    60530 '   DriverProfiles DriverProfiles_SSN_key72 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key72" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key72";
       public                 postgres    false    218            �           2606    60560 '   DriverProfiles DriverProfiles_SSN_key73 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key73" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key73";
       public                 postgres    false    218            �           2606    60736 '   DriverProfiles DriverProfiles_SSN_key74 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key74" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key74";
       public                 postgres    false    218            �           2606    60528 '   DriverProfiles DriverProfiles_SSN_key75 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key75" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key75";
       public                 postgres    false    218            �           2606    60740 '   DriverProfiles DriverProfiles_SSN_key76 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key76" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key76";
       public                 postgres    false    218            �           2606    60744 '   DriverProfiles DriverProfiles_SSN_key77 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key77" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key77";
       public                 postgres    false    218            �           2606    60742 '   DriverProfiles DriverProfiles_SSN_key78 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key78" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key78";
       public                 postgres    false    218            �           2606    60738 '   DriverProfiles DriverProfiles_SSN_key79 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key79" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key79";
       public                 postgres    false    218            �           2606    60712 &   DriverProfiles DriverProfiles_SSN_key8 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key8" UNIQUE ("SSN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key8";
       public                 postgres    false    218            �           2606    60708 '   DriverProfiles DriverProfiles_SSN_key80 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key80" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key80";
       public                 postgres    false    218            �           2606    60670 '   DriverProfiles DriverProfiles_SSN_key81 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key81" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key81";
       public                 postgres    false    218            �           2606    60592 '   DriverProfiles DriverProfiles_SSN_key82 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key82" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key82";
       public                 postgres    false    218                        2606    60668 '   DriverProfiles DriverProfiles_SSN_key83 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key83" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key83";
       public                 postgres    false    218                       2606    60594 '   DriverProfiles DriverProfiles_SSN_key84 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key84" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key84";
       public                 postgres    false    218                       2606    60666 '   DriverProfiles DriverProfiles_SSN_key85 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key85" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key85";
       public                 postgres    false    218                       2606    60596 '   DriverProfiles DriverProfiles_SSN_key86 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key86" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key86";
       public                 postgres    false    218                       2606    60664 '   DriverProfiles DriverProfiles_SSN_key87 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key87" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key87";
       public                 postgres    false    218            
           2606    60598 '   DriverProfiles DriverProfiles_SSN_key88 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key88" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key88";
       public                 postgres    false    218                       2606    60662 '   DriverProfiles DriverProfiles_SSN_key89 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key89" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key89";
       public                 postgres    false    218                       2606    60720 &   DriverProfiles DriverProfiles_SSN_key9 
   CONSTRAINT     f   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key9" UNIQUE ("SSN");
 T   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key9";
       public                 postgres    false    218                       2606    60600 '   DriverProfiles DriverProfiles_SSN_key90 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key90" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key90";
       public                 postgres    false    218                       2606    60660 '   DriverProfiles DriverProfiles_SSN_key91 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key91" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key91";
       public                 postgres    false    218                       2606    60602 '   DriverProfiles DriverProfiles_SSN_key92 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key92" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key92";
       public                 postgres    false    218                       2606    60658 '   DriverProfiles DriverProfiles_SSN_key93 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key93" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key93";
       public                 postgres    false    218                       2606    60604 '   DriverProfiles DriverProfiles_SSN_key94 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key94" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key94";
       public                 postgres    false    218                       2606    60656 '   DriverProfiles DriverProfiles_SSN_key95 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key95" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key95";
       public                 postgres    false    218                       2606    60606 '   DriverProfiles DriverProfiles_SSN_key96 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key96" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key96";
       public                 postgres    false    218                       2606    60654 '   DriverProfiles DriverProfiles_SSN_key97 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key97" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key97";
       public                 postgres    false    218                        2606    60608 '   DriverProfiles DriverProfiles_SSN_key98 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key98" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key98";
       public                 postgres    false    218            "           2606    60652 '   DriverProfiles DriverProfiles_SSN_key99 
   CONSTRAINT     g   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_SSN_key99" UNIQUE ("SSN");
 U   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_SSN_key99";
       public                 postgres    false    218            $           2606    24795 "   DriverProfiles DriverProfiles_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public."DriverProfiles"
    ADD CONSTRAINT "DriverProfiles_pkey" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public."DriverProfiles" DROP CONSTRAINT "DriverProfiles_pkey";
       public                 postgres    false    218            (           2606    60402    Users Users_email_key 
   CONSTRAINT     U   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key" UNIQUE (email);
 C   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key";
       public                 postgres    false    222            *           2606    60404    Users Users_email_key1 
   CONSTRAINT     V   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key1" UNIQUE (email);
 D   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key1";
       public                 postgres    false    222            ,           2606    60470    Users Users_email_key10 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key10" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key10";
       public                 postgres    false    222            .           2606    60322    Users Users_email_key100 
   CONSTRAINT     X   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key100" UNIQUE (email);
 F   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key100";
       public                 postgres    false    222            0           2606    60394    Users Users_email_key11 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key11" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key11";
       public                 postgres    false    222            2           2606    60478    Users Users_email_key12 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key12" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key12";
       public                 postgres    false    222            4           2606    60472    Users Users_email_key13 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key13" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key13";
       public                 postgres    false    222            6           2606    60476    Users Users_email_key14 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key14" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key14";
       public                 postgres    false    222            8           2606    60474    Users Users_email_key15 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key15" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key15";
       public                 postgres    false    222            :           2606    60464    Users Users_email_key16 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key16" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key16";
       public                 postgres    false    222            <           2606    60412    Users Users_email_key17 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key17" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key17";
       public                 postgres    false    222            >           2606    60392    Users Users_email_key18 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key18" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key18";
       public                 postgres    false    222            @           2606    60390    Users Users_email_key19 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key19" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key19";
       public                 postgres    false    222            B           2606    60400    Users Users_email_key2 
   CONSTRAINT     V   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key2" UNIQUE (email);
 D   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key2";
       public                 postgres    false    222            D           2606    60414    Users Users_email_key20 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key20" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key20";
       public                 postgres    false    222            F           2606    60490    Users Users_email_key21 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key21" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key21";
       public                 postgres    false    222            H           2606    60488    Users Users_email_key22 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key22" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key22";
       public                 postgres    false    222            J           2606    60416    Users Users_email_key23 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key23" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key23";
       public                 postgres    false    222            L           2606    60486    Users Users_email_key24 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key24" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key24";
       public                 postgres    false    222            N           2606    60484    Users Users_email_key25 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key25" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key25";
       public                 postgres    false    222            P           2606    60418    Users Users_email_key26 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key26" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key26";
       public                 postgres    false    222            R           2606    60482    Users Users_email_key27 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key27" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key27";
       public                 postgres    false    222            T           2606    60480    Users Users_email_key28 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key28" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key28";
       public                 postgres    false    222            V           2606    60420    Users Users_email_key29 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key29" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key29";
       public                 postgres    false    222            X           2606    60406    Users Users_email_key3 
   CONSTRAINT     V   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key3" UNIQUE (email);
 D   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key3";
       public                 postgres    false    222            Z           2606    60422    Users Users_email_key30 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key30" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key30";
       public                 postgres    false    222            \           2606    60462    Users Users_email_key31 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key31" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key31";
       public                 postgres    false    222            ^           2606    60424    Users Users_email_key32 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key32" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key32";
       public                 postgres    false    222            `           2606    60460    Users Users_email_key33 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key33" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key33";
       public                 postgres    false    222            b           2606    60426    Users Users_email_key34 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key34" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key34";
       public                 postgres    false    222            d           2606    60458    Users Users_email_key35 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key35" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key35";
       public                 postgres    false    222            f           2606    60428    Users Users_email_key36 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key36" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key36";
       public                 postgres    false    222            h           2606    60456    Users Users_email_key37 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key37" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key37";
       public                 postgres    false    222            j           2606    60430    Users Users_email_key38 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key38" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key38";
       public                 postgres    false    222            l           2606    60454    Users Users_email_key39 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key39" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key39";
       public                 postgres    false    222            n           2606    60398    Users Users_email_key4 
   CONSTRAINT     V   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key4" UNIQUE (email);
 D   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key4";
       public                 postgres    false    222            p           2606    60432    Users Users_email_key40 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key40" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key40";
       public                 postgres    false    222            r           2606    60452    Users Users_email_key41 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key41" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key41";
       public                 postgres    false    222            t           2606    60434    Users Users_email_key42 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key42" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key42";
       public                 postgres    false    222            v           2606    60450    Users Users_email_key43 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key43" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key43";
       public                 postgres    false    222            x           2606    60436    Users Users_email_key44 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key44" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key44";
       public                 postgres    false    222            z           2606    60448    Users Users_email_key45 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key45" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key45";
       public                 postgres    false    222            |           2606    60492    Users Users_email_key46 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key46" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key46";
       public                 postgres    false    222            ~           2606    60446    Users Users_email_key47 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key47" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key47";
       public                 postgres    false    222            �           2606    60494    Users Users_email_key48 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key48" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key48";
       public                 postgres    false    222            �           2606    60444    Users Users_email_key49 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key49" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key49";
       public                 postgres    false    222            �           2606    60408    Users Users_email_key5 
   CONSTRAINT     V   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key5" UNIQUE (email);
 D   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key5";
       public                 postgres    false    222            �           2606    60496    Users Users_email_key50 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key50" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key50";
       public                 postgres    false    222            �           2606    60442    Users Users_email_key51 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key51" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key51";
       public                 postgres    false    222            �           2606    60498    Users Users_email_key52 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key52" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key52";
       public                 postgres    false    222            �           2606    60440    Users Users_email_key53 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key53" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key53";
       public                 postgres    false    222            �           2606    60500    Users Users_email_key54 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key54" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key54";
       public                 postgres    false    222            �           2606    60438    Users Users_email_key55 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key55" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key55";
       public                 postgres    false    222            �           2606    60502    Users Users_email_key56 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key56" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key56";
       public                 postgres    false    222            �           2606    60504    Users Users_email_key57 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key57" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key57";
       public                 postgres    false    222            �           2606    60388    Users Users_email_key58 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key58" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key58";
       public                 postgres    false    222            �           2606    60506    Users Users_email_key59 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key59" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key59";
       public                 postgres    false    222            �           2606    60410    Users Users_email_key6 
   CONSTRAINT     V   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key6" UNIQUE (email);
 D   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key6";
       public                 postgres    false    222            �           2606    60386    Users Users_email_key60 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key60" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key60";
       public                 postgres    false    222            �           2606    60508    Users Users_email_key61 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key61" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key61";
       public                 postgres    false    222            �           2606    60384    Users Users_email_key62 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key62" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key62";
       public                 postgres    false    222            �           2606    60510    Users Users_email_key63 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key63" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key63";
       public                 postgres    false    222            �           2606    60382    Users Users_email_key64 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key64" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key64";
       public                 postgres    false    222            �           2606    60512    Users Users_email_key65 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key65" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key65";
       public                 postgres    false    222            �           2606    60380    Users Users_email_key66 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key66" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key66";
       public                 postgres    false    222            �           2606    60514    Users Users_email_key67 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key67" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key67";
       public                 postgres    false    222            �           2606    60378    Users Users_email_key68 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key68" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key68";
       public                 postgres    false    222            �           2606    60516    Users Users_email_key69 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key69" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key69";
       public                 postgres    false    222            �           2606    60466    Users Users_email_key7 
   CONSTRAINT     V   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key7" UNIQUE (email);
 D   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key7";
       public                 postgres    false    222            �           2606    60376    Users Users_email_key70 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key70" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key70";
       public                 postgres    false    222            �           2606    60518    Users Users_email_key71 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key71" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key71";
       public                 postgres    false    222            �           2606    60374    Users Users_email_key72 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key72" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key72";
       public                 postgres    false    222            �           2606    60520    Users Users_email_key73 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key73" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key73";
       public                 postgres    false    222            �           2606    60372    Users Users_email_key74 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key74" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key74";
       public                 postgres    false    222            �           2606    60370    Users Users_email_key75 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key75" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key75";
       public                 postgres    false    222            �           2606    60368    Users Users_email_key76 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key76" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key76";
       public                 postgres    false    222            �           2606    60366    Users Users_email_key77 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key77" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key77";
       public                 postgres    false    222            �           2606    60364    Users Users_email_key78 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key78" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key78";
       public                 postgres    false    222            �           2606    60362    Users Users_email_key79 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key79" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key79";
       public                 postgres    false    222            �           2606    60396    Users Users_email_key8 
   CONSTRAINT     V   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key8" UNIQUE (email);
 D   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key8";
       public                 postgres    false    222            �           2606    60360    Users Users_email_key80 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key80" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key80";
       public                 postgres    false    222            �           2606    60358    Users Users_email_key81 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key81" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key81";
       public                 postgres    false    222            �           2606    60356    Users Users_email_key82 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key82" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key82";
       public                 postgres    false    222            �           2606    60354    Users Users_email_key83 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key83" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key83";
       public                 postgres    false    222            �           2606    60352    Users Users_email_key84 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key84" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key84";
       public                 postgres    false    222            �           2606    60350    Users Users_email_key85 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key85" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key85";
       public                 postgres    false    222            �           2606    60348    Users Users_email_key86 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key86" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key86";
       public                 postgres    false    222            �           2606    60346    Users Users_email_key87 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key87" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key87";
       public                 postgres    false    222            �           2606    60344    Users Users_email_key88 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key88" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key88";
       public                 postgres    false    222            �           2606    60342    Users Users_email_key89 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key89" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key89";
       public                 postgres    false    222            �           2606    60468    Users Users_email_key9 
   CONSTRAINT     V   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key9" UNIQUE (email);
 D   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key9";
       public                 postgres    false    222            �           2606    60340    Users Users_email_key90 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key90" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key90";
       public                 postgres    false    222            �           2606    60338    Users Users_email_key91 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key91" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key91";
       public                 postgres    false    222            �           2606    60336    Users Users_email_key92 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key92" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key92";
       public                 postgres    false    222            �           2606    60522    Users Users_email_key93 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key93" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key93";
       public                 postgres    false    222            �           2606    60334    Users Users_email_key94 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key94" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key94";
       public                 postgres    false    222            �           2606    60332    Users Users_email_key95 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key95" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key95";
       public                 postgres    false    222            �           2606    60330    Users Users_email_key96 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key96" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key96";
       public                 postgres    false    222            �           2606    60328    Users Users_email_key97 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key97" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key97";
       public                 postgres    false    222            �           2606    60326    Users Users_email_key98 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key98" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key98";
       public                 postgres    false    222            �           2606    60324    Users Users_email_key99 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key99" UNIQUE (email);
 E   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key99";
       public                 postgres    false    222            �           2606    25132    Users Users_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_pkey";
       public                 postgres    false    222            &           2606    24810    Vehicles Vehicles_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Vehicles"
    ADD CONSTRAINT "Vehicles_pkey" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public."Vehicles" DROP CONSTRAINT "Vehicles_pkey";
       public                 postgres    false    220            �           2606    60969 &   Vehicles Vehicles_driverProfileId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Vehicles"
    ADD CONSTRAINT "Vehicles_driverProfileId_fkey" FOREIGN KEY ("driverProfileId") REFERENCES public."DriverProfiles"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 T   ALTER TABLE ONLY public."Vehicles" DROP CONSTRAINT "Vehicles_driverProfileId_fkey";
       public               postgres    false    218    5156    220            �   �  x��V�n�6|������"RO�6�v����E�Y��,��؛~}�8���(�%qf8g9�-+���fF���V�I���q����9w�c9'Riz���}sD�|�r���Ƒ���	0�ӑ`�ɔ1�0IN����ü��\�B��c6<�6�)�T%�1�:L}#�H��a������3�eY��릈��������/���DI!�p)W�/٬,;��3*�	=Y�#:vK������7����qB^1���=t�J�*K�l�M(�'M�x��JW�(@�$\�Q���5���3_L����nY�������L��*�~vө���*�" ��	~�@�
\P`ͬ���%�&�W�S�R)bаC�2���r���Ж�r���M0l��]��y�j�[���U������� ������y����7�csh���u�i�W�Ԇ���_�I��Cp�C�ml�٭Bs.Ô�A��
A�v~?V��`�F��_=b�����Y�N�.�j4S�d�Y�j	����6��mf;l�e�7�˫ ?�8���)�8QbH�xX����Y�#�R����E���!wDZűF4{t@Io���N"�y���O���x�)�w*@�;Eҭ�.�ఠA%c`�J6U&VB�rQ���zU$Q��w��=̵�'#Kγ�o��ʚ�׳���k���r�x�x`���sC~�z�/ȶ���?��+��u�5k��^+AHa05ceՆH��R�)})uC�:]�&�i_pC��-��O��Co]��a7�c�aj����Ve6Yf/�G�G��]����Uj�."�����uX��o!�4Q�Y��p[
!`�2r�3z�Vm����Q6�e��l����3,��?�VO�o+��&�J���o%[��V1���X�+F���a�xaưf��k�䂌˂Hc���F��9������UB/���w���:0	�X��m(Ȋ�C�o; ��$��(){��e�I�s�I������C���\g�=m���US���~.I���`{�b�59�} v�D,7��OHb�{	�恧A`�IM���0|�8�v���V��?Y���yr�.$�77�t%�{VGIԡ_E��Y������j��\�9�n���h4���.      �   y  x���I��0���+<�m�cH�AN��э��Ps	1.l��~۪�n�kNI�=�O=�U�X.��z�K��s�7?b"�]$�|g"屄 R_!z����N�:R ������/
|i��0��<&���dS�i�G��	S�� ڌ�����vݮ��6�)W����Lb"bq�S��z��wt�H�,]����S������M0Ii��)\ߏĬs����s촶}���A��M���Ǜ���%S)Y�R&=J�z�s����u*�D�w7�r����r��v�Y'>���]`~f��vy�{;��rڦ�YhqA�1�< n(��~�̋��_;)AEGD�`�������FӚ�N p���s`�2&����T�h�+@Ǳ"�G|����4�0I��
��[~�����$��J�wȇ�Y&�iu��V
[���x޲0�$J��q��-|��-�<�ZSX��ӏ�\꯷7~b�>����D��^�@��,/�ahH���]��EPi��<����lW�q'l�Aee��|��g���c��3��w�J������ xsg_�������R�{�[T�4z�7j8
�
ǎ�Z�b������]J�����nw�������t��ȿ�,� �8�      �     x���Io�@�Ϝ_�{���Cj����H��	��zl�6�J�c�˯%'���($_� ~z�q&������3�������A
�X&�<�D�΋|���r$G�F�'AؒK^8��dt����-���C�H����w��|_�FqD>H<�,�A�
D�n�����{Q��a��aV�����[u�R��D��E�._��4X"�R��f�C�2��s���!+��O9Ns���>O�<����+V���~MggQ�G^.�^v>x[���X:ux�������Q�:/>����!j e	��nY���hV�ಮ�M��2��A�Q���Rۨ�y7@��[J�A�#���μ��o����VI��r�6/W�i��g�2��4 �$6�����8����ET�T�>E�eD,gc\O�uִS��8pkk^�6�|7���Ӕ�!��ب�����G_Ҝ53ܑ���7��Ky�aC)1�t���T}��tzs���8B	���"�0�I�I�roI}s�����&����F�?�[�l=f�5�< �&�     