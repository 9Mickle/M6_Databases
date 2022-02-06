Copy student From 'C:\run\students.csv' Delimiter ',' CSV Header;
Copy subject From 'C:\run\subjects.csv' Delimiter ',' CSV Header;
Copy exam_result From 'C:\run\marks.csv' Delimiter ',' CSV Header;

--------------Point 4--------------------

Explain Analyze Select * From student Where name = 'Misha'
Explain Analyze Select * From student Where surname like 'Hob%'
Explain Analyze Select * From student Where Cast(phone_number As Varchar(11)) like '79%' 

Explain Analyze 
Select s.* From student s 
Inner Join exam_result er
On s.id = er.student_id
Where s.surname like 'Hob%'

--------------Point 8--------------------
Create or Replace Function get_avg_mark_by_user(id integer) Returns numeric As $$
	Select Cast(AVG(mark) as decimal(5,2)) 
		As average_mark From exam_result Where student_id = id;
$$ Language SQL;

Select get_avg_mark_by_user(101);

--------------Point 9--------------------
Create or Replace Function get_avg_mark_by_subject(id integer) Returns numeric As $$
	Select Cast(AVG(mark) as decimal(5,2)) 
		As average_mark From exam_result Where subject_id = id;
$$ Language SQL;
	
Select get_avg_mark_by_subject(100);

--------------Point 10--------------------
Create or Replace Function red_zone_users() 
	Returns Table(id integer, name text, surname text) As $$
		Select s.id, s.name, s.surname  --Count(er.mark) as count_bad_marks 
		From student s 
		Inner Join exam_result er
		On s.id = er.student_id
		Where er.mark < 4 
		Group By s.id
		Having Count(er.mark) >= 2;
$$ Language SQL;

Select red_zone_users();
