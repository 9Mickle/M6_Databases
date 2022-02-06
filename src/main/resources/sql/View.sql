--------------Point 7----------------------
Create View mark_student_of_subject As
	Select s.name, s.surname, sub.subject_name, er.mark
	From student s
	Inner Join exam_result er
		On s.id = er.student_id 
	Inner Join subject sub
		On sub.id = er.subject_id
	Limit 10

Update mark_student_of_subject Set name = 'Misha' Where surname = 'Hoban';
Select * From mark_student_of_subject;
