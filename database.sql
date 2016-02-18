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
    opening_name character varying(50) NOT NULL
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
-- Name: openings_opening_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aliaj
--

ALTER SEQUENCE openings_opening_id_seq OWNED BY openings.opening_id;


--
-- Name: recruiters; Type: TABLE; Schema: public; Owner: aliaj; Tablespace: 
--

CREATE TABLE recruiters (
    recruiter_id integer NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    password character varying(20) NOT NULL,
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
    resume_string character varying(500000) NOT NULL
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
    password character varying(20) NOT NULL,
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

ALTER TABLE ONLY openings ALTER COLUMN opening_id SET DEFAULT nextval('openings_opening_id_seq'::regclass);


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
1	2	1	3	\N	2016-02-29 12:00:00
2	3	2	3	\N	2016-02-29 10:00:00
3	4	\N	1	\N	\N
\.


--
-- Name: interviews_interview_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('interviews_interview_id_seq', 3, true);


--
-- Data for Name: openings; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY openings (opening_id, opening_name) FROM stdin;
\.


--
-- Name: openings_opening_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('openings_opening_id_seq', 1, false);


--
-- Data for Name: recruiters; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY recruiters (recruiter_id, first_name, last_name, password, email, title, phone) FROM stdin;
1	Any	Joy	qwerty	hr@hirebright.com	HR Specialist	425 214 3104
2	John	Pumpkin	qwerty	recruter1@gmail.com	Senior Product Manager	425 214 3104
\.


--
-- Name: recruiters_recruiter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('recruiters_recruiter_id_seq', 2, true);


--
-- Data for Name: resumes; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY resumes (resume_id, resume_text, resume_string) FROM stdin;
1	JAY SMITH\n71 Fifth Ave.\nSometown, NY 11597\n555.555.5555\njs@somedomain.com   SENIOR PROGRAMMER\n \n\n    Results-driven lead programmer offering extensive experience within both Fortune 500 and startup environments. SCJP and SCJD certified.\n    Able to incorporate user needs into cost-effective, secure and user-friendly solutions known for scalability and durability.\n    Innovator of next-generation solutions, systems and applications fueling major improvements to the bottom line.\n    Proven leader and project manager; drive system architecture decisions and lead projects from concept through the release process.\n\n \nTechnology\nSummary     \nLanguages/Programming: Java, J2EE, C, C++, Perl, PHP, VB.Net, SQL Server, ASP.Net, HTML, XML, SAP, ActiveX\n\nSystems: AIX, Linux, Unix (Solaris/HP-UX), Windows XP/NT v4.0\n\nNetworking: TCP/IP, SFTP, FTP\n\nDatabases: DB2, Oracle 8/7, Informix, MS Access\n \nProfessional\nExperience  ABC COMPANY -- Sometown, NY\nLead Programmer, 2009 to Present\n\nDevelop, maintain and support application programs for administrative, Web and mobile systems using Java and related tools. Analyze code for system testing and debugging; create test transactions to find, isolate and rectify issues; and manage a team of three programmers. Accomplishments:\n\n    Reengineered multiple systems that fueled improvements to productivity, efficiency, uptime and accuracy for global business operations. Developed code, system design and test/QA plans for all solutions and often coordinated the national or international rollout.\n    Led, architected and participated in the design, testing and deployment of client/server, multitier applications, ActiveX and related components.\n    Developed new procedures for requirements gathering, needs analysis, testing, scripting and documentation to strengthen quality and functionality of business-critical applications.\n    Developed large-scale, portable, thread-safe and ultra-high performance foundation and application infrastructure libraries.\n    Trained and mentored junior programmers in programming methodologies and best practices.\n    Delivered back-office tools supporting ecommerce initiatives, enabling company to compete more effectively in the marketplace through search-engine optimization.\n    Served as a core group member in defining and prioritizing technology investments for the next two years, ensuring the alignment of process, technology and business objectives.\n\nXYZ.COM -- Sometown, NJ\nLead Programmer, 2002 to 2008\n\nLed programming tasks including enhancements, maintenance and support for clients' applications and interfaces. Engineered software products, handling complex analysis and intricate programming to meet project requirements. Accomplishments:\n\n    Led solutions engineering that involved process automation, macro conversion and functionality enhancement. Replaced time-consuming, error-prone manual processes with elegant, automated solutions.\n    Developed and implemented cross-platform, Java-based POS system. Completed project under budget and three weeks ahead of deadline.\n    Coded new solutions that increased availability and scalability by 45% and 75%, respectively.\n\nDEF COMPANY -- Sometown, NJ\nProgrammer II / Programmer I, 2000 to 2002\nHelp Desk Analyst, 1998 to 2000\n\nProgressed through promotions, culminating in responsibility for Web-based application programming within high-volume setting. Became adept in analyzing code for system testing and debugging.\n \nEducation &\nCredentials     ABC UNIVERSITY -- Sometown, NY\nMS in Software Engineering Candidate, 2010 to Present\nCurrent GPA: 3.8 | Expected Graduation: 2012\n\nDEF UNIVERSITY -- Sometown, NJ\nBS in Computer Information Science, 1998\n\nCertifications:\n\n    Sun Certified Java Programmer (SCJP), 2007 \n    Sun Certified Java Developer (SCJD), 2008\n\nRecent Seminars:\n\n    Enterprise Java Development\n    C++ Programming: Concepts, Design and Implementation\n    Windows Programming Using Visual C++\n    Advanced Workshop in Object-Oriented Analysis and Design\n    Project Lifecycle and Project Management Master Class\n    Project Management Methods\n\nVolunteerism    Little League Coach (Sometown, NY), 2009 to Present\nPTA Secretary (Sometown Elementary School), 2010 to Present\nActive Volunteer, Special Olympics, 2008 to Present\n  Available for Relocation  \n	jay smith 71 fifth ave sometown ny 11597 5555555555 jssomedomaincom   senior programmer        resultsdriven lead programmer offering extensive experience within both fortune 500 and startup environments scjp and scjd certified     able to incorporate user needs into costeffective secure and userfriendly solutions known for scalability and durability     innovator of nextgeneration solutions systems and applications fueling major improvements to the bottom line     proven leader and project manager drive system architecture decisions and lead projects from concept through the release process    technology summary      languagesprogramming java j2ee c c perl php vbnet sql server aspnet html xml sap activex  systems aix linux unix solarishpux windows xpnt v40  networking tcpip sftp ftp  databases db2 oracle 87 informix ms access   professional experience  abc company  sometown ny lead programmer 2009 to present  develop maintain and support application programs for administrative web and mobile systems using java and related tools analyze code for system testing and debugging create test transactions to find isolate and rectify issues and manage a team of three programmers accomplishments      reengineered multiple systems that fueled improvements to productivity efficiency uptime and accuracy for global business operations developed code system design and testqa plans for all solutions and often coordinated the national or international rollout     led architected and participated in the design testing and deployment of clientserver multitier applications activex and related components     developed new procedures for requirements gathering needs analysis testing scripting and documentation to strengthen quality and functionality of businesscritical applications     developed largescale portable threadsafe and ultrahigh performance foundation and application infrastructure libraries     trained and mentored junior programmers in programming methodologies and best practices     delivered backoffice tools supporting ecommerce initiatives enabling company to compete more effectively in the marketplace through searchengine optimization     served as a core group member in defining and prioritizing technology investments for the next two years ensuring the alignment of process technology and business objectives  xyzcom  sometown nj lead programmer 2002 to 2008  led programming tasks including enhancements maintenance and support for clients applications and interfaces engineered software products handling complex analysis and intricate programming to meet project requirements accomplishments      led solutions engineering that involved process automation macro conversion and functionality enhancement replaced timeconsuming errorprone manual processes with elegant automated solutions     developed and implemented crossplatform javabased pos system completed project under budget and three weeks ahead of deadline     coded new solutions that increased availability and scalability by 45 and 75 respectively  def company  sometown nj programmer ii  programmer i 2000 to 2002 help desk analyst 1998 to 2000  progressed through promotions culminating in responsibility for webbased application programming within highvolume setting became adept in analyzing code for system testing and debugging   education  credentials     abc university  sometown ny ms in software engineering candidate 2010 to present current gpa 38  expected graduation 2012  def university  sometown nj bs in computer information science 1998  certifications      sun certified java programmer scjp 2007      sun certified java developer scjd 2008  recent seminars      enterprise java development     c programming concepts design and implementation     windows programming using visual c     advanced workshop in objectoriented analysis and design     project lifecycle and project management master class     project management methods  volunteerism    little league coach sometown ny 2009 to present pta secretary sometown elementary school 2010 to present active volunteer special olympics 2008 to present   available for relocation
2	JAY SMITH\n71 Fifth Ave.\nSometown, NY 11597\n555.555.5555\njs@somedomain.com   SENIOR PROGRAMMER\n \n\n    Results-driven lead programmer offering extensive experience within both Fortune 500 and startup environments. SCJP and SCJD certified.\n    Able to incorporate user needs into cost-effective, secure and user-friendly solutions known for scalability and durability.\n    Innovator of next-generation solutions, systems and applications fueling major improvements to the bottom line.\n    Proven leader and project manager; drive system architecture decisions and lead projects from concept through the release process.\n\n \nTechnology\nSummary     \nLanguages/Programming: Java, J2EE, C, C++, Perl, PHP, VB.Net, SQL Server, ASP.Net, HTML, XML, SAP, ActiveX\n\nSystems: AIX, Linux, Unix (Solaris/HP-UX), Windows XP/NT v4.0\n\nNetworking: TCP/IP, SFTP, FTP\n\nDatabases: DB2, Oracle 8/7, Informix, MS Access\n \nProfessional\nExperience  ABC COMPANY -- Sometown, NY\nLead Programmer, 2009 to Present\n\nDevelop, maintain and support application programs for administrative, Web and mobile systems using Java and related tools. Analyze code for system testing and debugging; create test transactions to find, isolate and rectify issues; and manage a team of three programmers. Accomplishments:\n\n    Reengineered multiple systems that fueled improvements to productivity, efficiency, uptime and accuracy for global business operations. Developed code, system design and test/QA plans for all solutions and often coordinated the national or international rollout.\n    Led, architected and participated in the design, testing and deployment of client/server, multitier applications, ActiveX and related components.\n    Developed new procedures for requirements gathering, needs analysis, testing, scripting and documentation to strengthen quality and functionality of business-critical applications.\n    Developed large-scale, portable, thread-safe and ultra-high performance foundation and application infrastructure libraries.\n    Trained and mentored junior programmers in programming methodologies and best practices.\n    Delivered back-office tools supporting ecommerce initiatives, enabling company to compete more effectively in the marketplace through search-engine optimization.\n    Served as a core group member in defining and prioritizing technology investments for the next two years, ensuring the alignment of process, technology and business objectives.\n\nXYZ.COM -- Sometown, NJ\nLead Programmer, 2002 to 2008\n\nLed programming tasks including enhancements, maintenance and support for clients' applications and interfaces. Engineered software products, handling complex analysis and intricate programming to meet project requirements. Accomplishments:\n\n    Led solutions engineering that involved process automation, macro conversion and functionality enhancement. Replaced time-consuming, error-prone manual processes with elegant, automated solutions.\n    Developed and implemented cross-platform, Java-based POS system. Completed project under budget and three weeks ahead of deadline.\n    Coded new solutions that increased availability and scalability by 45% and 75%, respectively.\n\nDEF COMPANY -- Sometown, NJ\nProgrammer II / Programmer I, 2000 to 2002\nHelp Desk Analyst, 1998 to 2000\n\nProgressed through promotions, culminating in responsibility for Web-based application programming within high-volume setting. Became adept in analyzing code for system testing and debugging.\n \nEducation &\nCredentials     ABC UNIVERSITY -- Sometown, NY\nMS in Software Engineering Candidate, 2010 to Present\nCurrent GPA: 3.8 | Expected Graduation: 2012\n\nDEF UNIVERSITY -- Sometown, NJ\nBS in Computer Information Science, 1998\n\nCertifications:\n\n    Sun Certified Java Programmer (SCJP), 2007 \n    Sun Certified Java Developer (SCJD), 2008\n\nRecent Seminars:\n\n    Enterprise Java Development\n    C++ Programming: Concepts, Design and Implementation\n    Windows Programming Using Visual C++\n    Advanced Workshop in Object-Oriented Analysis and Design\n    Project Lifecycle and Project Management Master Class\n    Project Management Methods\n\nVolunteerism    Little League Coach (Sometown, NY), 2009 to Present\nPTA Secretary (Sometown Elementary School), 2010 to Present\nActive Volunteer, Special Olympics, 2008 to Present\n  Available for Relocation  \n	jay smith 71 fifth ave sometown ny 11597 5555555555 jssomedomaincom   senior programmer        resultsdriven lead programmer offering extensive experience within both fortune 500 and startup environments scjp and scjd certified     able to incorporate user needs into costeffective secure and userfriendly solutions known for scalability and durability     innovator of nextgeneration solutions systems and applications fueling major improvements to the bottom line     proven leader and project manager drive system architecture decisions and lead projects from concept through the release process    technology summary      languagesprogramming java j2ee c c perl php vbnet sql server aspnet html xml sap activex  systems aix linux unix solarishpux windows xpnt v40  networking tcpip sftp ftp  databases db2 oracle 87 informix ms access   professional experience  abc company  sometown ny lead programmer 2009 to present  develop maintain and support application programs for administrative web and mobile systems using java and related tools analyze code for system testing and debugging create test transactions to find isolate and rectify issues and manage a team of three programmers accomplishments      reengineered multiple systems that fueled improvements to productivity efficiency uptime and accuracy for global business operations developed code system design and testqa plans for all solutions and often coordinated the national or international rollout     led architected and participated in the design testing and deployment of clientserver multitier applications activex and related components     developed new procedures for requirements gathering needs analysis testing scripting and documentation to strengthen quality and functionality of businesscritical applications     developed largescale portable threadsafe and ultrahigh performance foundation and application infrastructure libraries     trained and mentored junior programmers in programming methodologies and best practices     delivered backoffice tools supporting ecommerce initiatives enabling company to compete more effectively in the marketplace through searchengine optimization     served as a core group member in defining and prioritizing technology investments for the next two years ensuring the alignment of process technology and business objectives  xyzcom  sometown nj lead programmer 2002 to 2008  led programming tasks including enhancements maintenance and support for clients applications and interfaces engineered software products handling complex analysis and intricate programming to meet project requirements accomplishments      led solutions engineering that involved process automation macro conversion and functionality enhancement replaced timeconsuming errorprone manual processes with elegant automated solutions     developed and implemented crossplatform javabased pos system completed project under budget and three weeks ahead of deadline     coded new solutions that increased availability and scalability by 45 and 75 respectively  def company  sometown nj programmer ii  programmer i 2000 to 2002 help desk analyst 1998 to 2000  progressed through promotions culminating in responsibility for webbased application programming within highvolume setting became adept in analyzing code for system testing and debugging   education  credentials     abc university  sometown ny ms in software engineering candidate 2010 to present current gpa 38  expected graduation 2012  def university  sometown nj bs in computer information science 1998  certifications      sun certified java programmer scjp 2007      sun certified java developer scjd 2008  recent seminars      enterprise java development     c programming concepts design and implementation     windows programming using visual c     advanced workshop in objectoriented analysis and design     project lifecycle and project management master class     project management methods  volunteerism    little league coach sometown ny 2009 to present pta secretary sometown elementary school 2010 to present active volunteer special olympics 2008 to present   available for relocation
3	10 0 2  H e at h w o o d  D air y R d A p ex, N C  2 75 0 2\n\nJoseph Gregorio\n\nP h o n e: ( 9 19) 2 7 2 3 76 4 joe @ bit working.org\n\nObjective Employment where I can apply 14 years of experience designing and delivering  software across a wide range of platforms to make customers happy.\n\nProfessional Profile Software engineer with a record of success in designing, building and shipping Web,  Windows and embedded firmware applications on time and on budget. Works easily  across departments to bring new solutions on line and new products to market. A  passion for creating software and protocols that extends beyond a fulltime job and  into publication and membership in working groups.\n\nSkills\nS kill N a m e C/C++ X M L  a n d  relate d tech n ologies (X SLT, S V G , etc) W e b  Tech n ologies (H T TP, C GI, T F TP, etc.) Python Linux W i n 3 2  Pr o gra m m i ng  ( Win do w s  9 5/98/ N T/X P) Perl\n\nExperience 14  ye ars 7 years 7 years 5 years 7 years 14  ye ars 4 years\n\nAccomplishments\nIndependent of my fulltime day job\n Member of the IETF AtomPub Working Group o CoEditor of the Atom Publishing Protocol, a REST based protocol that takes  much of it's basic structure from RESTlog, a REST based weblog editing  protocol that I developed in 2002. o Contributor to the Atom Syndication Format.\n Author o A regular column for XML.com, "The RESTful Web". o Chapters in two O'Reilly Hacks books, "Greasemonkey Hacks", the other not  yet published. o B  itWorking.org , a popular technology weblog maintained over the past four  years.\n Open Source  o  Aggie   The first desktop news aggregator written for .NET. The RSS parsing  engine of Aggie was used in early releases of NewsGator. o  Python modules  to make developing RESTful web services easier. o S  ecure Syndication   A Greasemonkey script for decrypting syndicated  content in a web browser. \n Conferences o Presented "Secure Syndication" at Etech 2006\n\n\fo Presented "The Atom Publishing Protocol" at XML 2005 o Presented "The Atom Publishing Protocol" at XML 2004 o Presented "Extending HTTP Authentication" at ApacheCon 2003\nDuring the last four years at SAMSys, Inc.\n Developed parts of the software architecture for the next generation product.  Designed and implemented: o The embedded scripting language for the new product. o An automated build system that compiled and ran all unit tests on an hourly  basis. All reports were web based and failures were reported via email. o An automated system that processed wiki markup that described the data  model and produced, via Python and XSLT, a series of C, Java, .Net and HTML  files. o Championed the use of scripting languages in the software development  process to simulate new product components to speed product development.\n Created a fast scripting engine based architecture for embedded system development.  This architecture was adopted across all product lines.\n Wrote a Web server, SOAP server, SOAP client, and Telnet server. All of these services  plus RFID specific hardware interfaces all ran on a 25MHz 386 with 512KB of RAM.\n Introduced wikis and Subversion into the software group.  Introduced unit testing to the software engineering department.\no The 386based system mentioned previously had over 800 unit tests.  Created a webbased interface to an internal administrative database to allow remote \nemployees to update sales records remotely.  Provided sales support:\no Created Windows based demonstration applications for use at trade shows on  very short notice.\no Created/ordered/assembled/installed mechanical designs for trade show  systems.\no Worked directly with customers to determine their system integration needs. o Created software development kits and sample code.\nDuring 7 years at MTS\n Project Lead for a Windows 95/98/NT statistical analysis software project.  o Completed on time and within budget o Shipped with a manual and context sensitive help. o First software product from the division to use the Standard Template Library. o Included an interpreted language for statistical analysis.\n Software Architect for a Windows 95/98/NT software project which was a complete  rewrite of MTS's best selling material testing software package. o Created an architecture so flexible and easily tailored that writing customized  software applications was no longer needed within the division. o Created a fast and flexible file format. Developed a file editor and repair  utilities for the new file format. o Created a flexible object loading scheme. o Helped research and develop the use of RTF for report generation. o First product from the division to include an interpreted language for  machine control and data analysis.\n Project Lead for a CE compliant Universal Serial Bus (USB) interface device. \n\n\fo The project was on time, on budget and below cost. o This project was the first USB product developed by MTS Systems \nCorporation.  Designed and implemented a GUI class library used across the division.\n Introduced version control software to the MTDRaleigh division for both software  source code and engineering drawings.\n Introduced coding standards, code reviews and semiformal User Interface Design \nmethodologies to the MTDRaleigh division.  Started technical magazine subscriptions for the software engineers.  Initiated and ran weekly minitraining classes on C++ and objectoriented \nprogramming.\n\nEmployment History\n\nSAMSys Employment: October 2001Present\n\nResponsibilities: Designed, coded, tested and documented software for RFID readers and \n\ntheir  associated support applications. Platforms included DSPs, microcontrollers, Windows \n\nmachines and Linux based devices. Helped develop the software architecture for the RFID \n\nreaders including the design of two embedded languages. Added Web, SOAP and other IP \n\nbased interface support to products. Researched and tested new tools, techniques and \n\ntechnologies to bring into the department, such as unit testing, wikis, Python, and \n\nSubversion. Created software development kits and sample code for end users.\n\nMTS \n\nDivision:\n\nMTDRaleigh\n\nEmployment:  September 1994August 2001  \n\nResponsibilities:  Active lead on projects to produce firmware and Windows application \n\nsoftware. Many projects had electrical engineering and mechanical engineering components. \n\nResponsibilities for the projects included designing the product architecture, writing code, \n\ndebugging, calling design reviews, and reporting the project status to the management team. \n\nResponsible for researching new tools, techniques and technologies to bring into the \n\ndepartment. Managed the IT department of three fulltime employees.\n\nTecan U.S. Employment:  July 1992 September 1994 \n\nResponsibilities:  Met with customers to assess their software needs. Designed embedded or \n\nWindows based software solutions, coded, tested, documented, and maintained software and \n\nprovided customer training. \n\nEducation\nDartmouth College  Masters of Arts in Mathematics, 1992.\nEastern Connecticut State University  Bachelors of Science in Mathematics, 1989, 3.76 GPA. Bachelors of Science in Computer Science, 1989, 3.76 GPA.\n\nClasses\nBiomathematics Class BMA567, North Carolina State University, Fall, 1999. Fred Pryor Seminar, "How to Supervise People", Dec 12, 1997. Software Engineering Class CSC510, North Carolina State University, Fall, 1994.\n\n\f	10 0 2  h e at h w o o d  d air y r d a p ex n c  2 75 0 2  joseph gregorio  p h o n e  9 19 2 7 2 3 76 4 joe  bit workingorg  objective employment where i can apply 14 years of experience designing and delivering  software across a wide range of platforms to make customers happy  professional profile software engineer with a record of success in designing building and shipping web  windows and embedded firmware applications on time and on budget works easily  across departments to bring new solutions on line and new products to market a  passion for creating software and protocols that extends beyond a fulltime job and  into publication and membership in working groups  skills s kill n a m e cc x m l  a n d  relate d tech n ologies x slt s v g  etc w e b  tech n ologies h t tp c gi t f tp etc python linux w i n 3 2  pr o gra m m i ng   win do w s  9 598 n tx p perl  experience 14  ye ars 7 years 7 years 5 years 7 years 14  ye ars 4 years  accomplishments independent of my fulltime day job  member of the ietf atompub working group o coeditor of the atom publishing protocol a rest based protocol that takes  much of its basic structure from restlog a rest based weblog editing  protocol that i developed in 2002 o contributor to the atom syndication format  author o a regular column for xmlcom the restful web o chapters in two oreilly hacks books greasemonkey hacks the other not  yet published o b  itworkingorg  a popular technology weblog maintained over the past four  years  open source  o  aggie   the first desktop news aggregator written for net the rss parsing  engine of aggie was used in early releases of newsgator o  python modules  to make developing restful web services easier o s  ecure syndication   a greasemonkey script for decrypting syndicated  content in a web browser   conferences o presented secure syndication at etech 2006  \fo presented the atom publishing protocol at xml 2005 o presented the atom publishing protocol at xml 2004 o presented extending http authentication at apachecon 2003 during the last four years at samsys inc  developed parts of the software architecture for the next generation product  designed and implemented o the embedded scripting language for the new product o an automated build system that compiled and ran all unit tests on an hourly  basis all reports were web based and failures were reported via email o an automated system that processed wiki markup that described the data  model and produced via python and xslt a series of c java net and html  files o championed the use of scripting languages in the software development  process to simulate new product components to speed product development  created a fast scripting engine based architecture for embedded system development  this architecture was adopted across all product lines  wrote a web server soap server soap client and telnet server all of these services  plus rfid specific hardware interfaces all ran on a 25mhz 386 with 512kb of ram  introduced wikis and subversion into the software group  introduced unit testing to the software engineering department o the 386based system mentioned previously had over 800 unit tests  created a webbased interface to an internal administrative database to allow remote  employees to update sales records remotely  provided sales support o created windows based demonstration applications for use at trade shows on  very short notice o createdorderedassembledinstalled mechanical designs for trade show  systems o worked directly with customers to determine their system integration needs o created software development kits and sample code during 7 years at mts  project lead for a windows 9598nt statistical analysis software project  o completed on time and within budget o shipped with a manual and context sensitive help o first software product from the division to use the standard template library o included an interpreted language for statistical analysis  software architect for a windows 9598nt software project which was a complete  rewrite of mtss best selling material testing software package o created an architecture so flexible and easily tailored that writing customized  software applications was no longer needed within the division o created a fast and flexible file format developed a file editor and repair  utilities for the new file format o created a flexible object loading scheme o helped research and develop the use of rtf for report generation o first product from the division to include an interpreted language for  machine control and data analysis  project lead for a ce compliant universal serial bus usb interface device   \fo the project was on time on budget and below cost o this project was the first usb product developed by mts systems  corporation  designed and implemented a gui class library used across the division  introduced version control software to the mtdraleigh division for both software  source code and engineering drawings  introduced coding standards code reviews and semiformal user interface design  methodologies to the mtdraleigh division  started technical magazine subscriptions for the software engineers  initiated and ran weekly minitraining classes on c and objectoriented  programming  employment history  samsys employment october 2001present  responsibilities designed coded tested and documented software for rfid readers and   their  associated support applications platforms included dsps microcontrollers windows   machines and linux based devices helped develop the software architecture for the rfid   readers including the design of two embedded languages added web soap and other ip   based interface support to products researched and tested new tools techniques and   technologies to bring into the department such as unit testing wikis python and   subversion created software development kits and sample code for end users  mts   division  mtdraleigh  employment  september 1994august 2001    responsibilities  active lead on projects to produce firmware and windows application   software many projects had electrical engineering and mechanical engineering components   responsibilities for the projects included designing the product architecture writing code   debugging calling design reviews and reporting the project status to the management team   responsible for researching new tools techniques and technologies to bring into the   department managed the it department of three fulltime employees  tecan us employment  july 1992 september 1994   responsibilities  met with customers to assess their software needs designed embedded or   windows based software solutions coded tested documented and maintained software and   provided customer training   education dartmouth college  masters of arts in mathematics 1992 eastern connecticut state university  bachelors of science in mathematics 1989 376 gpa bachelors of science in computer science 1989 376 gpa  classes biomathematics class bma567 north carolina state university fall 1999 fred pryor seminar how to supervise people dec 12 1997 software engineering class csc510 north carolina state university fall 1994
4	Alyson van Hardenberg\navanhardenberg@gmail.com (415) 216-9086 www.linkedin.com/in/akvanhar @akvanh \nQualifications Summary\nTechnical skills span Python, Flask, Javascript, jQuery, AJAX, SQLite, SQLAlchemy, Google Maps API, Facebook Graph API, Twilio API, HTML/CSS, Twitter Bootstrap and Python unittest. With my experience in nursing/healthcare, I bring to software engineering experience in problem solving in a fast paced, technical environment where team-work is very important.\nProjects (& Affiliations)\n Make Less Mush: https://github.com/akvanhar/HB-FinalProject\n Make Less Mush is a full-stack web application that provides parents with a social-\nmedia based baby food sharing/messaging service.\n Ratings: https://github.com/akvanhar/HB-ratings\n A web app that allows users to rate films, and predicts how they will rate films. This prediction is based on an analysis of how other similar users have rated the film.\n Member of: Bay Area Girl Geek Dinner, Women Who Code: SF, PyLadies of San Francisco\nExperience\nMaxim Healthcare Services, Registered Nurse Mar 2014-present\n Supported students with their healthcare needs during the school day.\n Helped run health clinics in office settings. Checked blood pressure, cholesterol, HgA1C.\nProvided personalized health advice to clients during face-paced 15 minute sessions.\n826 Valencia, Volunteer 2013-2014\n After school tutor for school aged children in the Mission neighborhood in San Francisco.\nDoula Seminars, Volunteer 2013-2014  With an interdisciplinary team, offered doula services using a harm reduction approach to\nsubstance-using women, substance-exposed newborns and new immigrants without insurance.\nSelf-employed, Birth and Postpartum Doula 2009-2014  Provided prenatal, birth and postpartum doula care.\nVictoria School District, Educational Assistant 2007 - 2010  Supported students with various special needs and learning challenges from grades 6 - 12.\nEducation\nHackbright Academy, Software Engineer Immersive Program for Women 2015 University of British Columbia, B.S. Nursing 2012 University of Victoria, B.A. Human and Social Development 2008	alyson van hardenberg avanhardenberggmailcom 415 2169086 wwwlinkedincominakvanhar akvanh  qualifications summary technical skills span python flask javascript jquery ajax sqlite sqlalchemy google maps api facebook graph api twilio api htmlcss twitter bootstrap and python unittest with my experience in nursinghealthcare i bring to software engineering experience in problem solving in a fast paced technical environment where teamwork is very important projects  affiliations  make less mush httpsgithubcomakvanharhbfinalproject  make less mush is a fullstack web application that provides parents with a social media based baby food sharingmessaging service  ratings httpsgithubcomakvanharhbratings  a web app that allows users to rate films and predicts how they will rate films this prediction is based on an analysis of how other similar users have rated the film  member of bay area girl geek dinner women who code sf pyladies of san francisco experience maxim healthcare services registered nurse mar 2014present  supported students with their healthcare needs during the school day  helped run health clinics in office settings checked blood pressure cholesterol hga1c provided personalized health advice to clients during facepaced 15 minute sessions 826 valencia volunteer 20132014  after school tutor for school aged children in the mission neighborhood in san francisco doula seminars volunteer 20132014  with an interdisciplinary team offered doula services using a harm reduction approach to substanceusing women substanceexposed newborns and new immigrants without insurance selfemployed birth and postpartum doula 20092014  provided prenatal birth and postpartum doula care victoria school district educational assistant 2007  2010  supported students with various special needs and learning challenges from grades 6  12 education hackbright academy software engineer immersive program for women 2015 university of british columbia bs nursing 2012 university of victoria ba human and social development 2008
\.


--
-- Name: resumes_resume_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('resumes_resume_id_seq', 4, true);


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
\.


--
-- Name: tools_link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('tools_link_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: aliaj
--

COPY users (user_id, first_name, last_name, password, location, email, phone, linkedin, github, "position", salary, resume_id, time_of_submission) FROM stdin;
2	Jay	Smith	qwerty	Sometown, NY 11597	js@somedomain.com	425 214 3104	jaysmith	jaysmith	Software Developer	90000	2	2016-02-16 17:21:58.444835
3	Joseph	Gregorio	qwerty	1002 Heathwood Dairy Rd Apex, NC 27502	joe@bitworking.org	+14252143104	JosephGregorio	JosephGregorio	SDET	90000	3	2016-02-17 15:58:34.544782
4	Alyson	van Hardenberg	qwerty	San Francisco, CA	avanhardenberg@gmail.com	+14252143104	akvanhar	akvanhar	Software Developer	90000	4	2016-02-18 12:26:55.977374
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('users_user_id_seq', 4, true);


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

