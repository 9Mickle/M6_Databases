--------------------------------Students-------------------------------------------
CREATE TABLE public.student
(
    id Serial NOT NULL,
    name character varying(50) COLLATE pg_catalog."default",
    surname character varying(50) COLLATE pg_catalog."default",
    date_of_birth date,
    phone_number numeric,
    primary_skill character varying(50) COLLATE pg_catalog."default",
    created_datetime timestamp without time zone,
    updated_datetime timestamp without time zone,
    CONSTRAINT student_pkey PRIMARY KEY (id),
	CONSTRAINT name_not_like_at Check(name NOT LIKE '%@%'),
	CONSTRAINT name_not_like_grid Check(name NOT LIKE '%#%'),
	CONSTRAINT name_not_like_dollar Check(name NOT LIKE '%$%')
)

TABLESPACE pg_default;

ALTER TABLE public.student
    OWNER to postgres;
	
	
---------------------------------Subjects------------------------------------------
CREATE TABLE public.subject
(
    id integer NOT NULL,
    subject_name character varying(50) COLLATE pg_catalog."default",
    tutor character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT subject_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.subject
    OWNER to postgres;
	
------------------------------Exam_results--------------------------------------------
CREATE TABLE public.exam_result
(
    student_id integer NOT NULL,
    subject_id integer NOT NULL,
    mark integer,
    CONSTRAINT exam_results_student_id_fkey FOREIGN KEY (student_id)
        REFERENCES public.student (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT exam_results_subject_id_fkey FOREIGN KEY (subject_id)
        REFERENCES public.subject (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
	CONSTRAINT mark_limit Check(mark > 1 AND mark < 6)
)

TABLESPACE pg_default;

ALTER TABLE public.exam_result
    OWNER to postgres;
	
------------------------------Student_address-----------------------------------------

-- Table: public.student_address

-- DROP TABLE public.student_address;

CREATE TABLE public.student_address
(
    student_id integer NOT NULL,
    address character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT student_address_student_id_fkey FOREIGN KEY (student_id)
        REFERENCES public.student (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.student_address
    OWNER to postgres;
