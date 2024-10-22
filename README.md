# HR Analysis Project using SQL

## Project Overview
In this project, I conducted a comprehensive analysis of a company's HR data using SQL Server Management Studio (SSMS) and the AdventureWorks2022 database. The objective was to derive key insights related to workforce distribution, employee demographics, compensation, and departmental performance. The analysis spanned five interconnected tables: Shift, Employee, EmployeePayHistory, Department, and EmployeeDepartmentHistory.

## Key Insights Extracted

1) Total Number of Staff: Quantified the overall employee population.
2) Number of Departments: Identified all operational departments within the company.
3) Department Names: Extracted the names of all departments.
4) Average Staff Tenure: Calculate the average time employees have been with the company.
5) Average Staff Age: Analyzed employee age to understand workforce demographics.
6) Average Pay Rate: Derived the average compensation across the company.
7) Years of Operation: Assessed how long the company has been active.
8) Staff Distribution per Department: Analyzed the number of employees in each department.
9) Marital Status of Staff: Examined the marital status distribution among employees.
10) Gender Distribution: Analyzed gender representation across the workforce.
11) Shift Analysis:
- Number of staff working each shift.
- Breakdown of shifts by department.
12) Staff Trends Over Time: Evaluated staff population growth and retention trends over the years.
13) Department-Specific Insights:
- Marital status and gender distribution.
- Average staff tenure, age, and pay rate per department.

## SQL Queries and Techniques Used
To extract these insights, I utilized a range of SQL queries and functions:

- SELECT: To retrieve relevant columns from the tables.
- WHERE: To filter records based on specific conditions.
- CASE: For conditional expressions, such as categorizing data based on custom criteria.
- COUNT, SUM, and AVERAGE: Aggregation functions used to calculate total staff, average pay rates, and tenure.
- DATEDIFF: To compute differences in dates, particularly for tenure and age calculations.
- DATENAME: To extract specific parts of dates, such as the year of joining.
- GROUP BY and ORDER BY: For grouping data by departments or shifts and ordering results for better readability.
- JOINS: To combine data from multiple tables, creating a holistic view of employee and department data.

## Data Analysis

```sq
-- Calculating the Total number of Staff
Select count(BusinessEntityID) TotalStaff  from HumanResources.Employee
```

```sql
-- Calculating the Number of Departments
Select count(Name) as DeptName from HumanResources.Department
```

```sql
-- Checking the Names of all the Departments
Select Name as DeptName from HumanResources.Department
```

```sql
-- Calculating overall Average Staff Tenure
Select AVG(DATEDIFF(Year, HireDate, GetDate())) as AvgStaffTenure from HumanResources.Employee
```

```sql
-- Calculating Overall Average Staff Age
Select AVG(DATEDIFF(Year, BirthDate, GetDate())) as AvgStaffAge from HumanResources.Employee
```

```sql
-- Calculating Average PayRate of Staff
Select AVG(Rate) as Rate from HumanResources.EmployeePayHistory
```

```sql
-- Checking the Years of Operation
Select distinct DATENAME(YEAR, HireDate) Year from HumanResources.Employee
Order by Year
```

```sql
-- Calculating the number of Staff in each Department
Select d.Name, count(*)DepartmentID from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Department d on d.DepartmentID=h.DepartmentID
Group by d.Name
Order by DepartmentID Desc
```

```sql
-- Calculating the Marital Status of Staff using CASE Statement
Select 
		CASE
			When MaritalStatus = 'S' Then 'Single'
			When MaritalStatus = 'M' Then 'Married'
			Else ' '
		End as MaritalStatus,
		Count(*) As NumberOfStaff
		From HumanResources.Employee
		Group by MaritalStatus
```

```sql
-- Calculating the Gender of Staff usinf CASE Statement
Select 
		CASE
			When Gender = 'M' Then 'Male'
			When Gender = 'F' Then 'Female'
			Else ' '
		End as Gender,
		Count(*) As EmployeeGender
		From HumanResources.Employee
		Group by Gender
```

```sql
-- Calculating Staff Gender Distribution 
Select Gender, count(BusinessEntityID) As StaffCount from HumanResources.Employee
Group by Gender
order by StaffCount desc
```

```sql
-- Calculating Gender Distribution in each Department
Select d.Name, e.Gender, count(h.BusinessEntityID) as StaffCount from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Employee e on h.BusinessEntityID=e.BusinessEntityID
Join HumanResources.Department d on d.DepartmentID= h.DepartmentID
Group by d.Name, E.Gender
Order by StaffCount desc
```

