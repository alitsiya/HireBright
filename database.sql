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
    resume_text character varying(50000) NOT NULL,
    resume_string character varying(50000) NOT NULL
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
2	2	\N	1	\N	\N
3	3	\N	1	\N	\N
4	4	\N	1	\N	\N
\.


--
-- Name: interviews_interview_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('interviews_interview_id_seq', 5, true);


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

COPY resumes (resume_id, resume_text, resume_string) FROM stdin;
2	JAY SMITH<br>71 Fifth Ave.<br>Sometown, NY 11597<br>555.555.5555<br>js@somedomain.com   SENIOR PROGRAMMER<br> <br><br>    Results-driven lead programmer offering extensive experience within both Fortune 500 and startup environments. SCJP and SCJD certified.<br>    Able to incorporate user needs into cost-effective, secure and user-friendly solutions known for scalability and durability.<br>    Innovator of next-generation solutions, systems and applications fueling major improvements to the bottom line.<br>    Proven leader and project manager; drive system architecture decisions and lead projects from concept through the release process.<br><br> <br>Technology<br>Summary     <br>Languages/Programming: Java, J2EE, C, C++, Perl, PHP, VB.Net, SQL Server, ASP.Net, HTML, XML, SAP, ActiveX<br><br>Systems: AIX, Linux, Unix (Solaris/HP-UX), Windows XP/NT v4.0<br><br>Networking: TCP/IP, SFTP, FTP<br><br>Databases: DB2, Oracle 8/7, Informix, MS Access<br> <br>Professional<br>Experience  ABC COMPANY -- Sometown, NY<br>Lead Programmer, 2009 to Present<br><br>Develop, maintain and support application programs for administrative, Web and mobile systems using Java and related tools. Analyze code for system testing and debugging; create test transactions to find, isolate and rectify issues; and manage a team of three programmers. Accomplishments:<br><br>    Reengineered multiple systems that fueled improvements to productivity, efficiency, uptime and accuracy for global business operations. Developed code, system design and test/QA plans for all solutions and often coordinated the national or international rollout.<br>    Led, architected and participated in the design, testing and deployment of client/server, multitier applications, ActiveX and related components.<br>    Developed new procedures for requirements gathering, needs analysis, testing, scripting and documentation to strengthen quality and functionality of business-critical applications.<br>    Developed large-scale, portable, thread-safe and ultra-high performance foundation and application infrastructure libraries.<br>    Trained and mentored junior programmers in programming methodologies and best practices.<br>    Delivered back-office tools supporting ecommerce initiatives, enabling company to compete more effectively in the marketplace through search-engine optimization.<br>    Served as a core group member in defining and prioritizing technology investments for the next two years, ensuring the alignment of process, technology and business objectives.<br><br>XYZ.COM -- Sometown, NJ<br>Lead Programmer, 2002 to 2008<br><br>Led programming tasks including enhancements, maintenance and support for clients' applications and interfaces. Engineered software products, handling complex analysis and intricate programming to meet project requirements. Accomplishments:<br><br>    Led solutions engineering that involved process automation, macro conversion and functionality enhancement. Replaced time-consuming, error-prone manual processes with elegant, automated solutions.<br>    Developed and implemented cross-platform, Java-based POS system. Completed project under budget and three weeks ahead of deadline.<br>    Coded new solutions that increased availability and scalability by 45% and 75%, respectively.<br><br>DEF COMPANY -- Sometown, NJ<br>Programmer II / Programmer I, 2000 to 2002<br>Help Desk Analyst, 1998 to 2000<br><br>Progressed through promotions, culminating in responsibility for Web-based application programming within high-volume setting. Became adept in analyzing code for system testing and debugging.<br> <br>Education &<br>Credentials     ABC UNIVERSITY -- Sometown, NY<br>MS in Software Engineering Candidate, 2010 to Present<br>Current GPA: 3.8 | Expected Graduation: 2012<br><br>DEF UNIVERSITY -- Sometown, NJ<br>BS in Computer Information Science, 1998<br><br>Certifications:<br><br>    Sun Certified Java Programmer (SCJP), 2007 <br>    Sun Certified Java Developer (SCJD), 2008<br><br>Recent Seminars:<br><br>    Enterprise Java Development<br>    C++ Programming: Concepts, Design and Implementation<br>    Windows Programming Using Visual C++<br>    Advanced Workshop in Object-Oriented Analysis and Design<br>    Project Lifecycle and Project Management Master Class<br>    Project Management Methods<br><br>Volunteerism    Little League Coach (Sometown, NY), 2009 to Present<br>PTA Secretary (Sometown Elementary School), 2010 to Present<br>Active Volunteer, Special Olympics, 2008 to Present<br>  Available for Relocation  <br>	jay smithbr71 fifth avebrsometown ny 11597br5555555555brjssomedomaincom   senior programmerbr brbr    resultsdriven lead programmer offering extensive experience within both fortune 500 and startup environments scjp and scjd certifiedbr    able to incorporate user needs into costeffective secure and userfriendly solutions known for scalability and durabilitybr    innovator of nextgeneration solutions systems and applications fueling major improvements to the bottom linebr    proven leader and project manager drive system architecture decisions and lead projects from concept through the release processbrbr brtechnologybrsummary     brlanguagesprogramming java j2ee c c perl php vbnet sql server aspnet html xml sap activexbrbrsystems aix linux unix solarishpux windows xpnt v40brbrnetworking tcpip sftp ftpbrbrdatabases db2 oracle 87 informix ms accessbr brprofessionalbrexperience  abc company  sometown nybrlead programmer 2009 to presentbrbrdevelop maintain and support application programs for administrative web and mobile systems using java and related tools analyze code for system testing and debugging create test transactions to find isolate and rectify issues and manage a team of three programmers accomplishmentsbrbr    reengineered multiple systems that fueled improvements to productivity efficiency uptime and accuracy for global business operations developed code system design and testqa plans for all solutions and often coordinated the national or international rolloutbr    led architected and participated in the design testing and deployment of clientserver multitier applications activex and related componentsbr    developed new procedures for requirements gathering needs analysis testing scripting and documentation to strengthen quality and functionality of businesscritical applicationsbr    developed largescale portable threadsafe and ultrahigh performance foundation and application infrastructure librariesbr    trained and mentored junior programmers in programming methodologies and best practicesbr    delivered backoffice tools supporting ecommerce initiatives enabling company to compete more effectively in the marketplace through searchengine optimizationbr    served as a core group member in defining and prioritizing technology investments for the next two years ensuring the alignment of process technology and business objectivesbrbrxyzcom  sometown njbrlead programmer 2002 to 2008brbrled programming tasks including enhancements maintenance and support for clients applications and interfaces engineered software products handling complex analysis and intricate programming to meet project requirements accomplishmentsbrbr    led solutions engineering that involved process automation macro conversion and functionality enhancement replaced timeconsuming errorprone manual processes with elegant automated solutionsbr    developed and implemented crossplatform javabased pos system completed project under budget and three weeks ahead of deadlinebr    coded new solutions that increased availability and scalability by 45 and 75 respectivelybrbrdef company  sometown njbrprogrammer ii  programmer i 2000 to 2002brhelp desk analyst 1998 to 2000brbrprogressed through promotions culminating in responsibility for webbased application programming within highvolume setting became adept in analyzing code for system testing and debuggingbr breducation brcredentials     abc university  sometown nybrms in software engineering candidate 2010 to presentbrcurrent gpa 38  expected graduation 2012brbrdef university  sometown njbrbs in computer information science 1998brbrcertificationsbrbr    sun certified java programmer scjp 2007 br    sun certified java developer scjd 2008brbrrecent seminarsbrbr    enterprise java developmentbr    c programming concepts design and implementationbr    windows programming using visual cbr    advanced workshop in objectoriented analysis and designbr    project lifecycle and project management master classbr    project management methodsbrbrvolunteerism    little league coach sometown ny 2009 to presentbrpta secretary sometown elementary school 2010 to presentbractive volunteer special olympics 2008 to presentbr  available for relocation  br
3	Mary Key,<br>Sunnyvalley, CA<br>555-555-5555<br><br>SUMMARY<br><br>With more that 10 years in web development, motion graphics, A/V production, graphic design, web marketing, IT, and management experience. Within the past 10 years Mr. Ladd has developed the skill of designing and developing websites and graphics from a blank page. His designs are always done with what I consider invaluable input from clientele. Projects have ranged from small mom & pop shops, to mega corporations. Born with a highly developed right and left brain, Mr. Ladd is able to code as well as design. This is proven in the fact that Mr. Ladd is right and left handed. Well versed in meeting milestones of clients within schedule and usually under budget I have proven my worth to companys I have worked for. Projects have included multiple web sites, portals, content management systems, database migrations, flash designs and development with AS. 1.0, and 2.0. & 3.0, Ajax, JS, XML, XHTML, JHTML, FLEX, CSS, etc. Project I have developed are large-scale websites, web banners, custom graphics, A/V production, CMS systems, SEO/SEM. IT maintenance, and network admin. I also have years of experience working direct with clients at all corporate levels including, CEOs, CTO, VPs, IT Directors, Art Directors, etc.<br>SKILLS<br><br>    Operating Systems: Win 95/98/2000/NT/XP/,.NET, Enterprise Server<br>    Languages: C#, VB, VBA, TSQL, ASP.NET, ASP 3.0<br>    Databases: SQL Server, MS Access, Oracle<br>    Graphic Design: PhotoShop, Illustrator, Quark, 3D MAX<br>    Web: Visual Studio 2000/2003/2005, Visual Interdev, Macromedia Products, Photoshop, HTML, AJAX, PHP, XML, FLASH, AS 2.0, 3.0 Web 2.0, CSS, Flex, JHTML<br><br>DETAILED EXPERIENCE<br><br>Contract WorK<br><br>First National Information NetworK, Burbank, CA. 03/2008 - 06/2998<br><br>www.fnin.com. Worked as webmaster and online marketing developer. Manager PPC, CPC, Adwords, Miva, Affiliate, SEO/SEM. Web dev, Classic ASP, and also worked in the IT area. Optimized websites<br><br>www.Jgoodin.com Brea, CA - IT & Web Developer 01/2008  02/2008<br><br>Lead IT manager and Web Developer, worked with Active Directory, Web Servers, Remote desktop, SonicWall Routers, MS Server 2003, IIS, VPN, LAN, WAN, Co-locations, ASP.net, Web Services, XML, ASPDOTNETSTOREFRONT, NetSuite, Analylitics, Overstock.com, Commerce Interface. Adobe CS3 suite,<br><br>Sole Icon, Beverly Hills, CA - Web Developer 01/2008  02/2008<br><br>Implemented Shopping cart solutions for company's clientel via Volutions hosted solutions. Setup e commerce backend and fronted, integrated via XML Flash UI with action script 3.0 and added some Flex contols.<br><br>MBTRADING - Web Developer 9/2007 to 12/2008<br><br>Sr. Web Developer, Develop proprietary sites, utilizing ASP, ASP.net, JavaScript, CSS, XML, WC3 standard, etc, also utilized Visual Safe Source.<br><br> Website maintenance<br><br> Website migration from ASP to ASP.net<br><br> Web application development<br><br> Team of 5<br><br>Northrop Grumman - Web & Multimedia 6/2007 to 9/2007<br><br>Web developer designer, focusing on front-end design, & hand Coded CSS with relational templates, JavaScript, Flash, ActionScript. 2.0 & 3.0, developing 3d and 2d presentations. XML, DOM, DHTML, XLT, Freehand, Dream Weaver, Illustrator, Fireworks, Photoshop, and various other web design tools.<br><br>Power Jam Entertainment  Web & CMS Developer 3/2007 to 6/2007<br><br>Contract<br><br>As Sr. Web Developer, implemented current flash website with new Ektron content management system (CMS)<br><br>    Migrated SQL 2000 to 2005<br>    Improved site upload time by thinning flash elements and vector graphics<br>    Utilized XML schema and service calls to web services<br>    Implemented incorporation of CMS system to Development and Live servers<br>    Setup dev SQL 2005 server via IIS 2.0<br>    Incorporated WC3 compliant XML and CSS framework<br>    Developed in Visual Studio 05, ASP.net<br>    Stored procedures<br>    ActionScript 2.0 & 3.0<br>    Flash game development<br><br>Mazda USA Corporate, Irvine, CA  Multimedia Developer 11/2005 to 2/2007<br><br>I am contracted to administer procedures involved in posting corporate information on intranet and dealer extranet, and eventually redesign current look of intranet and extranet into more consistent brand feel. Utilized flash, and XML for web marketing campaigns. Lastly I was hired to also redesign use of current CMS (content management system).<br><br>    Work centered on Interwoven (CMS)<br>    XML Spy<br>    Flash, AS2<br>    Web services etc.<br>    Macromedia Suite, etc.<br><br>Kelly Blue Book, Irvine, CA (contract) 6/2005 to 11/2005<br><br>Contracted to design and maintain current roster of banner ads. Used Flash MX, and Action Script 2.0 to redesign current list of auto dealer banners, and create new ads for dealers. Ads range from very simple to complex. Company placement of ads varies greatly.<br><br> Worked on mass conversion of HTML base banners and converted them to Flash animations via standard formats.<br><br> Utilized A.S. 1.0 and standard graphic tools.<br><br>MyVideoTalk.com Irvine, CA  Multimedia 2/2005 to6/2005<br><br>Redesigned website and hired as a part time consultant to instruct new clients in use of web based video conferencing system. Site is not what it could be because of all the corporate infighting over departmental ownership.www.myvideotalk.com<br><br> Complete website redesign<br><br> Utilized flash and AS<br><br> Utilized Flash Video and Flash video server,<br><br> Dynamic video feed using XML and Excel<br><br> Utilized Java Script<br><br>Pacific Improvements, North Hollywood, CA. (recurring) 6/2004 to 1/200 2005<br><br>Redesigned company website and incorporated Flash animations and reconstructed navigation and UI, also created Flash ads, banners, coupons, etc. www.pacificimprovements.com<br><br>    Website upgrade<br>    ASP, ASP.net<br>    Flash with AS<br><br>Azzizadeh & Ross Law firm, Beverly Hills, CA (recurring) 6/2004<br><br>Designed and implemented law firms website. Installed legal time management and billing software. I instructed officers, and personnel in use of software. www.azrolaw.com HTML<br><br>    Website design and implementation<br>    Office instruction<br>    Legal software document management installation and training.<br><br>FULLTIME EMPLOYMENT<br><br>Sun Mar Healthcare Inc., Brea, CA. 12/2003  10/2004<br><br>Web Developer<br><br>Developed 21 websites for the companies 21 health care facilities, implemented inviting color scheme, calendar and unique banners for each facility. (see web gallery)<br><br>    Developed21 similar sites for each satellite facility HTML<br>    Utilized CSS, HTML, Flash, AS 1.0<br>	mary keybrsunnyvalley cabr5555555555brbrsummarybrbrwith more that 10 years in web development motion graphics av production graphic design web marketing it and management experience within the past 10 years mr ladd has developed the skill of designing and developing websites and graphics from a blank page his designs are always done with what i consider invaluable input from clientele projects have ranged from small mom  pop shops to mega corporations born with a highly developed right and left brain mr ladd is able to code as well as design this is proven in the fact that mr ladd is right and left handed well versed in meeting milestones of clients within schedule and usually under budget i have proven my worth to companys i have worked for projects have included multiple web sites portals content management systems database migrations flash designs and development with as 10 and 20  30 ajax js xml xhtml jhtml flex css etc project i have developed are largescale websites web banners custom graphics av production cms systems seosem it maintenance and network admin i also have years of experience working direct with clients at all corporate levels including ceos cto vps it directors art directors etcbrskillsbrbr    operating systems win 95982000ntxpnet enterprise serverbr    languages c vb vba tsql aspnet asp 30br    databases sql server ms access oraclebr    graphic design photoshop illustrator quark 3d maxbr    web visual studio 200020032005 visual interdev macromedia products photoshop html ajax php xml flash as 20 30 web 20 css flex jhtmlbrbrdetailed experiencebrbrcontract workbrbrfirst national information network burbank ca 032008  062998brbrwwwfnincom worked as webmaster and online marketing developer manager ppc cpc adwords miva affiliate seosem web dev classic asp and also worked in the it area optimized websitesbrbrwwwjgoodincom brea ca  it  web developer 012008  022008brbrlead it manager and web developer worked with active directory web servers remote desktop sonicwall routers ms server 2003 iis vpn lan wan colocations aspnet web services xml aspdotnetstorefront netsuite analylitics overstockcom commerce interface adobe cs3 suitebrbrsole icon beverly hills ca  web developer 012008  022008brbrimplemented shopping cart solutions for companys clientel via volutions hosted solutions setup e commerce backend and fronted integrated via xml flash ui with action script 30 and added some flex contolsbrbrmbtrading  web developer 92007 to 122008brbrsr web developer develop proprietary sites utilizing asp aspnet javascript css xml wc3 standard etc also utilized visual safe sourcebrbr website maintenancebrbr website migration from asp to aspnetbrbr web application developmentbrbr team of 5brbrnorthrop grumman  web  multimedia 62007 to 92007brbrweb developer designer focusing on frontend design  hand coded css with relational templates javascript flash actionscript 20  30 developing 3d and 2d presentations xml dom dhtml xlt freehand dream weaver illustrator fireworks photoshop and various other web design toolsbrbrpower jam entertainment  web  cms developer 32007 to 62007brbrcontractbrbras sr web developer implemented current flash website with new ektron content management system cmsbrbr    migrated sql 2000 to 2005br    improved site upload time by thinning flash elements and vector graphicsbr    utilized xml schema and service calls to web servicesbr    implemented incorporation of cms system to development and live serversbr    setup dev sql 2005 server via iis 20br    incorporated wc3 compliant xml and css frameworkbr    developed in visual studio 05 aspnetbr    stored proceduresbr    actionscript 20  30br    flash game developmentbrbrmazda usa corporate irvine ca  multimedia developer 112005 to 22007brbri am contracted to administer procedures involved in posting corporate information on intranet and dealer extranet and eventually redesign current look of intranet and extranet into more consistent brand feel utilized flash and xml for web marketing campaigns lastly i was hired to also redesign use of current cms content management systembrbr    work centered on interwoven cmsbr    xml spybr    flash as2br    web services etcbr    macromedia suite etcbrbrkelly blue book irvine ca contract 62005 to 112005brbrcontracted to design and maintain current roster of banner ads used flash mx and action script 20 to redesign current list of auto dealer banners and create new ads for dealers ads range from very simple to complex company placement of ads varies greatlybrbr worked on mass conversion of html base banners and converted them to flash animations via standard formatsbrbr utilized as 10 and standard graphic toolsbrbrmyvideotalkcom irvine ca  multimedia 22005 to62005brbrredesigned website and hired as a part time consultant to instruct new clients in use of web based video conferencing system site is not what it could be because of all the corporate infighting over departmental ownershipwwwmyvideotalkcombrbr complete website redesignbrbr utilized flash and asbrbr utilized flash video and flash video serverbrbr dynamic video feed using xml and excelbrbr utilized java scriptbrbrpacific improvements north hollywood ca recurring 62004 to 1200 2005brbrredesigned company website and incorporated flash animations and reconstructed navigation and ui also created flash ads banners coupons etc wwwpacificimprovementscombrbr    website upgradebr    asp aspnetbr    flash with asbrbrazzizadeh  ross law firm beverly hills ca recurring 62004brbrdesigned and implemented law firms website installed legal time management and billing software i instructed officers and personnel in use of software wwwazrolawcom htmlbrbr    website design and implementationbr    office instructionbr    legal software document management installation and trainingbrbrfulltime employmentbrbrsun mar healthcare inc brea ca 122003  102004brbrweb developerbrbrdeveloped 21 websites for the companies 21 health care facilities implemented inviting color scheme calendar and unique banners for each facility see web gallerybrbr    developed21 similar sites for each satellite facility htmlbr    utilized css html flash as 10br
4	Elsa Birch<br>Education<br><br>Stanford University<br>Doctor of Philosophy (PhD), Chemical Engineering<br>2008  2013<br>Stanford University<br>Masters of Science, Chemical Engineering<br>2008  2012<br>University of Colorado at Boulder<br>Bachelor of Science, Chemical Engineering, Summa Cum Laude<br>2004  2008<br>Activities and Societies: Applied Math Minor<br>Experience<br><br>Senior Associate, Associate<br>Exponent Failure Analysis Associates<br>December 2013  December 2015 (2 years 1 month)Menlo Park<br>Finding answers to our client's tough technical questions! This includes participation in multidisciplinary teams with specific tasks involving:<br>- Rapid technical troubleshooting of appliances, automotive components, etc.<br>- Design and execution of testing to evaluate claims of product performance or failure.<br>- Report preparation and testimony regarding testing performed.<br>Graduate Researcher<br>Stanford University<br>September 2008  November 2013 (5 years 3 months)Palo Alto, California<br>- Updated the fundamental assumptions of Flux Balance Analysis metabolic modeling for short time use cases to enable its use in whole cell models.<br>- Contributed to single cell hybrid model in Python with Git version control.<br>- Developed a computational framework for simulation of bacteriophage Ordinary Differential Equations in the context of bacterial metabolic Flux Balance Analysis. <br>- Implemented complex models in Matlab and designed data visualizations in R. <br>- Constructed population dynamic models of interacting host and viral communities. <br>- Conducted experimental culture and measurement of microbial populations.<br>Senior Design Project Team Member<br>University of Colorado at Boulder<br>2008  2008 (less than a year)Boulder, Colorado<br>- Calculated greenhouse gas footprint according to the GHG Protocol.<br>- Proposed greenhouse gas footprint reduction strategies: wastewater treatment, solar photovoltaic, solar thermal, and boiler upgrades, presented as full engineering report with economic evaluation.<br>Undergraduate Researcher - Nuckolls Lab<br>Columbia University<br>June 2007  August 2007 (3 months)<br>- Synthesized, purified, and verified structure of organic semiconducting compounds.<br>Undergraduate Researcher<br>University of Colorado - Hrenya Lab<br>August 2006  December 2006 (5 months)<br>- Wrote Matlab image analysis scripts to track wetted particles across video of their collision.<br>Engineering Intern<br>TW Environmental<br>June 2006  August 2006 (3 months)Portland, Oregon<br>- Designed and implemented database schema and user interface for employee time entry system in Microsoft Access.<br><br>Interests<br>Cooking, Art, Design<br>Advice for Contacting Elsa<br>The most efficient and direct means of contacting me is email to birch@alumni.stanford.edu<br>Organizations<br><br>American Institute of Chemical Engineers<br>Member<br>Starting January 2010<br>Honors & Awards<br><br>Additional Honors & Awards<br>BioX Fellow Stanford University<br>Certifications<br><br>HAZOP 40 Hour<br>Languages<br><br>English<br>Volunteer Experience & Causes<br><br>Causes Elsa cares about:<br>Arts and Culture<br>Science and Technology	elsa birchbreducationbrbrstanford universitybrdoctor of philosophy phd chemical engineeringbr2008  2013brstanford universitybrmasters of science chemical engineeringbr2008  2012bruniversity of colorado at boulderbrbachelor of science chemical engineering summa cum laudebr2004  2008bractivities and societies applied math minorbrexperiencebrbrsenior associate associatebrexponent failure analysis associatesbrdecember 2013  december 2015 2 years 1 monthmenlo parkbrfinding answers to our clients tough technical questions this includes participation in multidisciplinary teams with specific tasks involvingbr rapid technical troubleshooting of appliances automotive components etcbr design and execution of testing to evaluate claims of product performance or failurebr report preparation and testimony regarding testing performedbrgraduate researcherbrstanford universitybrseptember 2008  november 2013 5 years 3 monthspalo alto californiabr updated the fundamental assumptions of flux balance analysis metabolic modeling for short time use cases to enable its use in whole cell modelsbr contributed to single cell hybrid model in python with git version controlbr developed a computational framework for simulation of bacteriophage ordinary differential equations in the context of bacterial metabolic flux balance analysis br implemented complex models in matlab and designed data visualizations in r br constructed population dynamic models of interacting host and viral communities br conducted experimental culture and measurement of microbial populationsbrsenior design project team memberbruniversity of colorado at boulderbr2008  2008 less than a yearboulder coloradobr calculated greenhouse gas footprint according to the ghg protocolbr proposed greenhouse gas footprint reduction strategies wastewater treatment solar photovoltaic solar thermal and boiler upgrades presented as full engineering report with economic evaluationbrundergraduate researcher  nuckolls labbrcolumbia universitybrjune 2007  august 2007 3 monthsbr synthesized purified and verified structure of organic semiconducting compoundsbrundergraduate researcherbruniversity of colorado  hrenya labbraugust 2006  december 2006 5 monthsbr wrote matlab image analysis scripts to track wetted particles across video of their collisionbrengineering internbrtw environmentalbrjune 2006  august 2006 3 monthsportland oregonbr designed and implemented database schema and user interface for employee time entry system in microsoft accessbrbrinterestsbrcooking art designbradvice for contacting elsabrthe most efficient and direct means of contacting me is email to birchalumnistanfordedubrorganizationsbrbramerican institute of chemical engineersbrmemberbrstarting january 2010brhonors  awardsbrbradditional honors  awardsbrbiox fellow stanford universitybrcertificationsbrbrhazop 40 hourbrlanguagesbrbrenglishbrvolunteer experience  causesbrbrcauses elsa cares aboutbrarts and culturebrscience and technology
\.


