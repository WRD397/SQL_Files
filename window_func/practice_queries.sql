																
															-- WINDOW FUNCTION

select dept_name, max(salary)
from employee 
group by dept_name;

select e.*,
max(salary) over (partition by dept_name) as max_salary
from employee e;
															
                                                            
                                                            -- ROW NUMBER()
select * from 
	(select e.*,
	row_number() over(partition by DEPT_NAME ORDER BY SALARY desc, emp_NAME) as rn
	from employee e) temp
where temp.rn < 3;

															-- RANK()
 
select e.*,

DENSE_RANK() over(partition by DEPT_NAME ORDER BY SALARY desc, emp_NAME) as DNSRnK,
row_number() over(partition by DEPT_NAME ORDER BY SALARY desc, emp_NAME) as rn,
RANK() over(partition by DEPT_NAME ORDER BY SALARY desc, emp_NAME) as rnK
from employee e;

-- RANK DENSE RANK and ROW NUMBER doesnt take any col as argument.


															-- LAG and LEAD

-- Salary increment from previous employee
SELECT X.*,
(SALARY - prev_emp_sal) as sal_inc
from
	(select *,
	lag(SALARY) over(partition by dept_name order by emp_id asc) as prev_emp_sal,
    lag(SALARY,1,0) over(partition by dept_name order by emp_id asc) as demo         -- second arg inside the bracket showing lagging by 2 ie. records of just the previous row and 0 means sql will put 0 instead of null
	from employee e)X;


-- Similarly  lead will just show the next row value.
-- **** Comparison between the current employee salaries and the next employee salaires

select temp.*,
case when SALARY > next_emp_sal and next_emp_sal <> 0 then 'higher than next'
	when SALARY < next_emp_sal then 'lower than next'
    when next_emp_sal = 0 then 'not applicable'
    else 'equal with next' 
    end as comparison
    from
		(select *,
		lead(SALARY,1,0) over(partition by dept_name order by emp_id asc) as next_emp_sal
		from employee) temp