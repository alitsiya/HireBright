--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: interviews; Type: TABLE; Schema: public; Owner: aliaj; Tablespace: 
--

CREATE TABLE interviews (
    interview_id integer NOT NULL,
    user_id integer NOT NULL,
    recruter_id integer,
    status_id integer NOT NULL,
    link_id integer,
    interview_date timestamp without time zone
);


ALTER TABLE interviews OWNER TO aliaj;

--
-- Name: interviews_interview_id_seq; Type: SEQUENCE; Schema: public; Owner: aliaj
--

CREATE SEQUENCE interviews_interview_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE interviews_interview_id_seq OWNER TO aliaj;

--
-- Name: interviews_interview_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aliaj
--

ALTER SEQUENCE interviews_interview_id_seq OWNED BY interviews.interview_id;


--
-- Name: positions; Type: TABLE; Schema: public; Owner: aliaj; Tablespace: 
--

CREATE TABLE positions (
    pos_id integer NOT NULL,
    position_name character varying(50) NOT NULL
);


ALTER TABLE positions OWNER TO aliaj;

--
-- Name: positions_pos_id_seq; Type: SEQUENCE; Schema: public; Owner: aliaj
--

CREATE SEQUENCE positions_pos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE positions_pos_id_seq OWNER TO aliaj;

--
-- Name: positions_pos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aliaj
--

ALTER SEQUENCE positions_pos_id_seq OWNED BY positions.pos_id;


--
-- Name: recruters; Type: TABLE; Schema: public; Owner: aliaj; Tablespace: 
--

CREATE TABLE recruters (
    recruter_id integer NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    email character varying(20) NOT NULL,
    title character varying(30),
    phone character varying(30)
);


ALTER TABLE recruters OWNER TO aliaj;

--
-- Name: recruters_recruter_id_seq; Type: SEQUENCE; Schema: public; Owner: aliaj
--

CREATE SEQUENCE recruters_recruter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE recruters_recruter_id_seq OWNER TO aliaj;

--
-- Name: recruters_recruter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aliaj
--

ALTER SEQUENCE recruters_recruter_id_seq OWNED BY recruters.recruter_id;


--
-- Name: resumes; Type: TABLE; Schema: public; Owner: aliaj; Tablespace: 
--

CREATE TABLE resumes (
    resume_id integer NOT NULL,
    resume_text character varying(100000) NOT NULL
);


ALTER TABLE resumes OWNER TO aliaj;

--
-- Name: resumes_resume_id_seq; Type: SEQUENCE; Schema: public; Owner: aliaj
--

CREATE SEQUENCE resumes_resume_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE resumes_resume_id_seq OWNER TO aliaj;

--
-- Name: resumes_resume_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aliaj
--

ALTER SEQUENCE resumes_resume_id_seq OWNED BY resumes.resume_id;


--
-- Name: statuses; Type: TABLE; Schema: public; Owner: aliaj; Tablespace: 
--

CREATE TABLE statuses (
    status_id integer NOT NULL,
    status_name character varying(50) NOT NULL
);


ALTER TABLE statuses OWNER TO aliaj;

--
-- Name: statuses_status_id_seq; Type: SEQUENCE; Schema: public; Owner: aliaj
--

CREATE SEQUENCE statuses_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE statuses_status_id_seq OWNER TO aliaj;

--
-- Name: statuses_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aliaj
--

ALTER SEQUENCE statuses_status_id_seq OWNED BY statuses.status_id;


--
-- Name: submissions; Type: TABLE; Schema: public; Owner: aliaj; Tablespace: 
--

CREATE TABLE submissions (
    sub_id integer NOT NULL,
    user_id integer NOT NULL,
    position_id integer,
    salary integer,
    resume_id integer NOT NULL,
    time_of_submission timestamp without time zone NOT NULL
);


ALTER TABLE submissions OWNER TO aliaj;

--
-- Name: submissions_sub_id_seq; Type: SEQUENCE; Schema: public; Owner: aliaj
--

CREATE SEQUENCE submissions_sub_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE submissions_sub_id_seq OWNER TO aliaj;

--
-- Name: submissions_sub_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aliaj
--

ALTER SEQUENCE submissions_sub_id_seq OWNED BY submissions.sub_id;


--
-- Name: tools; Type: TABLE; Schema: public; Owner: aliaj; Tablespace: 
--

CREATE TABLE tools (
    link_id integer NOT NULL,
    link character varying(10) NOT NULL,
    content character varying(1000000)
);


ALTER TABLE tools OWNER TO aliaj;

--
-- Name: tools_link_id_seq; Type: SEQUENCE; Schema: public; Owner: aliaj
--

CREATE SEQUENCE tools_link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tools_link_id_seq OWNER TO aliaj;

--
-- Name: tools_link_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aliaj
--

ALTER SEQUENCE tools_link_id_seq OWNED BY tools.link_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: aliaj; Tablespace: 
--

CREATE TABLE users (
    user_id integer NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    email character varying(30) NOT NULL,
    phone character varying(30) NOT NULL,
    linkedin character varying(50),
    github character varying(20)
);


ALTER TABLE users OWNER TO aliaj;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: aliaj
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_id_seq OWNER TO aliaj;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aliaj
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: interview_id; Type: DEFAULT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY interviews ALTER COLUMN interview_id SET DEFAULT nextval('interviews_interview_id_seq'::regclass);


--
-- Name: pos_id; Type: DEFAULT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY positions ALTER COLUMN pos_id SET DEFAULT nextval('positions_pos_id_seq'::regclass);


