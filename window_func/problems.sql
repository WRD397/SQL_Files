										
                                        -- USING SELF JOIN
                                        
-- Return the employees info who have salary greater than avg salary ( INTERVIEW QUEST SCALER)
with base as 
	(select department_id, avg(salary) as avg_sal
    from employees e
    group by department_id)
select * 
from employees emp
join base 
on emp.department_id = base.department_id
where emp.salary > base.avg_sal;


										-- USING WINDOW FNCTION
                                        
select * from
	(select *, 
	AVG(salary) over(partition by department_id) avg_sal
	from employees e) temp
where salary > avg_sal