```sql
-- Calculating Age of Staff
Select BirthDate, DATEDIFF(Year, BirthDate, GetDate())-
		Case
		When MONTH(BirthDate) > MONTH(GetDate())
			 Or (MONTH (BirthDate) = MONTH(GetDate()) and Day(BirthDate) > Day(GetDate()))
		 Then 1
		 Else 0
		eND AS Age
	from HumanResources.Employee
	Order by Age desc


-- Calculating Staff Tenure
Select HireDate, DATEDIFF(Year, HireDate, GetDate())-
		Case
		When MONTH(HireDate) > MONTH(GetDate())
			 Or (MONTH (HireDate) = MONTH(GetDate()) and Day(HireDate) > Day(GetDate()))
		 Then 1
		 Else 0
		End AS Tenure
	from HumanResources.Employee
	Order by Tenure desc
```

```sql
-- Calculating the Number of Staff that work each Shift
Select count(h.ShiftID) as StaffCount, s.Name as ShiftName from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Shift s on s.ShiftID=h.ShiftID
Group By s.Name
```

```sql
-- Calculating the Number of Staff that work each Shift in each Department
Select count(h.ShiftID) as StaffCount, s.Name as ShiftName, d.Name as DeptName from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Shift s on s.ShiftID=h.ShiftID
Join HumanResources.Department d on d.DepartmentID = h.DepartmentID
Group By s.Name, d.Name
Order by StaffCount desc
```

```sql
-- Calculating MaritalStatus Distribution of Staff in each Department
Select d.Name, e.MaritalStatus, count(h.BusinessEntityID) as StaffCount from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Employee e on h.BusinessEntityID=e.BusinessEntityID
Join HumanResources.Department d on d.DepartmentID= h.DepartmentID
Group by d.Name, e.MaritalStatus
Order by StaffCount desc
```

```sql
-- Calculating Gender Distribution of Staff in each Department
Select d.Name, e.Gender, count(h.BusinessEntityID) as StaffCount from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Employee e on h.BusinessEntityID=e.BusinessEntityID
Join HumanResources.Department d on d.DepartmentID= h.DepartmentID
Group by d.Name, e.Gender
Order by StaffCount desc
```

```sql
-- Calculating Staff Population each year or staff Trend
Select Year(HireDate) as HireYear, 
Count(BusinessEntityID) AS StaffCount from HumanResources.Employee
gROUP BY Year(HireDate)
Order by StaffCount DESC 
```

```sql
-- Calculate Staff Population and Staff Trend each year in each Department
Select d.Name, Year(e.HireDate) as HireYear, 
Count(h.BusinessEntityID) AS StaffCount from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Department d on d.DepartmentID=h.DepartmentID
Join HumanResources.Employee e on e.BusinessEntityID=h.BusinessEntityID
gROUP BY Year(HireDate),d.Name
Order by StaffCount desc
```

```sql
-- Average PayRate of Staff in each Dept
Select d.Name, Count(h.BusinessEntityID) as Staffcount, AVG(p.Rate) as Rate from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Department d on h.DepartmentID=d.DepartmentID
Join HumanResources.EmployeePayHistory p on p.BusinessEntityID=h.BusinessEntityID
Group by d.Name
Order by Rate DESC
```

```sql
-- Average Staff Tenure in each Department
Select d.Name as Department, AVG(Datediff(Year, e.HireDate, GETDATE())) as AverageStaffTenure from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Department d on d.DepartmentID=h.DepartmentID
Join HumanResources.Employee e on e.BusinessEntityID=h.BusinessEntityID
Group by d.Name
order by AverageStaffTenure desc
```

```sql
-- Average Staff Age in each Department
Select d.Name as Department, AVG(Datediff(Year, e.BirthDate, GETDATE())) as Age from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Department d on d.DepartmentID=h.DepartmentID
Join HumanResources.Employee e on e.BusinessEntityID=h.BusinessEntityID
Group by d.Name
order by Age desc
```

```sql
-- Raping it up, I used this join query below to join all five (5) different tables I used for the analysis, which I later exported to Power BI for visualization.
Select h.BusinessEntityID, h.DepartmentID, h.ShiftID, d.Name Department, 
e.BirthDate, e.MaritalStatus, e.Gender, e.HireDate, p.Rate, s.Name as Shift from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Department d on d.DepartmentID=h.DepartmentID
Join HumanResources.Employee e on e.BusinessEntityID=h.BusinessEntityID
Join HumanResources.EmployeePayHistory p on p.BusinessEntityID=h.BusinessEntityID
Join HumanResources.Shift s on s.ShiftID=h.ShiftID
```

## Conclusion:
This project highlights my ability to perform deep analytical work using SQL and relational databases, with a focus on extracting actionable business insights. It demonstrates my proficiency in SQL querying techniques, data manipulation, and the ability to convert raw data into meaningful insights that support HR decision-making. By showcasing this project in my portfolio, I illustrate a clear understanding of how to approach complex business questions and drive data-informed strategies.
