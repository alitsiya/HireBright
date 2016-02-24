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


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: interviews; Type: TABLE; Schema: public; Owner: aliaj; Tablespace: 
--

CREATE TABLE interviews (
    interview_id integer NOT NULL,
    user_id integer NOT NULL,
    recruiter_id integer,
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
-- Name: openings; Type: TABLE; Schema: public; Owner: aliaj; Tablespace: 
--

CREATE TABLE openings (
    opening_id integer NOT NULL,
    opening_name character varying(50) NOT NULL,
    opening_description character varying(500)
);


ALTER TABLE openings OWNER TO aliaj;

--
-- Name: openings_opening_id_seq; Type: SEQUENCE; Schema: public; Owner: aliaj
--

CREATE SEQUENCE openings_opening_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE openings_opening_id_seq OWNER TO aliaj;

--
-- Name: openings_opening_id_seq1; Type: SEQUENCE; Schema: public; Owner: aliaj
--

CREATE SEQUENCE openings_opening_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE openings_opening_id_seq1 OWNER TO aliaj;

--
-- Name: openings_opening_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: aliaj
--

ALTER SEQUENCE openings_opening_id_seq1 OWNED BY openings.opening_id;


--
-- Name: recruiters; Type: TABLE; Schema: public; Owner: aliaj; Tablespace: 
--

CREATE TABLE recruiters (
    recruiter_id integer NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    password character varying(60) NOT NULL,
    email character varying(20) NOT NULL,
    title character varying(30),
    phone character varying(30)
);


ALTER TABLE recruiters OWNER TO aliaj;

--
-- Name: recruiters_recruiter_id_seq; Type: SEQUENCE; Schema: public; Owner: aliaj
--

CREATE SEQUENCE recruiters_recruiter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE recruiters_recruiter_id_seq OWNER TO aliaj;

--
-- Name: recruiters_recruiter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aliaj
--

ALTER SEQUENCE recruiters_recruiter_id_seq OWNED BY recruiters.recruiter_id;


--
-- Name: resumes; Type: TABLE; Schema: public; Owner: aliaj; Tablespace: 
--

CREATE TABLE resumes (
    resume_id integer NOT NULL,
    resume_text character varying(500000) NOT NULL,
    resume_string character varying(500000) NOT NULL,
    tsv tsvector
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
-- Name: tools; Type: TABLE; Schema: public; Owner: aliaj; Tablespace: 
--

CREATE TABLE tools (
    link_id integer NOT NULL,
    link character varying(10) NOT NULL,
    content character varying(100000)
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
    password character varying(60) NOT NULL,
    location character varying(50),
    email character varying(30) NOT NULL,
    phone character varying(30) NOT NULL,
    linkedin character varying(60),
    github character varying(20),
    "position" character varying(30),
    salary integer,
    resume_id integer,
    time_of_submission timestamp without time zone NOT NULL
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
-- Name: opening_id; Type: DEFAULT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY openings ALTER COLUMN opening_id SET DEFAULT nextval('openings_opening_id_seq1'::regclass);


--
-- Name: recruiter_id; Type: DEFAULT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY recruiters ALTER COLUMN recruiter_id SET DEFAULT nextval('recruiters_recruiter_id_seq'::regclass);


--
-- Name: resume_id; Type: DEFAULT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY resumes ALTER COLUMN resume_id SET DEFAULT nextval('resumes_resume_id_seq'::regclass);


--
-- Name: status_id; Type: DEFAULT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY statuses ALTER COLUMN status_id SET DEFAULT nextval('statuses_status_id_seq'::regclass);


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

COPY interviews (interview_id, user_id, recruiter_id, status_id, link_id, interview_date) FROM stdin;
3	4	\N	1	\N	\N
4	5	\N	1	\N	\N
5	6	\N	1	\N	\N
1	2	\N	1	\N	\N
6	7	1	3	1	2016-02-29 10:00:00
7	8	\N	1	2	\N
2	3	\N	1	\N	\N
\.


--
-- Name: interviews_interview_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('interviews_interview_id_seq', 7, true);


--
-- Data for Name: openings; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY openings (opening_id, opening_name, opening_description) FROM stdin;
\.


--
-- Name: openings_opening_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('openings_opening_id_seq', 1, false);


--
-- Name: openings_opening_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('openings_opening_id_seq1', 1, false);


--
-- Data for Name: recruiters; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY recruiters (recruiter_id, first_name, last_name, password, email, title, phone) FROM stdin;
1	Any	Joy	$2b$12$BjYCIYTO78v5wHsXc6JiIeB6S.H/cHKWrDzvR09whCUVi71.jxc7q	hr@hirebright.com	HR Specialist	425 214 3104
2	John	Pumpkin	$2b$12$JzWE9gQsU41bod6SjQVS9e74Uuqy1U1nZSeMvjRXO3Qn7C99Pz6xe	recruter1@gmail.com	Senior Product Manager	425 214 3104
\.


--
-- Name: recruiters_recruiter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('recruiters_recruiter_id_seq', 2, true);


--
-- Data for Name: resumes; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY resumes (resume_id, resume_text, resume_string, tsv) FROM stdin;
1	JAY SMITH\n71 Fifth Ave.\nSometown, NY 11597\n555.555.5555\njs@somedomain.com   SENIOR PROGRAMMER\n \n\n    Results-driven lead programmer offering extensive experience within both Fortune 500 and startup environments. SCJP and SCJD certified.\n    Able to incorporate user needs into cost-effective, secure and user-friendly solutions known for scalability and durability.\n    Innovator of next-generation solutions, systems and applications fueling major improvements to the bottom line.\n    Proven leader and project manager; drive system architecture decisions and lead projects from concept through the release process.\n\n \nTechnology\nSummary     \nLanguages/Programming: Java, J2EE, C, C++, Perl, PHP, VB.Net, SQL Server, ASP.Net, HTML, XML, SAP, ActiveX\n\nSystems: AIX, Linux, Unix (Solaris/HP-UX), Windows XP/NT v4.0\n\nNetworking: TCP/IP, SFTP, FTP\n\nDatabases: DB2, Oracle 8/7, Informix, MS Access\n \nProfessional\nExperience  ABC COMPANY -- Sometown, NY\nLead Programmer, 2009 to Present\n\nDevelop, maintain and support application programs for administrative, Web and mobile systems using Java and related tools. Analyze code for system testing and debugging; create test transactions to find, isolate and rectify issues; and manage a team of three programmers. Accomplishments:\n\n    Reengineered multiple systems that fueled improvements to productivity, efficiency, uptime and accuracy for global business operations. Developed code, system design and test/QA plans for all solutions and often coordinated the national or international rollout.\n    Led, architected and participated in the design, testing and deployment of client/server, multitier applications, ActiveX and related components.\n    Developed new procedures for requirements gathering, needs analysis, testing, scripting and documentation to strengthen quality and functionality of business-critical applications.\n    Developed large-scale, portable, thread-safe and ultra-high performance foundation and application infrastructure libraries.\n    Trained and mentored junior programmers in programming methodologies and best practices.\n    Delivered back-office tools supporting ecommerce initiatives, enabling company to compete more effectively in the marketplace through search-engine optimization.\n    Served as a core group member in defining and prioritizing technology investments for the next two years, ensuring the alignment of process, technology and business objectives.\n\nXYZ.COM -- Sometown, NJ\nLead Programmer, 2002 to 2008\n\nLed programming tasks including enhancements, maintenance and support for clients' applications and interfaces. Engineered software products, handling complex analysis and intricate programming to meet project requirements. Accomplishments:\n\n    Led solutions engineering that involved process automation, macro conversion and functionality enhancement. Replaced time-consuming, error-prone manual processes with elegant, automated solutions.\n    Developed and implemented cross-platform, Java-based POS system. Completed project under budget and three weeks ahead of deadline.\n    Coded new solutions that increased availability and scalability by 45% and 75%, respectively.\n\nDEF COMPANY -- Sometown, NJ\nProgrammer II / Programmer I, 2000 to 2002\nHelp Desk Analyst, 1998 to 2000\n\nProgressed through promotions, culminating in responsibility for Web-based application programming within high-volume setting. Became adept in analyzing code for system testing and debugging.\n \nEducation &\nCredentials     ABC UNIVERSITY -- Sometown, NY\nMS in Software Engineering Candidate, 2010 to Present\nCurrent GPA: 3.8 | Expected Graduation: 2012\n\nDEF UNIVERSITY -- Sometown, NJ\nBS in Computer Information Science, 1998\n\nCertifications:\n\n    Sun Certified Java Programmer (SCJP), 2007 \n    Sun Certified Java Developer (SCJD), 2008\n\nRecent Seminars:\n\n    Enterprise Java Development\n    C++ Programming: Concepts, Design and Implementation\n    Windows Programming Using Visual C++\n    Advanced Workshop in Object-Oriented Analysis and Design\n    Project Lifecycle and Project Management Master Class\n    Project Management Methods\n\nVolunteerism    Little League Coach (Sometown, NY), 2009 to Present\nPTA Secretary (Sometown Elementary School), 2010 to Present\nActive Volunteer, Special Olympics, 2008 to Present\n  Available for Relocation  \n	jay smith 71 fifth ave sometown ny 11597 5555555555 jssomedomaincom   senior programmer        resultsdriven lead programmer offering extensive experience within both fortune 500 and startup environments scjp and scjd certified     able to incorporate user needs into costeffective secure and userfriendly solutions known for scalability and durability     innovator of nextgeneration solutions systems and applications fueling major improvements to the bottom line     proven leader and project manager drive system architecture decisions and lead projects from concept through the release process    technology summary      languagesprogramming java j2ee c c perl php vbnet sql server aspnet html xml sap activex  systems aix linux unix solarishpux windows xpnt v40  networking tcpip sftp ftp  databases db2 oracle 87 informix ms access   professional experience  abc company  sometown ny lead programmer 2009 to present  develop maintain and support application programs for administrative web and mobile systems using java and related tools analyze code for system testing and debugging create test transactions to find isolate and rectify issues and manage a team of three programmers accomplishments      reengineered multiple systems that fueled improvements to productivity efficiency uptime and accuracy for global business operations developed code system design and testqa plans for all solutions and often coordinated the national or international rollout     led architected and participated in the design testing and deployment of clientserver multitier applications activex and related components     developed new procedures for requirements gathering needs analysis testing scripting and documentation to strengthen quality and functionality of businesscritical applications     developed largescale portable threadsafe and ultrahigh performance foundation and application infrastructure libraries     trained and mentored junior programmers in programming methodologies and best practices     delivered backoffice tools supporting ecommerce initiatives enabling company to compete more effectively in the marketplace through searchengine optimization     served as a core group member in defining and prioritizing technology investments for the next two years ensuring the alignment of process technology and business objectives  xyzcom  sometown nj lead programmer 2002 to 2008  led programming tasks including enhancements maintenance and support for clients applications and interfaces engineered software products handling complex analysis and intricate programming to meet project requirements accomplishments      led solutions engineering that involved process automation macro conversion and functionality enhancement replaced timeconsuming errorprone manual processes with elegant automated solutions     developed and implemented crossplatform javabased pos system completed project under budget and three weeks ahead of deadline     coded new solutions that increased availability and scalability by 45 and 75 respectively  def company  sometown nj programmer ii  programmer i 2000 to 2002 help desk analyst 1998 to 2000  progressed through promotions culminating in responsibility for webbased application programming within highvolume setting became adept in analyzing code for system testing and debugging   education  credentials     abc university  sometown ny ms in software engineering candidate 2010 to present current gpa 38  expected graduation 2012  def university  sometown nj bs in computer information science 1998  certifications      sun certified java programmer scjp 2007      sun certified java developer scjd 2008  recent seminars      enterprise java development     c programming concepts design and implementation     windows programming using visual c     advanced workshop in objectoriented analysis and design     project lifecycle and project management master class     project management methods  volunteerism    little league coach sometown ny 2009 to present pta secretary sometown elementary school 2010 to present active volunteer special olympics 2008 to present   available for relocation	\N
2	JAY SMITH\n71 Fifth Ave.\nSometown, NY 11597\n555.555.5555\njs@somedomain.com   SENIOR PROGRAMMER\n \n\n    Results-driven lead programmer offering extensive experience within both Fortune 500 and startup environments. SCJP and SCJD certified.\n    Able to incorporate user needs into cost-effective, secure and user-friendly solutions known for scalability and durability.\n    Innovator of next-generation solutions, systems and applications fueling major improvements to the bottom line.\n    Proven leader and project manager; drive system architecture decisions and lead projects from concept through the release process.\n\n \nTechnology\nSummary     \nLanguages/Programming: Java, J2EE, C, C++, Perl, PHP, VB.Net, SQL Server, ASP.Net, HTML, XML, SAP, ActiveX\n\nSystems: AIX, Linux, Unix (Solaris/HP-UX), Windows XP/NT v4.0\n\nNetworking: TCP/IP, SFTP, FTP\n\nDatabases: DB2, Oracle 8/7, Informix, MS Access\n \nProfessional\nExperience  ABC COMPANY -- Sometown, NY\nLead Programmer, 2009 to Present\n\nDevelop, maintain and support application programs for administrative, Web and mobile systems using Java and related tools. Analyze code for system testing and debugging; create test transactions to find, isolate and rectify issues; and manage a team of three programmers. Accomplishments:\n\n    Reengineered multiple systems that fueled improvements to productivity, efficiency, uptime and accuracy for global business operations. Developed code, system design and test/QA plans for all solutions and often coordinated the national or international rollout.\n    Led, architected and participated in the design, testing and deployment of client/server, multitier applications, ActiveX and related components.\n    Developed new procedures for requirements gathering, needs analysis, testing, scripting and documentation to strengthen quality and functionality of business-critical applications.\n    Developed large-scale, portable, thread-safe and ultra-high performance foundation and application infrastructure libraries.\n    Trained and mentored junior programmers in programming methodologies and best practices.\n    Delivered back-office tools supporting ecommerce initiatives, enabling company to compete more effectively in the marketplace through search-engine optimization.\n    Served as a core group member in defining and prioritizing technology investments for the next two years, ensuring the alignment of process, technology and business objectives.\n\nXYZ.COM -- Sometown, NJ\nLead Programmer, 2002 to 2008\n\nLed programming tasks including enhancements, maintenance and support for clients' applications and interfaces. Engineered software products, handling complex analysis and intricate programming to meet project requirements. Accomplishments:\n\n    Led solutions engineering that involved process automation, macro conversion and functionality enhancement. Replaced time-consuming, error-prone manual processes with elegant, automated solutions.\n    Developed and implemented cross-platform, Java-based POS system. Completed project under budget and three weeks ahead of deadline.\n    Coded new solutions that increased availability and scalability by 45% and 75%, respectively.\n\nDEF COMPANY -- Sometown, NJ\nProgrammer II / Programmer I, 2000 to 2002\nHelp Desk Analyst, 1998 to 2000\n\nProgressed through promotions, culminating in responsibility for Web-based application programming within high-volume setting. Became adept in analyzing code for system testing and debugging.\n \nEducation &\nCredentials     ABC UNIVERSITY -- Sometown, NY\nMS in Software Engineering Candidate, 2010 to Present\nCurrent GPA: 3.8 | Expected Graduation: 2012\n\nDEF UNIVERSITY -- Sometown, NJ\nBS in Computer Information Science, 1998\n\nCertifications:\n\n    Sun Certified Java Programmer (SCJP), 2007 \n    Sun Certified Java Developer (SCJD), 2008\n\nRecent Seminars:\n\n    Enterprise Java Development\n    C++ Programming: Concepts, Design and Implementation\n    Windows Programming Using Visual C++\n    Advanced Workshop in Object-Oriented Analysis and Design\n    Project Lifecycle and Project Management Master Class\n    Project Management Methods\n\nVolunteerism    Little League Coach (Sometown, NY), 2009 to Present\nPTA Secretary (Sometown Elementary School), 2010 to Present\nActive Volunteer, Special Olympics, 2008 to Present\n  Available for Relocation  \n	jay smith 71 fifth ave sometown ny 11597 5555555555 jssomedomaincom   senior programmer        resultsdriven lead programmer offering extensive experience within both fortune 500 and startup environments scjp and scjd certified     able to incorporate user needs into costeffective secure and userfriendly solutions known for scalability and durability     innovator of nextgeneration solutions systems and applications fueling major improvements to the bottom line     proven leader and project manager drive system architecture decisions and lead projects from concept through the release process    technology summary      languagesprogramming java j2ee c c perl php vbnet sql server aspnet html xml sap activex  systems aix linux unix solarishpux windows xpnt v40  networking tcpip sftp ftp  databases db2 oracle 87 informix ms access   professional experience  abc company  sometown ny lead programmer 2009 to present  develop maintain and support application programs for administrative web and mobile systems using java and related tools analyze code for system testing and debugging create test transactions to find isolate and rectify issues and manage a team of three programmers accomplishments      reengineered multiple systems that fueled improvements to productivity efficiency uptime and accuracy for global business operations developed code system design and testqa plans for all solutions and often coordinated the national or international rollout     led architected and participated in the design testing and deployment of clientserver multitier applications activex and related components     developed new procedures for requirements gathering needs analysis testing scripting and documentation to strengthen quality and functionality of businesscritical applications     developed largescale portable threadsafe and ultrahigh performance foundation and application infrastructure libraries     trained and mentored junior programmers in programming methodologies and best practices     delivered backoffice tools supporting ecommerce initiatives enabling company to compete more effectively in the marketplace through searchengine optimization     served as a core group member in defining and prioritizing technology investments for the next two years ensuring the alignment of process technology and business objectives  xyzcom  sometown nj lead programmer 2002 to 2008  led programming tasks including enhancements maintenance and support for clients applications and interfaces engineered software products handling complex analysis and intricate programming to meet project requirements accomplishments      led solutions engineering that involved process automation macro conversion and functionality enhancement replaced timeconsuming errorprone manual processes with elegant automated solutions     developed and implemented crossplatform javabased pos system completed project under budget and three weeks ahead of deadline     coded new solutions that increased availability and scalability by 45 and 75 respectively  def company  sometown nj programmer ii  programmer i 2000 to 2002 help desk analyst 1998 to 2000  progressed through promotions culminating in responsibility for webbased application programming within highvolume setting became adept in analyzing code for system testing and debugging   education  credentials     abc university  sometown ny ms in software engineering candidate 2010 to present current gpa 38  expected graduation 2012  def university  sometown nj bs in computer information science 1998  certifications      sun certified java programmer scjp 2007      sun certified java developer scjd 2008  recent seminars      enterprise java development     c programming concepts design and implementation     windows programming using visual c     advanced workshop in objectoriented analysis and design     project lifecycle and project management master class     project management methods  volunteerism    little league coach sometown ny 2009 to present pta secretary sometown elementary school 2010 to present active volunteer special olympics 2008 to present   available for relocation	\N
3	10 0 2  H e at h w o o d  D air y R d A p ex, N C  2 75 0 2\n\nJoseph Gregorio\n\nP h o n e: ( 9 19) 2 7 2 3 76 4 joe @ bit working.org\n\nObjective Employment where I can apply 14 years of experience designing and delivering  software across a wide range of platforms to make customers happy.\n\nProfessional Profile Software engineer with a record of success in designing, building and shipping Web,  Windows and embedded firmware applications on time and on budget. Works easily  across departments to bring new solutions on line and new products to market. A  passion for creating software and protocols that extends beyond a fulltime job and  into publication and membership in working groups.\n\nSkills\nS kill N a m e C/C++ X M L  a n d  relate d tech n ologies (X SLT, S V G , etc) W e b  Tech n ologies (H T TP, C GI, T F TP, etc.) Python Linux W i n 3 2  Pr o gra m m i ng  ( Win do w s  9 5/98/ N T/X P) Perl\n\nExperience 14  ye ars 7 years 7 years 5 years 7 years 14  ye ars 4 years\n\nAccomplishments\nIndependent of my fulltime day job\n Member of the IETF AtomPub Working Group o CoEditor of the Atom Publishing Protocol, a REST based protocol that takes  much of it's basic structure from RESTlog, a REST based weblog editing  protocol that I developed in 2002. o Contributor to the Atom Syndication Format.\n Author o A regular column for XML.com, "The RESTful Web". o Chapters in two O'Reilly Hacks books, "Greasemonkey Hacks", the other not  yet published. o B  itWorking.org , a popular technology weblog maintained over the past four  years.\n Open Source  o  Aggie   The first desktop news aggregator written for .NET. The RSS parsing  engine of Aggie was used in early releases of NewsGator. o  Python modules  to make developing RESTful web services easier. o S  ecure Syndication   A Greasemonkey script for decrypting syndicated  content in a web browser. \n Conferences o Presented "Secure Syndication" at Etech 2006\n\n\fo Presented "The Atom Publishing Protocol" at XML 2005 o Presented "The Atom Publishing Protocol" at XML 2004 o Presented "Extending HTTP Authentication" at ApacheCon 2003\nDuring the last four years at SAMSys, Inc.\n Developed parts of the software architecture for the next generation product.  Designed and implemented: o The embedded scripting language for the new product. o An automated build system that compiled and ran all unit tests on an hourly  basis. All reports were web based and failures were reported via email. o An automated system that processed wiki markup that described the data  model and produced, via Python and XSLT, a series of C, Java, .Net and HTML  files. o Championed the use of scripting languages in the software development  process to simulate new product components to speed product development.\n Created a fast scripting engine based architecture for embedded system development.  This architecture was adopted across all product lines.\n Wrote a Web server, SOAP server, SOAP client, and Telnet server. All of these services  plus RFID specific hardware interfaces all ran on a 25MHz 386 with 512KB of RAM.\n Introduced wikis and Subversion into the software group.  Introduced unit testing to the software engineering department.\no The 386based system mentioned previously had over 800 unit tests.  Created a webbased interface to an internal administrative database to allow remote \nemployees to update sales records remotely.  Provided sales support:\no Created Windows based demonstration applications for use at trade shows on  very short notice.\no Created/ordered/assembled/installed mechanical designs for trade show  systems.\no Worked directly with customers to determine their system integration needs. o Created software development kits and sample code.\nDuring 7 years at MTS\n Project Lead for a Windows 95/98/NT statistical analysis software project.  o Completed on time and within budget o Shipped with a manual and context sensitive help. o First software product from the division to use the Standard Template Library. o Included an interpreted language for statistical analysis.\n Software Architect for a Windows 95/98/NT software project which was a complete  rewrite of MTS's best selling material testing software package. o Created an architecture so flexible and easily tailored that writing customized  software applications was no longer needed within the division. o Created a fast and flexible file format. Developed a file editor and repair  utilities for the new file format. o Created a flexible object loading scheme. o Helped research and develop the use of RTF for report generation. o First product from the division to include an interpreted language for  machine control and data analysis.\n Project Lead for a CE compliant Universal Serial Bus (USB) interface device. \n\n\fo The project was on time, on budget and below cost. o This project was the first USB product developed by MTS Systems \nCorporation.  Designed and implemented a GUI class library used across the division.\n Introduced version control software to the MTDRaleigh division for both software  source code and engineering drawings.\n Introduced coding standards, code reviews and semiformal User Interface Design \nmethodologies to the MTDRaleigh division.  Started technical magazine subscriptions for the software engineers.  Initiated and ran weekly minitraining classes on C++ and objectoriented \nprogramming.\n\nEmployment History\n\nSAMSys Employment: October 2001Present\n\nResponsibilities: Designed, coded, tested and documented software for RFID readers and \n\ntheir  associated support applications. Platforms included DSPs, microcontrollers, Windows \n\nmachines and Linux based devices. Helped develop the software architecture for the RFID \n\nreaders including the design of two embedded languages. Added Web, SOAP and other IP \n\nbased interface support to products. Researched and tested new tools, techniques and \n\ntechnologies to bring into the department, such as unit testing, wikis, Python, and \n\nSubversion. Created software development kits and sample code for end users.\n\nMTS \n\nDivision:\n\nMTDRaleigh\n\nEmployment:  September 1994August 2001  \n\nResponsibilities:  Active lead on projects to produce firmware and Windows application \n\nsoftware. Many projects had electrical engineering and mechanical engineering components. \n\nResponsibilities for the projects included designing the product architecture, writing code, \n\ndebugging, calling design reviews, and reporting the project status to the management team. \n\nResponsible for researching new tools, techniques and technologies to bring into the \n\ndepartment. Managed the IT department of three fulltime employees.\n\nTecan U.S. Employment:  July 1992 September 1994 \n\nResponsibilities:  Met with customers to assess their software needs. Designed embedded or \n\nWindows based software solutions, coded, tested, documented, and maintained software and \n\nprovided customer training. \n\nEducation\nDartmouth College  Masters of Arts in Mathematics, 1992.\nEastern Connecticut State University  Bachelors of Science in Mathematics, 1989, 3.76 GPA. Bachelors of Science in Computer Science, 1989, 3.76 GPA.\n\nClasses\nBiomathematics Class BMA567, North Carolina State University, Fall, 1999. Fred Pryor Seminar, "How to Supervise People", Dec 12, 1997. Software Engineering Class CSC510, North Carolina State University, Fall, 1994.\n\n\f	10 0 2  h e at h w o o d  d air y r d a p ex n c  2 75 0 2  joseph gregorio  p h o n e  9 19 2 7 2 3 76 4 joe  bit workingorg  objective employment where i can apply 14 years of experience designing and delivering  software across a wide range of platforms to make customers happy  professional profile software engineer with a record of success in designing building and shipping web  windows and embedded firmware applications on time and on budget works easily  across departments to bring new solutions on line and new products to market a  passion for creating software and protocols that extends beyond a fulltime job and  into publication and membership in working groups  skills s kill n a m e cc x m l  a n d  relate d tech n ologies x slt s v g  etc w e b  tech n ologies h t tp c gi t f tp etc python linux w i n 3 2  pr o gra m m i ng   win do w s  9 598 n tx p perl  experience 14  ye ars 7 years 7 years 5 years 7 years 14  ye ars 4 years  accomplishments independent of my fulltime day job  member of the ietf atompub working group o coeditor of the atom publishing protocol a rest based protocol that takes  much of its basic structure from restlog a rest based weblog editing  protocol that i developed in 2002 o contributor to the atom syndication format  author o a regular column for xmlcom the restful web o chapters in two oreilly hacks books greasemonkey hacks the other not  yet published o b  itworkingorg  a popular technology weblog maintained over the past four  years  open source  o  aggie   the first desktop news aggregator written for net the rss parsing  engine of aggie was used in early releases of newsgator o  python modules  to make developing restful web services easier o s  ecure syndication   a greasemonkey script for decrypting syndicated  content in a web browser   conferences o presented secure syndication at etech 2006  \fo presented the atom publishing protocol at xml 2005 o presented the atom publishing protocol at xml 2004 o presented extending http authentication at apachecon 2003 during the last four years at samsys inc  developed parts of the software architecture for the next generation product  designed and implemented o the embedded scripting language for the new product o an automated build system that compiled and ran all unit tests on an hourly  basis all reports were web based and failures were reported via email o an automated system that processed wiki markup that described the data  model and produced via python and xslt a series of c java net and html  files o championed the use of scripting languages in the software development  process to simulate new product components to speed product development  created a fast scripting engine based architecture for embedded system development  this architecture was adopted across all product lines  wrote a web server soap server soap client and telnet server all of these services  plus rfid specific hardware interfaces all ran on a 25mhz 386 with 512kb of ram  introduced wikis and subversion into the software group  introduced unit testing to the software engineering department o the 386based system mentioned previously had over 800 unit tests  created a webbased interface to an internal administrative database to allow remote  employees to update sales records remotely  provided sales support o created windows based demonstration applications for use at trade shows on  very short notice o createdorderedassembledinstalled mechanical designs for trade show  systems o worked directly with customers to determine their system integration needs o created software development kits and sample code during 7 years at mts  project lead for a windows 9598nt statistical analysis software project  o completed on time and within budget o shipped with a manual and context sensitive help o first software product from the division to use the standard template library o included an interpreted language for statistical analysis  software architect for a windows 9598nt software project which was a complete  rewrite of mtss best selling material testing software package o created an architecture so flexible and easily tailored that writing customized  software applications was no longer needed within the division o created a fast and flexible file format developed a file editor and repair  utilities for the new file format o created a flexible object loading scheme o helped research and develop the use of rtf for report generation o first product from the division to include an interpreted language for  machine control and data analysis  project lead for a ce compliant universal serial bus usb interface device   \fo the project was on time on budget and below cost o this project was the first usb product developed by mts systems  corporation  designed and implemented a gui class library used across the division  introduced version control software to the mtdraleigh division for both software  source code and engineering drawings  introduced coding standards code reviews and semiformal user interface design  methodologies to the mtdraleigh division  started technical magazine subscriptions for the software engineers  initiated and ran weekly minitraining classes on c and objectoriented  programming  employment history  samsys employment october 2001present  responsibilities designed coded tested and documented software for rfid readers and   their  associated support applications platforms included dsps microcontrollers windows   machines and linux based devices helped develop the software architecture for the rfid   readers including the design of two embedded languages added web soap and other ip   based interface support to products researched and tested new tools techniques and   technologies to bring into the department such as unit testing wikis python and   subversion created software development kits and sample code for end users  mts   division  mtdraleigh  employment  september 1994august 2001    responsibilities  active lead on projects to produce firmware and windows application   software many projects had electrical engineering and mechanical engineering components   responsibilities for the projects included designing the product architecture writing code   debugging calling design reviews and reporting the project status to the management team   responsible for researching new tools techniques and technologies to bring into the   department managed the it department of three fulltime employees  tecan us employment  july 1992 september 1994   responsibilities  met with customers to assess their software needs designed embedded or   windows based software solutions coded tested documented and maintained software and   provided customer training   education dartmouth college  masters of arts in mathematics 1992 eastern connecticut state university  bachelors of science in mathematics 1989 376 gpa bachelors of science in computer science 1989 376 gpa  classes biomathematics class bma567 north carolina state university fall 1999 fred pryor seminar how to supervise people dec 12 1997 software engineering class csc510 north carolina state university fall 1994	\N
4	Alyson van Hardenberg\navanhardenberg@gmail.com (415) 216-9086 www.linkedin.com/in/akvanhar @akvanh \nQualifications Summary\nTechnical skills span Python, Flask, Javascript, jQuery, AJAX, SQLite, SQLAlchemy, Google Maps API, Facebook Graph API, Twilio API, HTML/CSS, Twitter Bootstrap and Python unittest. With my experience in nursing/healthcare, I bring to software engineering experience in problem solving in a fast paced, technical environment where team-work is very important.\nProjects (& Affiliations)\n Make Less Mush: https://github.com/akvanhar/HB-FinalProject\n Make Less Mush is a full-stack web application that provides parents with a social-\nmedia based baby food sharing/messaging service.\n Ratings: https://github.com/akvanhar/HB-ratings\n A web app that allows users to rate films, and predicts how they will rate films. This prediction is based on an analysis of how other similar users have rated the film.\n Member of: Bay Area Girl Geek Dinner, Women Who Code: SF, PyLadies of San Francisco\nExperience\nMaxim Healthcare Services, Registered Nurse Mar 2014-present\n Supported students with their healthcare needs during the school day.\n Helped run health clinics in office settings. Checked blood pressure, cholesterol, HgA1C.\nProvided personalized health advice to clients during face-paced 15 minute sessions.\n826 Valencia, Volunteer 2013-2014\n After school tutor for school aged children in the Mission neighborhood in San Francisco.\nDoula Seminars, Volunteer 2013-2014  With an interdisciplinary team, offered doula services using a harm reduction approach to\nsubstance-using women, substance-exposed newborns and new immigrants without insurance.\nSelf-employed, Birth and Postpartum Doula 2009-2014  Provided prenatal, birth and postpartum doula care.\nVictoria School District, Educational Assistant 2007 - 2010  Supported students with various special needs and learning challenges from grades 6 - 12.\nEducation\nHackbright Academy, Software Engineer Immersive Program for Women 2015 University of British Columbia, B.S. Nursing 2012 University of Victoria, B.A. Human and Social Development 2008	alyson van hardenberg avanhardenberggmailcom 415 2169086 wwwlinkedincominakvanhar akvanh  qualifications summary technical skills span python flask javascript jquery ajax sqlite sqlalchemy google maps api facebook graph api twilio api htmlcss twitter bootstrap and python unittest with my experience in nursinghealthcare i bring to software engineering experience in problem solving in a fast paced technical environment where teamwork is very important projects  affiliations  make less mush httpsgithubcomakvanharhbfinalproject  make less mush is a fullstack web application that provides parents with a social media based baby food sharingmessaging service  ratings httpsgithubcomakvanharhbratings  a web app that allows users to rate films and predicts how they will rate films this prediction is based on an analysis of how other similar users have rated the film  member of bay area girl geek dinner women who code sf pyladies of san francisco experience maxim healthcare services registered nurse mar 2014present  supported students with their healthcare needs during the school day  helped run health clinics in office settings checked blood pressure cholesterol hga1c provided personalized health advice to clients during facepaced 15 minute sessions 826 valencia volunteer 20132014  after school tutor for school aged children in the mission neighborhood in san francisco doula seminars volunteer 20132014  with an interdisciplinary team offered doula services using a harm reduction approach to substanceusing women substanceexposed newborns and new immigrants without insurance selfemployed birth and postpartum doula 20092014  provided prenatal birth and postpartum doula care victoria school district educational assistant 2007  2010  supported students with various special needs and learning challenges from grades 6  12 education hackbright academy software engineer immersive program for women 2015 university of british columbia bs nursing 2012 university of victoria ba human and social development 2008	\N
5	Charles Fulton\ncharliefulton@gmail.com 803-370-8312\n4059 Farben Way\nFort Mill, SC 29715\nSummary\nResults-oriented software developer and research professional with sixteen years experience in both development and research positions. I make it my goal to create software with the user in mind, creating applications with a useable and intuitive user interface experience. I also understand the importance of creating highly readable and easily maintainable source code. I am constantly striving to learn new technologies and look to ways to better myself in this rapidly changing industry.\nTechnical Skills\nLanguages: Objective-C (4); Groovy (2); Java (16); JavaScript (10+); JSON (5); C (5); SQL (17); Perl (10); PHP (2); HTML (17); Bash (17)\nDatabases: MySQL (10+); Netezza (3), Oracle (10); Postgresql (5); SQL Server (8);\nDevelopment Software: Xcode (5), Eclipse (10); Git (3)\nTechnologies: RESTful web services (4); Grails (3), Jersey (3), Rails (1), Java Frameworks (17), multiple JavaScript frameworks (5);\nApplication / Web Servers: Tomcat (15); Jboss (5); Apache (10) ; LAMP (10+);\nPlatforms: Mac OSX (10+); UNIX/Linux (17);\nCloud services: Amazon AWS (EC2, RDS, S3) (2), Parse (1) Work Experience\nIndependent & Contract iOS Development\nDates: 2009  Present\n Revelry  Helping with app redesign. Addressed performance in multiple areas. Added image\ncaching, and tuned calls to Parse. App is built upon Parse backend.\nhttps://itunes.apple.com/us/app/revelry/id650168769?mt=8\n workSmart iBreeze  Universal app. Helped fix some issues with iOS7 support and other misc\nbugs. Started work on v 1.1.15+, successfully submitted multiple updates to app store for client.\nhttps://itunes.apple.com/us/app/worksmart-ibreeze/id423004568?mt=8\n GuildBrowser App  My iPad app released on Apple app store July 2013. Sample app used in the\nbook iOS6 By Tutorials. App consumes Blizzard RESTful web services using the JSON data returned. https://itunes.apple.com/us/app/guildbrowser/id585268037?mt=8\nSr. iOS Developer, Quantisense Inc.\nDates Employed: 05/2011  Present\n Performed in a Lead developer role on an enterprise iOS app for lululemon. App allows\nemployees to scan store inventory to display real time point of sale, e-commerice, and nightly data warehouse data. Featured remote device configuration by consuming RESTful web services to pull down store specific app settings.\n Created custom internal iOS framework utilized by all iOS apps. Framework included support for multiple scanning implementations including linea-pro 2d / 3d hardware scanners and the ZBar library.\n Created custom internal "apple store" to deploy iOS builds via sites created by jenkins jobs for multiple internal enterprise and ad hoc signed apps.\n RESTful web services development with grails.\n Developed seasonal planning web app using the gwt and smartgwt (core java) frameworks for CMRG / DXL Inc.\n Cloud server management via AWS.\nSr. Java Developer, Premier Inc.\nDates Employed: 12/2008  05/2011\n Successfully reduced the bug backlog for Quality Measures Reporter (QMR), fixing issues found\nin Javascript, Struts2 Actions, Spring, and Hibernate areas.\n Participated in the successful release of the QualityAdvisor and OperationsAdvisor - Department\nBenchmarking Report, using the agile development methodology.\n Designed and implemented Quality Advisor header, feature menu system, and User Admin area\nusing Sruts2, Spring 2.5, Spring, Jsp pages, and the Dojo Javascript framework.\n Developed web services with Struts2 Actions using JSON to connect with Dojo on the client side.\n For all projects coding responsibilities involved all areas of development including front end\n(Dojo/Javascript/JSP), middleware (Struts2/Spring), and backend (Hibernate / Stored procedures).\nSoftware Engineer, Science Applications International Corporation (SAIC)\nDates Employed: 01/2003  12/2008\nR&D UNIX Specialist, The Dow Chemical Corporation\nDates Employed: 05/2001 - 01/2003\nComputational Chemist, Union Carbide Corporation\nDates Employed: 05/1997 - 05/2001\nEducation\nMarshall University\nHuntington, WV 25755 B.S. in Chemistry, 1996\nReferences available upon request	charles fulton charliefultongmailcom 8033708312 4059 farben way fort mill sc 29715 summary resultsoriented software developer and research professional with sixteen years experience in both development and research positions i make it my goal to create software with the user in mind creating applications with a useable and intuitive user interface experience i also understand the importance of creating highly readable and easily maintainable source code i am constantly striving to learn new technologies and look to ways to better myself in this rapidly changing industry technical skills languages objectivec 4 groovy 2 java 16 javascript 10 json 5 c 5 sql 17 perl 10 php 2 html 17 bash 17 databases mysql 10 netezza 3 oracle 10 postgresql 5 sql server 8 development software xcode 5 eclipse 10 git 3 technologies restful web services 4 grails 3 jersey 3 rails 1 java frameworks 17 multiple javascript frameworks 5 application  web servers tomcat 15 jboss 5 apache 10  lamp 10 platforms mac osx 10 unixlinux 17 cloud services amazon aws ec2 rds s3 2 parse 1 work experience independent  contract ios development dates 2009  present  revelry  helping with app redesign addressed performance in multiple areas added image caching and tuned calls to parse app is built upon parse backend httpsitunesapplecomusapprevelryid650168769mt8  worksmart ibreeze  universal app helped fix some issues with ios7 support and other misc bugs started work on v 1115 successfully submitted multiple updates to app store for client httpsitunesapplecomusappworksmartibreezeid423004568mt8  guildbrowser app  my ipad app released on apple app store july 2013 sample app used in the book ios6 by tutorials app consumes blizzard restful web services using the json data returned httpsitunesapplecomusappguildbrowserid585268037mt8 sr ios developer quantisense inc dates employed 052011  present  performed in a lead developer role on an enterprise ios app for lululemon app allows employees to scan store inventory to display real time point of sale ecommerice and nightly data warehouse data featured remote device configuration by consuming restful web services to pull down store specific app settings  created custom internal ios framework utilized by all ios apps framework included support for multiple scanning implementations including lineapro 2d  3d hardware scanners and the zbar library  created custom internal apple store to deploy ios builds via sites created by jenkins jobs for multiple internal enterprise and ad hoc signed apps  restful web services development with grails  developed seasonal planning web app using the gwt and smartgwt core java frameworks for cmrg  dxl inc  cloud server management via aws sr java developer premier inc dates employed 122008  052011  successfully reduced the bug backlog for quality measures reporter qmr fixing issues found in javascript struts2 actions spring and hibernate areas  participated in the successful release of the qualityadvisor and operationsadvisor  department benchmarking report using the agile development methodology  designed and implemented quality advisor header feature menu system and user admin area using sruts2 spring 25 spring jsp pages and the dojo javascript framework  developed web services with struts2 actions using json to connect with dojo on the client side  for all projects coding responsibilities involved all areas of development including front end dojojavascriptjsp middleware struts2spring and backend hibernate  stored procedures software engineer science applications international corporation saic dates employed 012003  122008 rd unix specialist the dow chemical corporation dates employed 052001  012003 computational chemist union carbide corporation dates employed 051997  052001 education marshall university huntington wv 25755 bs in chemistry 1996 references available upon request	\N
6	\n\nTammy Mullins\n\n1 Main Street\nNew Cityland, CA 91010\nCell: (555) 322-7337\nE-Mail: example-email@example.com\n\nSummary\n\nSenior Web Developer specializing in front end development. Experienced with all stages of the development cycle for dynamic web projects. Well-versed in numerous programming languages including JavaScript, SQL, and C. Strong background in project management and customer relations.\n\nHighlights\n\nCreative design\nSearch engine optimization\nProject management\nService-focused\nUsability expertise\n\nSharePoint\nComplex problem solver\nStrong decision maker\nExcellent communicator\nInnovative\n\nExperience\n\nJanuary 2008 to Current\nFreelance New Cityland, CA\nWeb Developer\n\nWork with senior developer to manage large, complex design projects for corporate clients.\nDevelop project concepts and maintain optimal workflow.\nComplete detailed programming and development tasks for front end public and internal websites as well as challenging back-end server code.\nCollaborate with designers to create clean interfaces and simple, intuitive interactions and experiences.\nCarry out quality assurance tests to discover errors and optimize usability.\n\nApril 2005 to December 2007\nRedstone Web Design New Cityland, CA\nWeb Developer\n\nJoined client meetings to learn about development of project scopes.\nContacted clients to obtain more information and discuss design options.\nOversaw scheduling of project milestones and coordinated with clients on any proposed changes or challenges to be overcome.\nSpecialized in medical and legal websites.\nActively sought tough projects to develop programming and service skills.\n\nEducation\n\n2006 Fieldstone University New Cityland, CA\nBachelor of Science Computer Information Systems\n\nTop 5% of class\n\nCertifications\n\nJava SE 7 Certified Programmer\nC Certified Professional Programmer (CLP)\n	tammy mullins  1 main street new cityland ca 91010 cell 555 3227337 email exampleemailexamplecom  summary  senior web developer specializing in front end development experienced with all stages of the development cycle for dynamic web projects wellversed in numerous programming languages including javascript sql and c strong background in project management and customer relations  highlights  creative design search engine optimization project management servicefocused usability expertise  sharepoint complex problem solver strong decision maker excellent communicator innovative  experience  january 2008 to current freelance new cityland ca web developer  work with senior developer to manage large complex design projects for corporate clients develop project concepts and maintain optimal workflow complete detailed programming and development tasks for front end public and internal websites as well as challenging backend server code collaborate with designers to create clean interfaces and simple intuitive interactions and experiences carry out quality assurance tests to discover errors and optimize usability  april 2005 to december 2007 redstone web design new cityland ca web developer  joined client meetings to learn about development of project scopes contacted clients to obtain more information and discuss design options oversaw scheduling of project milestones and coordinated with clients on any proposed changes or challenges to be overcome specialized in medical and legal websites actively sought tough projects to develop programming and service skills  education  2006 fieldstone university new cityland ca bachelor of science computer information systems  top 5 of class  certifications  java se 7 certified programmer c certified professional programmer clp	\N
7	Mary Key,\nSunnyvalley, CA\n555-555-5555\n\nSUMMARY\n\nWith more that 10 years in web development, motion graphics, A/V production, graphic design, web marketing, IT, and management experience. Within the past 10 years Mr. Ladd has developed the skill of designing and developing websites and graphics from a blank page. His designs are always done with what I consider invaluable input from clientele. Projects have ranged from small mom & pop shops, to mega corporations. Born with a highly developed right and left brain, Mr. Ladd is able to code as well as design. This is proven in the fact that Mr. Ladd is right and left handed. Well versed in meeting milestones of clients within schedule and usually under budget I have proven my worth to companys I have worked for. Projects have included multiple web sites, portals, content management systems, database migrations, flash designs and development with AS. 1.0, and 2.0. & 3.0, Ajax, JS, XML, XHTML, JHTML, FLEX, CSS, etc. Project I have developed are large-scale websites, web banners, custom graphics, A/V production, CMS systems, SEO/SEM. IT maintenance, and network admin. I also have years of experience working direct with clients at all corporate levels including, CEOs, CTO, VPs, IT Directors, Art Directors, etc.\nSKILLS\n\n    Operating Systems: Win 95/98/2000/NT/XP/,.NET, Enterprise Server\n    Languages: C#, VB, VBA, TSQL, ASP.NET, ASP 3.0\n    Databases: SQL Server, MS Access, Oracle\n    Graphic Design: PhotoShop, Illustrator, Quark, 3D MAX\n    Web: Visual Studio 2000/2003/2005, Visual Interdev, Macromedia Products, Photoshop, HTML, AJAX, PHP, XML, FLASH, AS 2.0, 3.0 Web 2.0, CSS, Flex, JHTML\n\nDETAILED EXPERIENCE\n\nContract WorK\n\nFirst National Information NetworK, Burbank, CA. 03/2008 - 06/2998\n\nwww.fnin.com. Worked as webmaster and online marketing developer. Manager PPC, CPC, Adwords, Miva, Affiliate, SEO/SEM. Web dev, Classic ASP, and also worked in the IT area. Optimized websites\n\nwww.Jgoodin.com Brea, CA - IT & Web Developer 01/2008  02/2008\n\nLead IT manager and Web Developer, worked with Active Directory, Web Servers, Remote desktop, SonicWall Routers, MS Server 2003, IIS, VPN, LAN, WAN, Co-locations, ASP.net, Web Services, XML, ASPDOTNETSTOREFRONT, NetSuite, Analylitics, Overstock.com, Commerce Interface. Adobe CS3 suite,\n\nSole Icon, Beverly Hills, CA - Web Developer 01/2008  02/2008\n\nImplemented Shopping cart solutions for company's clientel via Volutions hosted solutions. Setup e commerce backend and fronted, integrated via XML Flash UI with action script 3.0 and added some Flex contols.\n\nMBTRADING - Web Developer 9/2007 to 12/2008\n\nSr. Web Developer, Develop proprietary sites, utilizing ASP, ASP.net, JavaScript, CSS, XML, WC3 standard, etc, also utilized Visual Safe Source.\n\n Website maintenance\n\n Website migration from ASP to ASP.net\n\n Web application development\n\n Team of 5\n\nNorthrop Grumman - Web & Multimedia 6/2007 to 9/2007\n\nWeb developer designer, focusing on front-end design, & hand Coded CSS with relational templates, JavaScript, Flash, ActionScript. 2.0 & 3.0, developing 3d and 2d presentations. XML, DOM, DHTML, XLT, Freehand, Dream Weaver, Illustrator, Fireworks, Photoshop, and various other web design tools.\n\nPower Jam Entertainment  Web & CMS Developer 3/2007 to 6/2007\n\nContract\n\nAs Sr. Web Developer, implemented current flash website with new Ektron content management system (CMS)\n\n    Migrated SQL 2000 to 2005\n    Improved site upload time by thinning flash elements and vector graphics\n    Utilized XML schema and service calls to web services\n    Implemented incorporation of CMS system to Development and Live servers\n    Setup dev SQL 2005 server via IIS 2.0\n    Incorporated WC3 compliant XML and CSS framework\n    Developed in Visual Studio 05, ASP.net\n    Stored procedures\n    ActionScript 2.0 & 3.0\n    Flash game development\n\nMazda USA Corporate, Irvine, CA  Multimedia Developer 11/2005 to 2/2007\n\nI am contracted to administer procedures involved in posting corporate information on intranet and dealer extranet, and eventually redesign current look of intranet and extranet into more consistent brand feel. Utilized flash, and XML for web marketing campaigns. Lastly I was hired to also redesign use of current CMS (content management system).\n\n    Work centered on Interwoven (CMS)\n    XML Spy\n    Flash, AS2\n    Web services etc.\n    Macromedia Suite, etc.\n\nKelly Blue Book, Irvine, CA (contract) 6/2005 to 11/2005\n\nContracted to design and maintain current roster of banner ads. Used Flash MX, and Action Script 2.0 to redesign current list of auto dealer banners, and create new ads for dealers. Ads range from very simple to complex. Company placement of ads varies greatly.\n\n Worked on mass conversion of HTML base banners and converted them to Flash animations via standard formats.\n\n Utilized A.S. 1.0 and standard graphic tools.\n\nMyVideoTalk.com Irvine, CA  Multimedia 2/2005 to6/2005\n\nRedesigned website and hired as a part time consultant to instruct new clients in use of web based video conferencing system. Site is not what it could be because of all the corporate infighting over departmental ownership.www.myvideotalk.com\n\n Complete website redesign\n\n Utilized flash and AS\n\n Utilized Flash Video and Flash video server,\n\n Dynamic video feed using XML and Excel\n\n Utilized Java Script\n\nPacific Improvements, North Hollywood, CA. (recurring) 6/2004 to 1/200 2005\n\nRedesigned company website and incorporated Flash animations and reconstructed navigation and UI, also created Flash ads, banners, coupons, etc. www.pacificimprovements.com\n\n    Website upgrade\n    ASP, ASP.net\n    Flash with AS\n\nAzzizadeh & Ross Law firm, Beverly Hills, CA (recurring) 6/2004\n\nDesigned and implemented law firms website. Installed legal time management and billing software. I instructed officers, and personnel in use of software. www.azrolaw.com HTML\n\n    Website design and implementation\n    Office instruction\n    Legal software document management installation and training.\n\nFULLTIME EMPLOYMENT\n\nSun Mar Healthcare Inc., Brea, CA. 12/2003  10/2004\n\nWeb Developer\n\nDeveloped 21 websites for the companies 21 health care facilities, implemented inviting color scheme, calendar and unique banners for each facility. (see web gallery)\n\n    Developed21 similar sites for each satellite facility HTML\n    Utilized CSS, HTML, Flash, AS 1.0\n	mary key sunnyvalley ca 5555555555  summary  with more that 10 years in web development motion graphics av production graphic design web marketing it and management experience within the past 10 years mr ladd has developed the skill of designing and developing websites and graphics from a blank page his designs are always done with what i consider invaluable input from clientele projects have ranged from small mom  pop shops to mega corporations born with a highly developed right and left brain mr ladd is able to code as well as design this is proven in the fact that mr ladd is right and left handed well versed in meeting milestones of clients within schedule and usually under budget i have proven my worth to companys i have worked for projects have included multiple web sites portals content management systems database migrations flash designs and development with as 10 and 20  30 ajax js xml xhtml jhtml flex css etc project i have developed are largescale websites web banners custom graphics av production cms systems seosem it maintenance and network admin i also have years of experience working direct with clients at all corporate levels including ceos cto vps it directors art directors etc skills      operating systems win 95982000ntxpnet enterprise server     languages c vb vba tsql aspnet asp 30     databases sql server ms access oracle     graphic design photoshop illustrator quark 3d max     web visual studio 200020032005 visual interdev macromedia products photoshop html ajax php xml flash as 20 30 web 20 css flex jhtml  detailed experience  contract work  first national information network burbank ca 032008  062998  wwwfnincom worked as webmaster and online marketing developer manager ppc cpc adwords miva affiliate seosem web dev classic asp and also worked in the it area optimized websites  wwwjgoodincom brea ca  it  web developer 012008  022008  lead it manager and web developer worked with active directory web servers remote desktop sonicwall routers ms server 2003 iis vpn lan wan colocations aspnet web services xml aspdotnetstorefront netsuite analylitics overstockcom commerce interface adobe cs3 suite  sole icon beverly hills ca  web developer 012008  022008  implemented shopping cart solutions for companys clientel via volutions hosted solutions setup e commerce backend and fronted integrated via xml flash ui with action script 30 and added some flex contols  mbtrading  web developer 92007 to 122008  sr web developer develop proprietary sites utilizing asp aspnet javascript css xml wc3 standard etc also utilized visual safe source   website maintenance   website migration from asp to aspnet   web application development   team of 5  northrop grumman  web  multimedia 62007 to 92007  web developer designer focusing on frontend design  hand coded css with relational templates javascript flash actionscript 20  30 developing 3d and 2d presentations xml dom dhtml xlt freehand dream weaver illustrator fireworks photoshop and various other web design tools  power jam entertainment  web  cms developer 32007 to 62007  contract  as sr web developer implemented current flash website with new ektron content management system cms      migrated sql 2000 to 2005     improved site upload time by thinning flash elements and vector graphics     utilized xml schema and service calls to web services     implemented incorporation of cms system to development and live servers     setup dev sql 2005 server via iis 20     incorporated wc3 compliant xml and css framework     developed in visual studio 05 aspnet     stored procedures     actionscript 20  30     flash game development  mazda usa corporate irvine ca  multimedia developer 112005 to 22007  i am contracted to administer procedures involved in posting corporate information on intranet and dealer extranet and eventually redesign current look of intranet and extranet into more consistent brand feel utilized flash and xml for web marketing campaigns lastly i was hired to also redesign use of current cms content management system      work centered on interwoven cms     xml spy     flash as2     web services etc     macromedia suite etc  kelly blue book irvine ca contract 62005 to 112005  contracted to design and maintain current roster of banner ads used flash mx and action script 20 to redesign current list of auto dealer banners and create new ads for dealers ads range from very simple to complex company placement of ads varies greatly   worked on mass conversion of html base banners and converted them to flash animations via standard formats   utilized as 10 and standard graphic tools  myvideotalkcom irvine ca  multimedia 22005 to62005  redesigned website and hired as a part time consultant to instruct new clients in use of web based video conferencing system site is not what it could be because of all the corporate infighting over departmental ownershipwwwmyvideotalkcom   complete website redesign   utilized flash and as   utilized flash video and flash video server   dynamic video feed using xml and excel   utilized java script  pacific improvements north hollywood ca recurring 62004 to 1200 2005  redesigned company website and incorporated flash animations and reconstructed navigation and ui also created flash ads banners coupons etc wwwpacificimprovementscom      website upgrade     asp aspnet     flash with as  azzizadeh  ross law firm beverly hills ca recurring 62004  designed and implemented law firms website installed legal time management and billing software i instructed officers and personnel in use of software wwwazrolawcom html      website design and implementation     office instruction     legal software document management installation and training  fulltime employment  sun mar healthcare inc brea ca 122003  102004  web developer  developed 21 websites for the companies 21 health care facilities implemented inviting color scheme calendar and unique banners for each facility see web gallery      developed21 similar sites for each satellite facility html     utilized css html flash as 10	\N
8	Elsa Birch\nEducation\n\nStanford University\nDoctor of Philosophy (PhD), Chemical Engineering\n2008  2013\nStanford University\nMasters of Science, Chemical Engineering\n2008  2012\nUniversity of Colorado at Boulder\nBachelor of Science, Chemical Engineering, Summa Cum Laude\n2004  2008\nActivities and Societies: Applied Math Minor\nExperience\n\nSenior Associate, Associate\nExponent Failure Analysis Associates\nDecember 2013  December 2015 (2 years 1 month)Menlo Park\nFinding answers to our client's tough technical questions! This includes participation in multidisciplinary teams with specific tasks involving:\n- Rapid technical troubleshooting of appliances, automotive components, etc.\n- Design and execution of testing to evaluate claims of product performance or failure.\n- Report preparation and testimony regarding testing performed.\nGraduate Researcher\nStanford University\nSeptember 2008  November 2013 (5 years 3 months)Palo Alto, California\n- Updated the fundamental assumptions of Flux Balance Analysis metabolic modeling for short time use cases to enable its use in whole cell models.\n- Contributed to single cell hybrid model in Python with Git version control.\n- Developed a computational framework for simulation of bacteriophage Ordinary Differential Equations in the context of bacterial metabolic Flux Balance Analysis. \n- Implemented complex models in Matlab and designed data visualizations in R. \n- Constructed population dynamic models of interacting host and viral communities. \n- Conducted experimental culture and measurement of microbial populations.\nSenior Design Project Team Member\nUniversity of Colorado at Boulder\n2008  2008 (less than a year)Boulder, Colorado\n- Calculated greenhouse gas footprint according to the GHG Protocol.\n- Proposed greenhouse gas footprint reduction strategies: wastewater treatment, solar photovoltaic, solar thermal, and boiler upgrades, presented as full engineering report with economic evaluation.\nUndergraduate Researcher - Nuckolls Lab\nColumbia University\nJune 2007  August 2007 (3 months)\n- Synthesized, purified, and verified structure of organic semiconducting compounds.\nUndergraduate Researcher\nUniversity of Colorado - Hrenya Lab\nAugust 2006  December 2006 (5 months)\n- Wrote Matlab image analysis scripts to track wetted particles across video of their collision.\nEngineering Intern\nTW Environmental\nJune 2006  August 2006 (3 months)Portland, Oregon\n- Designed and implemented database schema and user interface for employee time entry system in Microsoft Access.\n\nInterests\nCooking, Art, Design\nAdvice for Contacting Elsa\nThe most efficient and direct means of contacting me is email to birch@alumni.stanford.edu\nOrganizations\n\nAmerican Institute of Chemical Engineers\nMember\nStarting January 2010\nHonors & Awards\n\nAdditional Honors & Awards\nBioX Fellow Stanford University\nCertifications\n\nHAZOP 40 Hour\nLanguages\n\nEnglish\nVolunteer Experience & Causes\n\nCauses Elsa cares about:\nArts and Culture\nScience and Technology	elsa birch education  stanford university doctor of philosophy phd chemical engineering 2008  2013 stanford university masters of science chemical engineering 2008  2012 university of colorado at boulder bachelor of science chemical engineering summa cum laude 2004  2008 activities and societies applied math minor experience  senior associate associate exponent failure analysis associates december 2013  december 2015 2 years 1 monthmenlo park finding answers to our clients tough technical questions this includes participation in multidisciplinary teams with specific tasks involving  rapid technical troubleshooting of appliances automotive components etc  design and execution of testing to evaluate claims of product performance or failure  report preparation and testimony regarding testing performed graduate researcher stanford university september 2008  november 2013 5 years 3 monthspalo alto california  updated the fundamental assumptions of flux balance analysis metabolic modeling for short time use cases to enable its use in whole cell models  contributed to single cell hybrid model in python with git version control  developed a computational framework for simulation of bacteriophage ordinary differential equations in the context of bacterial metabolic flux balance analysis   implemented complex models in matlab and designed data visualizations in r   constructed population dynamic models of interacting host and viral communities   conducted experimental culture and measurement of microbial populations senior design project team member university of colorado at boulder 2008  2008 less than a yearboulder colorado  calculated greenhouse gas footprint according to the ghg protocol  proposed greenhouse gas footprint reduction strategies wastewater treatment solar photovoltaic solar thermal and boiler upgrades presented as full engineering report with economic evaluation undergraduate researcher  nuckolls lab columbia university june 2007  august 2007 3 months  synthesized purified and verified structure of organic semiconducting compounds undergraduate researcher university of colorado  hrenya lab august 2006  december 2006 5 months  wrote matlab image analysis scripts to track wetted particles across video of their collision engineering intern tw environmental june 2006  august 2006 3 monthsportland oregon  designed and implemented database schema and user interface for employee time entry system in microsoft access  interests cooking art design advice for contacting elsa the most efficient and direct means of contacting me is email to birchalumnistanfordedu organizations  american institute of chemical engineers member starting january 2010 honors  awards  additional honors  awards biox fellow stanford university certifications  hazop 40 hour languages  english volunteer experience  causes  causes elsa cares about arts and culture science and technology	\N
\.


--
-- Name: resumes_resume_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('resumes_resume_id_seq', 8, true);


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY statuses (status_id, status_name) FROM stdin;
1	New
2	Phone Screening
3	Phone Interview
4	Onsite Interview
5	In review
6	Preparing offer
7	Hired
8	Not hired
\.


--
-- Name: statuses_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('statuses_status_id_seq', 8, true);


--
-- Data for Name: tools; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY tools (link_id, link, content) FROM stdin;
1	j70CDueljf	\N
2	nXSx6dSpMx	\N
\.


--
-- Name: tools_link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('tools_link_id_seq', 2, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY users (user_id, first_name, last_name, password, location, email, phone, linkedin, github, "position", salary, resume_id, time_of_submission) FROM stdin;
2	Jay	Smith	$2b$12$wxHeq8.W3mnmJFnRIBfZZ.XHBegVPB7ouNApMbDX42CMDNvcIMgRi	Sometown, NY 11597	js@somedomain.com	425 214 3104	jaysmith	jaysmith	Software Developer	90000	2	2016-02-16 17:21:58.444835
3	Joseph	Gregorio	$2b$12$E6igbLg.03GBB137PPMG4Oiiv8KfeURZEuYsSQSqvKTML9j9Q7im2	1002 Heathwood Dairy Rd Apex, NC 27502	joe@bitworking.org	+14252143104	JosephGregorio	JosephGregorio	SDET	90000	3	2016-02-17 15:58:34.544782
4	Alyson	van Hardenberg	$2b$12$FQE4DD3uCEfeJEQ6efbN9.HcYFKJ2qDFQon3i2k4o4JGvAtWi0ZFG	San Francisco, CA	avanhardenberg@gmail.com	+14252143104	akvanhar	akvanhar	Software Developer	90000	4	2016-02-18 12:26:55.977374
5	Charles	Fulton	$2b$12$sVLKLM4LMy9v1KIHv45hlOuGTxIqSwKlOyzszRjB1ibnzMZ7YrwcS	4059 Farben Way Fort Mill, SC 29715	charliefulton@gmail.com	+14252143104	CharlesFulton	CharlesFulton	SDET	85000	5	2016-02-18 14:48:53.204071
6	Tammy	Mullins	$2b$12$XscNn2vo7NNMpRvPqgqQYOi9jZSe7894193t6HCI1.KxzdLrbGm2.	1 Main Street New Cityland, CA 91010	example-email@example.com	+14252143104			Junior Software Developer	80000	6	2016-02-18 14:54:18.047133
7	Mary	Key	$2b$12$ths8RPSouiYRknFNEDiJve.F9N9t8rJ5C5YQcBKc7O3FaAnMZZMS6	Sunnyvalley, CA	marykey@domain.com	+14252143104	mary-key-13247	maryk	Lead IT manager	150000	7	2016-02-18 14:59:48.776051
8	Elsa	Birch	$2b$12$guDsrE2aOxDSOnD7Q6hm5eEcl98XuiCOpwVTeQMVQ0HysZCQq3DjS	Palo Alto, CA	elsa@somedomain.com	+14252143104	elsa-birch	elsabirch	Software Developer	100000	8	2016-02-23 13:54:45.651753
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('users_user_id_seq', 8, true);


--
-- Name: interviews_pkey; Type: CONSTRAINT; Schema: public; Owner: aliaj; Tablespace: 
--

ALTER TABLE ONLY interviews
    ADD CONSTRAINT interviews_pkey PRIMARY KEY (interview_id);


--
-- Name: openings_pkey; Type: CONSTRAINT; Schema: public; Owner: aliaj; Tablespace: 
--

ALTER TABLE ONLY openings
    ADD CONSTRAINT openings_pkey PRIMARY KEY (opening_id);


--
-- Name: recruiters_pkey; Type: CONSTRAINT; Schema: public; Owner: aliaj; Tablespace: 
--

ALTER TABLE ONLY recruiters
    ADD CONSTRAINT recruiters_pkey PRIMARY KEY (recruiter_id);


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
-- Name: resume_search_idx; Type: INDEX; Schema: public; Owner: aliaj; Tablespace: 
--

CREATE INDEX resume_search_idx ON resumes USING gin (resume_string gin_trgm_ops);


--
-- Name: tsv_idx; Type: INDEX; Schema: public; Owner: aliaj; Tablespace: 
--

CREATE INDEX tsv_idx ON resumes USING gin (tsv);


--
-- Name: interviews_link_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY interviews
    ADD CONSTRAINT interviews_link_id_fkey FOREIGN KEY (link_id) REFERENCES tools(link_id);


--
-- Name: interviews_recruiter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY interviews
    ADD CONSTRAINT interviews_recruiter_id_fkey FOREIGN KEY (recruiter_id) REFERENCES recruiters(recruiter_id);


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
-- Name: users_resume_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_resume_id_fkey FOREIGN KEY (resume_id) REFERENCES resumes(resume_id);


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

