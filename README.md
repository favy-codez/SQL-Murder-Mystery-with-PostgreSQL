# 🕵️ SQL Murder Mystery with PostgreSQL  
 ![SQL Murder Mystery](https://github.com/favy-codez/SQL-Murder-Mystery-with-PostgreSQL/blob/main/murder%20img.jpg) 

This project recreates the **SQL Murder Mystery** challenge using **PostgreSQL**.  
By querying tables such as `crime_scene_report`, `person`, `interview`, `get_fit_now_member`, `drivers_license`, and more, I solved the case step by step:  

- Identified witnesses and gathered interview clues  
- Narrowed suspects using gym check-ins and license plates  
- Confirmed the murderer → **Jeremy Bowers**  
- Discovered the mastermind → **Miranda Priestly**  

This project demonstrates **multi-table joins, filtering, and structured SQL investigation techniques** in a fun, real-world style scenario.  

---

## 📚 Learnings  
- Practiced **multi-table JOINs** to combine information from different sources.  
- Strengthened filtering skills using **WHERE, LIKE, and ranges**.  
- Applied **stepwise logic** to gradually narrow down suspects.  
- Learned the importance of **cross-checking data** (e.g., gym check-ins, car plates, and event attendance).  
- Experienced how SQL can be used for **storytelling and real-world investigations**.  

---

## 🔎 Insights from the Case  
- Witnesses were **Morty Schapiro** and **Annabel Miller**.  
- The murderer was identified as **Jeremy Bowers**.  
- Jeremy confessed he was hired by a wealthy woman.  
- Using license, car, and event data, the mastermind was revealed: **Miranda Priestly**.  
- Miranda Priestly’s income records confirmed her profile as the one who financed the crime.  

---


## How to Run  
1. Create a new PostgreSQL database:  
   ```sql
   CREATE DATABASE police_investigation;
   \c police_investigation;
   ```
2. Import the dataset
3. Run the queries step by step to follow the investigation trail.

## Conclusion
The SQL Murder Mystery was a fun way to practice SQL while telling a story. PostgreSQL became my detective’s magnifying glass, and by piecing together clues across tables, I solved the crime.

#### 👉 Try the original challenge here: https://mystery.knightlab.com/
#### 👉 Full documentation here : https://medium.com/@ezeliorafavour/solving-the-sql-murder-mystery-with-postgresql-93b3df0cc0b2

Case closed. 🕵️
