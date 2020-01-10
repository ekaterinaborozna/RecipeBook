public class SOQL {
 // All contacts who know English at least Medium level(use operator In here)
 //SELECT Contact__r.Name, Skill_Assignment__c.Level__c, Skill__r.Name FROM Skill_Assignment__c Where Skill_Assignment__c.Level__c not in ('Low', 'Medium') AND Skill__r.Name ='English' AND Skill_Assignment__c.Level__c !=null

  //Departments with average salary less than 450
  //SELECT Department__r.Name, FORMAT(Avg(Salary__c)) FROM Contact GROUP BY Department__r.Name HAVING Avg(Salary__c)>450
  
  //Department with the highest average salary
  //SELECT Department__r.Name, FORMAT(Avg(Salary__c)) FROM Contact GROUP BY Department__r.Name HAVING Avg(Salary__c)!=null ORDER BY Avg(Salary__c) DESC LIMIT 1
  
  //All contacts who have First Name starting with ‘A’ character
  //SELECT FirstName FROM Contact WHERE FirstName LIKE 'A%'
  
  //Three most popular skills
  //SELECT  Skill__r.Name, COUNT(Id) FROM Skill_Assignment__c GROUP BY Skill__r.Name ORDER BY COUNT(Id) DESC LIMIT 3


}