USE challenges;

SELECT * FROM sample_dataset1; 
SELECT `<ticker>`, ROUND(((`<close>`- `<open>`)/(`<open>`))*100, 2) AS percentage_gain FROM sample_dataset1 
ORDER BY percentage_gain desc limit 5;