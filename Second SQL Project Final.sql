select * from HumanResources.EmployeeDepartmentHistory

select * from AdventureWorks2022.HumanResources.Department


select * from AdventureWorks2022.HumanResources.Employee


select * from HumanResources.EmployeePayHistory

select * from HumanResources.Shift


-- Calculating the Total number of Staff
Select count(BusinessEntityID) TotalStaff  from HumanResources.Employee


-- Calculating the Number of Departments
Select count(Name) as DeptName from HumanResources.Department

-- Checking the Names of all the Department
Select Name as DeptName from HumanResources.Department

-- Calculating Overall Average Staff Tenure
Select AVG(DATEDIFF(Year, HireDate, GetDate())) as AvgStaffTenure from HumanResources.Employee

-- Calculating Overall Average Staff Age
Select AVG(DATEDIFF(Year, BirthDate, GetDate())) as AvgStaffAge from HumanResources.Employee

-- Calculating Average PayRate of Staff
Select AVG(Rate) as Rate from HumanResources.EmployeePayHistory


-- Checking the Years of Operation
Select distinct DATENAME(YEAR, HireDate) Year from HumanResources.Employee
Order by Year


-- Calculating the number of Staff in each Department
Select d.Name, count(*)DepartmentID from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Department d on d.DepartmentID=h.DepartmentID
Group by d.Name
Order by DepartmentID Desc

-- Calculating the Marital Status of Staff using CASE
Select 
		CASE
			When MaritalStatus = 'S' Then 'Single'
			When MaritalStatus = 'M' Then 'Married'
			Else ' '
		End as MaritalStatus,
		Count(*) As NumberOfStaff
		From HumanResources.Employee
		Group by MaritalStatus


-- Calculating the Gender of Staff
Select 
		CASE
			When Gender = 'M' Then 'Male'
			When Gender = 'F' Then 'Female'
			Else ' '
		End as Gender,
		Count(*) As EmployeeGender
		From HumanResources.Employee
		Group by Gender

-- Calculating Staff Gender Distribution 
Select Gender, count(BusinessEntityID) As StaffCount from HumanResources.Employee
Group by Gender
order by StaffCount desc

-- Calculating Gender Distribution in each Department
Select d.Name, e.Gender, count(h.BusinessEntityID) as StaffCount from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Employee e on h.BusinessEntityID=e.BusinessEntityID
Join HumanResources.Department d on d.DepartmentID= h.DepartmentID
Group by d.Name, E.Gender
Order by StaffCount desc


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
		eND AS Tenure
	from HumanResources.Employee
	Order by Tenure desc


-- Calculating the Number of Staff that work each Shift
Select count(h.ShiftID) as StaffCount, s.Name as ShiftName from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Shift s on s.ShiftID=h.ShiftID
Group By s.Name


-- Calculating the Number of Staff that work each Shift in each Department
Select count(h.ShiftID) as StaffCount, s.Name as ShiftName, d.Name as DeptName from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Shift s on s.ShiftID=h.ShiftID
Join HumanResources.Department d on d.DepartmentID = h.DepartmentID
Group By s.Name, d.Name
Order by StaffCount desc


-- Calculating MaritalStatus Distribution of Staff in each Department
Select d.Name, e.MaritalStatus, count(h.BusinessEntityID) as StaffCount from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Employee e on h.BusinessEntityID=e.BusinessEntityID
Join HumanResources.Department d on d.DepartmentID= h.DepartmentID
Group by d.Name, e.MaritalStatus
Order by StaffCount desc


-- Calculating Gender Distribution of Staff in each Department
Select d.Name, e.Gender, count(h.BusinessEntityID) as StaffCount from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Employee e on h.BusinessEntityID=e.BusinessEntityID
Join HumanResources.Department d on d.DepartmentID= h.DepartmentID
Group by d.Name, e.Gender
Order by StaffCount desc


-- Calculating Staff Population each year or staff Trend
Select Year(HireDate) as HireYear, 
Count(BusinessEntityID) AS StaffCount from HumanResources.Employee
gROUP BY Year(HireDate)
Order by StaffCount DESC 


-- Calculate Staff Population and Staff Trend each year in each Department
Select d.Name, Year(e.HireDate) as HireYear, 
Count(h.BusinessEntityID) AS StaffCount from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Department d on d.DepartmentID=h.DepartmentID
Join HumanResources.Employee e on e.BusinessEntityID=h.BusinessEntityID
gROUP BY Year(HireDate),d.Name
Order by StaffCount desc


-- Average PayRate of Staff in each Dept
Select d.Name, Count(h.BusinessEntityID) as Staffcount, AVG(p.Rate) as Rate from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Department d on h.DepartmentID=d.DepartmentID
Join HumanResources.EmployeePayHistory p on p.BusinessEntityID=h.BusinessEntityID
Group by d.Name
Order by Rate DESC


-- Average Staff Tenure in each Department
Select d.Name as Department, AVG(Datediff(Year, e.HireDate, GETDATE())) as AverageStaffTenure from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Department d on d.DepartmentID=h.DepartmentID
Join HumanResources.Employee e on e.BusinessEntityID=h.BusinessEntityID
Group by d.Name
order by AverageStaffTenure desc

-- Average Staff Age in each Department
Select d.Name as Department, AVG(Datediff(Year, e.BirthDate, GETDATE())) as Age from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Department d on d.DepartmentID=h.DepartmentID
Join HumanResources.Employee e on e.BusinessEntityID=h.BusinessEntityID
Group by d.Name
order by Age desc


-- Raping it up
Select h.BusinessEntityID, h.DepartmentID, h.ShiftID, d.Name Department, 
e.BirthDate, e.MaritalStatus, e.Gender, e.HireDate, p.Rate, s.Name as Shift from HumanResources.EmployeeDepartmentHistory h
Join HumanResources.Department d on d.DepartmentID=h.DepartmentID
Join HumanResources.Employee e on e.BusinessEntityID=h.BusinessEntityID
Join HumanResources.EmployeePayHistory p on p.BusinessEntityID=h.BusinessEntityID
Join HumanResources.Shift s on s.ShiftID=h.ShiftID


Power BI

Age = DATEDIFF([BirthDate], TODAY(), YEAR)