--
-- Name: resumes_resume_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('resumes_resume_id_seq', 5, true);


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
2	Jay	Smith	$2b$12$azcgUlr4yQG6gOgAKD7LwOXvF16AgiNGhsL5kVqWs2koGLKXa5iQG	Sometown, NY 11597	js@somedomain.com	+14252143104	jaysmith	jaysmith	Software Developer	130000	2	2016-03-01 16:59:17.38954
3	Mary	Key	$2b$12$sb9pLYZb4cScGv3ktKWDduN7ld64Kn0iQNUXKFAsvho4eO9h3sTK2	San Francisco, CA	marykey@domain.com	+14252143104	mary-key-13247	maryk	Senior Software Engeneer	150000	3	2016-03-01 17:00:30.008948
4	Elsa	Birch	$2b$12$jZh0MqTSMovE1FijLKn9peSVy5P5sDx4JHYcWTRSypwFjkVRQKrM.	Sunnyvalley, CA	elsa@somedomain.com	+14252143104	elsa-birch	elsabirch	Software Developer	100000	4	2016-03-01 17:01:15.542546
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aliaj
--

SELECT pg_catalog.setval('users_user_id_seq', 5, true);


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
    ADD CONSTRAINT interviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;


--
-- Name: users_resume_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: aliaj
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_resume_id_fkey FOREIGN KEY (resume_id) REFERENCES resumes(resume_id) ON DELETE CASCADE;


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

