# Except para la diferencia de valores entre tablas

T-SQL...

```sh
-- Valores que existen en jobsA que no hay en jobsB
Select job_id,job_title,min_salary,max_salary From jobsA
except
Select job_id,job_title,min_salary,max_salary From jobsB

-- Valores que existen en jobsB que no hay en jobsA
Select job_id,job_title,min_salary,max_salary From jobsB
except
Select job_id,job_title,min_salary,max_salary From jobsA
```