--
-- Name: recruter_id; Type: DEFAULT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY recruters ALTER COLUMN recruter_id SET DEFAULT nextval('recruters_recruter_id_seq'::regclass);


--
-- Name: resume_id; Type: DEFAULT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY resumes ALTER COLUMN resume_id SET DEFAULT nextval('resumes_resume_id_seq'::regclass);


--
-- Name: status_id; Type: DEFAULT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY statuses ALTER COLUMN status_id SET DEFAULT nextval('statuses_status_id_seq'::regclass);


--
-- Name: sub_id; Type: DEFAULT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY submissions ALTER COLUMN sub_id SET DEFAULT nextval('submissions_sub_id_seq'::regclass);


--
-- Name: link_id; Type: DEFAULT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY tools ALTER COLUMN link_id SET DEFAULT nextval('tools_link_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Data for Name: interviews; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY interviews (interview_id, user_id, recruter_id, status_id, link_id, interview_date) FROM stdin;
\.


--
-- Name: interviews_interview_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('interviews_interview_id_seq', 1, false);


--
-- Data for Name: positions; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY positions (pos_id, position_name) FROM stdin;
1	Senior Software Engineer
2	Junior Software Engineer
3	Software Engineer
4	Software Engineer in Test
5	Principal Software Engineer
\.


--
-- Name: positions_pos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('positions_pos_id_seq', 5, true);


--
-- Data for Name: recruters; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY recruters (recruter_id, first_name, last_name, email, title, phone) FROM stdin;
1	Alitsiya	Yusupova	aliaj85@gmail.com	Software Engineer Fellow	425-214-3104
\.


--
-- Name: recruters_recruter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('recruters_recruter_id_seq', 1, true);


--
-- Data for Name: resumes; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY resumes (resume_id, resume_text) FROM stdin;
\.


--
-- Name: resumes_resume_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('resumes_resume_id_seq', 1, false);


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY statuses (status_id, status_name) FROM stdin;
1	New
2	Phone Interview
3	Background Check
4	Hired
5	Office Interview
\.


--
-- Name: statuses_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('statuses_status_id_seq', 5, true);


--
-- Data for Name: submissions; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY submissions (sub_id, user_id, position_id, salary, resume_id, time_of_submission) FROM stdin;
\.


--
-- Name: submissions_sub_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('submissions_sub_id_seq', 1, false);


--
-- Data for Name: tools; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY tools (link_id, link, content) FROM stdin;
\.


--
-- Name: tools_link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('tools_link_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY users (user_id, first_name, last_name, email, phone, linkedin, github) FROM stdin;
1	Alitsiya	Yusupova	alitsiya.yusupova@gmail.com	425-214-3104	alitsiya-yusupova-26332336	alitsiya
2	Jay	Smith	js@somedomain.com	555-555-5555	\N	\N
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('users_user_id_seq', 2, true);


--
-- Name: interviews_pkey; Type: CONSTRAINT; Schema: public; Owner: aliaj; Tablespace: 
--

ALTER TABLE ONLY interviews
    ADD CONSTRAINT interviews_pkey PRIMARY KEY (interview_id);


--
-- Name: positions_pkey; Type: CONSTRAINT; Schema: public; Owner: aliaj; Tablespace: 
--

ALTER TABLE ONLY positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY (pos_id);


--
-- Name: recruters_pkey; Type: CONSTRAINT; Schema: public; Owner: aliaj; Tablespace: 
--

ALTER TABLE ONLY recruters
    ADD CONSTRAINT recruters_pkey PRIMARY KEY (recruter_id);


--
-- Name: resumes_pkey; Type: CONSTRAINT; Schema: public; Owner: aliaj; Tablespace: 
--

ALTER TABLE ONLY resumes
    ADD CONSTRAINT resumes_pkey PRIMARY KEY (resume_id);


--
-- Name: statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: aliaj; Tablespace: 
--

ALTER TABLE ONLY statuses
    ADD CONSTRAINT statuses_pkey PRIMARY KEY (status_id);


--
-- Name: submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: aliaj; Tablespace: 
--

ALTER TABLE ONLY submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (sub_id);


--
-- Name: tools_pkey; Type: CONSTRAINT; Schema: public; Owner: aliaj; Tablespace: 
--

ALTER TABLE ONLY tools
    ADD CONSTRAINT tools_pkey PRIMARY KEY (link_id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: aliaj; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: interviews_link_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY interviews
    ADD CONSTRAINT interviews_link_id_fkey FOREIGN KEY (link_id) REFERENCES tools(link_id);


--
-- Name: interviews_recruter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY interviews
    ADD CONSTRAINT interviews_recruter_id_fkey FOREIGN KEY (recruter_id) REFERENCES recruters(recruter_id);


--
-- Name: interviews_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY interviews
    ADD CONSTRAINT interviews_status_id_fkey FOREIGN KEY (status_id) REFERENCES statuses(status_id);


--
-- Name: interviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY interviews
    ADD CONSTRAINT interviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: submissions_position_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY submissions
    ADD CONSTRAINT submissions_position_id_fkey FOREIGN KEY (position_id) REFERENCES positions(pos_id);


--
-- Name: submissions_resume_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY submissions
    ADD CONSTRAINT submissions_resume_id_fkey FOREIGN KEY (resume_id) REFERENCES resumes(resume_id);


--
-- Name: submissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY submissions
    ADD CONSTRAINT submissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: aliaj
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM aliaj;
GRANT ALL ON SCHEMA public TO aliaj;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

