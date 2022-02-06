------------Point 5-------------
Create Or Replace Function set_time() Returns Trigger As $$
Begin
	NEW.updated_datetime = Now()::timestamp;
	Return New;
End;
$$ Language plpgsql;

Create Trigger update_datetime
Before Insert Or Update 
On student 
For Each Row 
EXECUTE PROCEDURE set_time();

------------Point 12-------------
Insert Into student_address(student_id, address) Values(100, 'Street-1');
Insert Into student_address(student_id, address) Values(101, 'Street-2');
Insert Into student_address(student_id, address) Values(102, 'Street-3');

Create Or Replace Function throw_exception_message() Returns Trigger As $$
Begin
	Raise Exception 'You cannot change the data in this table';
End;
$$ Language plpgsql;

Create Trigger ban_on_changes
Before Update
On student_address
For Each Row 
EXECUTE PROCEDURE throw_exception_message();

--Операция получит исключение.
Update student_address Set address = 'New Street' Where student_id = 100;

