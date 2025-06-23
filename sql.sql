create database Bank_Loan_Analysis;
truncate table finance_1;
commit;
drop table finance_1;
commit;
select * from finance_1;

SELECT issue_d from finance_1;
select * from finance_2;
select year(issue_d) as Year_of_issue_d
from finance_1;


#KPI 1 Year wise loan amount
select year(issue_d) as Year_of_issue_d, concat("$",format(round(sum(loan_amnt)/1000000,2),2),"M") 
as Total_loan_amnt
from finance_1
group by year_of_issue_d
order by year_of_issue_d;

#KPI 2  Grade and sub grade wise revol _bal
select grade, sub_grade, concat("$",format(round(sum(revol_bal)/1000000,2),2),"M") as total_revol_bal
from finance_1 inner join finance_2
on (finance_1.id=finance_2.id)
group by grade, sub_grade
order by grade, sub_grade;

#KPI 3 Total payment for verified and non- verified status
select verification_status, concat("$",format(round(sum(total_pymnt)/1000000,2),2),"M") as total_payment
from finance_1 inner join finance_2
on (finance_1.id=finance_2.id)
group by verification_status;



#KPI 4 State wise and month wise loan status
Select addr_state, last_Credit_pull_D, loan_Status

from finance_1 inner join finance_2
on(finance_1.id=finance_2.id)
group by addr_state, last_Credit_pull_D, loan_Status
order by last_Credit_pull_D;

#KPI 5 Home ownership Vs last payment date stats
SELECT DATE_FORMAT(last_pymnt_d, '%Y/%m/%d') AS formatted_date
FROM finance_2;
select * from finance_2;


select home_ownership, year(last_pymnt_d),
concat("$",format(round(sum(last_pymnt_amnt)/1000,2),2),"k") as total_payment

from finance_1 inner join finance_2
on(finance_1.id=finance_2.id)
group by
     home_ownership, last_pymnt_d
order by 
     last_pymnt_d desc, home_ownership desc;
     

